#version 150

uniform sampler2D DiffuseSampler;
uniform vec2 InSize;
uniform float Time;
uniform float Strength;
uniform float Seed;
uniform float Heavy;
uniform float Organic;
in vec2 texCoord;
out vec4 fragColor;

float hash(vec2 p) { return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453); }
vec3 sampleAt(vec2 uv) { return texture(DiffuseSampler, clamp(uv, vec2(0.001), vec2(0.999))).rgb; }

vec3 organic(vec2 uv) {
    vec2 centre = uv - vec2(0.5);

    vec2 zoomed = vec2(0.5) + centre * (1.0 - 0.025 * Strength - 0.02 * Heavy);
    float drift = (0.008 + 0.012 * Heavy) * Strength * (0.7 + 0.3 * sin(Time * 5.0 + Seed));
    vec3 color = mix(sampleAt(zoomed), sampleAt(zoomed + vec2(drift, drift * 0.35)), 0.45 * Strength);
    float grey = dot(color, vec3(0.299, 0.587, 0.114));
    color = mix(color, vec3(grey), 0.35 * Strength);

    float edge = smoothstep(0.12, 0.75, length(centre * vec2(1.25, 1.0)));
    float vignette = edge * (0.8 + 0.2 * Heavy) * Strength;
    color *= mix(vec3(1.0), vec3(1.08, 0.86, 0.86), Strength);
    color = mix(color, vec3(0.22, 0.0, 0.02), vignette);
    return color;
}

void main() {
    vec2 uv = texCoord;
    if (Strength <= 0.001) {
        fragColor = vec4(sampleAt(uv), 1.0);
        return;
    }
    if (Organic > 0.5) {
        fragColor = vec4(organic(uv), 1.0);
        return;
    }

    float frame = floor(Time * 20.0) + Seed * 17.0;
    float bands = mix(14.0, 42.0, hash(vec2(Seed, frame)));
    float band = floor(uv.y * bands);
    float torn = step(1.0 - (0.28 * Strength + 0.22 * Heavy), hash(vec2(band, frame)));
    float tear = torn * (hash(vec2(band * 1.7, frame + 3.1)) - 0.5) * (0.10 + 0.08 * Heavy) * Strength;

    vec2 block = floor(uv * vec2(22.0, 12.0));
    float moved = step(1.0 - (0.06 * Strength + 0.10 * Heavy), hash(block + vec2(frame, Seed)));
    vec2 shift = moved * (vec2(hash(block + 1.3 + frame), hash(block + 7.1 + frame)) - 0.5) * 0.09;
    vec2 at = uv + vec2(tear, 0.0) + shift;

    float split = (0.003 + 0.010 * Strength + 0.012 * Heavy) * (0.65 + 0.35 * sin(Time * 37.0 + Seed * 6.0));
    vec3 color = vec3(sampleAt(at + vec2(split, 0.0)).r, sampleAt(at).g, sampleAt(at - vec2(split, 0.0)).b);

    float scan = 0.90 + 0.10 * sin(uv.y * InSize.y * 3.14159);
    color *= mix(1.0, scan, Strength);

    vec3 red = vec3(color.r * 1.25 + 0.06, color.g * 0.70, color.b * 0.80);
    color = mix(color, red, 0.30 * Strength + 0.30 * Heavy);
    float line = step(0.988 - 0.020 * Strength, hash(vec2(floor(uv.y * InSize.y * 0.5), frame)));
    vec3 lineColor = hash(vec2(frame, band)) > 0.5 ? vec3(1.0, 0.16, 0.24) : vec3(0.20, 0.95, 1.0);
    color = mix(color, lineColor, line * 0.55 * Strength);
    fragColor = vec4(color, 1.0);
}
