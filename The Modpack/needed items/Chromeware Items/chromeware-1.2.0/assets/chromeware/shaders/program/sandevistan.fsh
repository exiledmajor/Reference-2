#version 150
uniform sampler2D DiffuseSampler;
uniform sampler2D AfterimagesSampler;
uniform sampler2D AfterimagesDepthSampler;
uniform sampler2D LiveSampler;
uniform sampler2D SceneDepthSampler;
uniform sampler2D EntityDepthSampler;
uniform vec2 InSize;
uniform float WorldTime;
uniform float SandevistanStrength;
uniform float SandevistanMovement;
uniform float SandevistanPulse;
uniform float TimeDilationStyle;
uniform float AfterimageStrength;
uniform float EntityMask;
uniform float EchoFade;
in vec2 texCoord;
out vec4 fragColor;
float luminance(vec3 color) { return dot(color, vec3(0.2126, 0.7152, 0.0722)); }
vec2 safeUv(vec2 uv) { return clamp(uv, vec2(0.001), vec2(0.999)); }
float viewDistance(float depth) { return 0.05 / max(1.0 - depth, 0.000001); }
float echoOpacity(vec2 uv) {
    float distance = viewDistance(texture(AfterimagesDepthSampler, uv).r);
    if (EntityMask > 0.5) {
        float entity = texture(EntityDepthSampler, uv).r;
        if (entity < texture(SceneDepthSampler, uv).r && distance < viewDistance(entity) - 0.1) return 0.0;
    }
    return EchoFade > 0.5 ? mix(0.15, 1.0, smoothstep(1.0, 5.0, distance)) : 1.0;
}
vec3 over(vec3 color, vec4 layer) {
    return layer.rgb * AfterimageStrength + color * (1.0 - clamp(layer.a * AfterimageStrength, 0.0, 1.0));
}
vec2 sandevistanOffset(vec2 uv) {
    if (SandevistanStrength <= 0.0001) return vec2(0.0);
    float refraction = 0.68 + SandevistanMovement * 0.22 + SandevistanPulse * 0.25;
    float broadHorizontal = sin(uv.y * 23.0 + WorldTime * 0.065
        + sin(uv.x * 6.0 - WorldTime * 0.021) * 1.25);
    float mediumHorizontal = sin(uv.y * 57.0 - WorldTime * 0.1025 + uv.x * 9.0);
    float fineHorizontal = sin(uv.y * 119.0 + WorldTime * 0.14 - uv.x * 13.0);
    float broadVertical = sin(uv.x * 31.0 - WorldTime * 0.0575
        + sin(uv.y * 10.0 + WorldTime * 0.0275));
    float fineVertical = sin(uv.x * 73.0 + WorldTime * 0.105 + uv.y * 8.0);
    return vec2(broadHorizontal * 0.0065 + mediumHorizontal * 0.0030 + fineHorizontal * 0.0012,
        broadVertical * 0.0034 + fineVertical * 0.0013) * refraction * SandevistanStrength;
}

vec3 applySandevistan(vec3 color, vec2 uv, vec2 aspect) {
    if (SandevistanStrength <= 0.0001) return color;
    float radius = length((uv - vec2(0.5)) * aspect) / 0.72;
    float peripheral = smoothstep(0.20, 0.92, radius);
    float light = luminance(color);
    float lifted = pow(clamp(light * 1.15 + 0.03, 0.0, 1.0), 0.78);
    vec3 greenGrade = mix(vec3(0.01, 0.06, 0.02), vec3(0.50, 1.0, 0.42), lifted);
    greenGrade += (color - vec3(light)) * vec3(0.30, 0.12, 0.18);
    vec3 cyanGrade = vec3(
        color.r * 0.30 + light * 0.12,
        color.g * 0.68 + light * 0.33,
        color.b * 0.92 + light * 0.48
    );
    float legacyStyle = step(0.5, TimeDilationStyle);
    vec3 timeDilationGrade = mix(cyanGrade, greenGrade, legacyStyle);
    color = mix(color, timeDilationGrade, mix(0.54 + peripheral * 0.12, 0.90, legacyStyle) * SandevistanStrength);
    float scan = 0.5 + 0.5 * sin(uv.y * InSize.y * 1.5708 + WorldTime * 0.6);
    color *= 1.0 - scan * 0.07 * legacyStyle * SandevistanStrength;
    color = mix(color, (color - 0.5) * 1.08 + 0.5, SandevistanStrength);
    color *= 1.0 - smoothstep(0.48, 1.02, radius) * mix(0.50, 0.38, legacyStyle) * SandevistanStrength;
    vec3 pulseColor = mix(vec3(0.02, 0.30, 0.62), vec3(0.03, 0.48, 0.24), legacyStyle);
    color += pulseColor * SandevistanPulse * (0.10 + peripheral * 0.14);
    return clamp(color, 0.0, 1.0);
}
void main() {
    vec2 aspect = vec2(InSize.x / max(InSize.y, 1.0), 1.0);
    vec2 offset = sandevistanOffset(texCoord);
    vec2 sceneUv = safeUv(texCoord + offset);
    vec3 color = texture(DiffuseSampler, sceneUv).rgb;
    float chromatic = (length(offset) * 0.16 + SandevistanMovement * 0.0025) * SandevistanStrength;
    if (chromatic > 0.00001) {
        vec2 radial = normalize((texCoord - vec2(0.5)) + vec2(0.0001));
        color.r = texture(DiffuseSampler, safeUv(sceneUv + radial * chromatic)).r;
        color.b = texture(DiffuseSampler, safeUv(sceneUv - radial * chromatic * 1.2)).b;
    }
    color = applySandevistan(color, texCoord, aspect);
    vec4 afterimage = texture(AfterimagesSampler, texCoord);
    if (afterimage.a > 0.0) afterimage *= echoOpacity(texCoord);
    color = over(color, afterimage);
    color = over(color, texture(LiveSampler, texCoord));
    fragColor = vec4(color, 1.0);
}
