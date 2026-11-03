#version 150

uniform sampler2D DiffuseSampler;
uniform vec2 InSize;
uniform float BerserkTime;
uniform float Strength;
uniform float Impulse;
uniform float Distortion;
in vec2 texCoord;
out vec4 fragColor;

vec3 sampleAt(vec2 uv) { return texture(DiffuseSampler, clamp(uv, vec2(0.001), vec2(0.999))).rgb; }

void main() {
    vec2 uv = texCoord;
    vec3 original = sampleAt(uv);
    if (Strength <= 0.001) { fragColor = vec4(original, 1.0); return; }
    vec2 centre = uv - 0.5;
    float edge = smoothstep(0.18, 0.67, length(centre * vec2(1.1, 1.0)));

    float beat = pow(max(0.0, sin(BerserkTime * 7.2)), 8.0) + 0.35 * pow(max(0.0, sin(BerserkTime * 7.2 - 1.1)), 12.0);
    float pressure = Impulse * Distortion;
    vec2 at = uv - centre * 0.018 * pressure;
    float tear = sin(floor(uv.y * 36.0) * 2.4 + BerserkTime * 29.0) * 0.002 * pressure * edge;
    at.x += tear;
    vec2 split = centre * (0.0018 + 0.008 * Impulse) * edge * Strength * Distortion;
    vec3 scene = vec3(sampleAt(at + split).r, sampleAt(at).g, sampleAt(at - split).b);
    float luminance = dot(scene, vec3(0.2126, 0.7152, 0.0722));

    vec3 red = vec3(luminance * 1.08 + scene.r * 0.15, luminance * 0.49 + scene.g * 0.13, luminance * 0.42 + scene.b * 0.09);
    red = (red - 0.5) * 1.08 + 0.5;
    red = mix(red, vec3(0.24, 0.009, 0.017), edge * (0.32 + 0.07 * beat));
    red += vec3(0.085, 0.013, 0.004) * Impulse;

    red *= 1.0 - edge * 0.025 * (0.5 + 0.5 * sin(uv.y * InSize.y * 3.14159265));
    fragColor = vec4(mix(original, clamp(red, 0.0, 1.0), Strength), 1.0);
}
