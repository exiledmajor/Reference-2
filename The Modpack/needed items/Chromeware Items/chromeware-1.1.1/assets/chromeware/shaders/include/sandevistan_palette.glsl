uniform vec3 PaletteShadow;
uniform vec3 PaletteDark;
uniform vec3 PaletteMidtone;
uniform vec3 PaletteHighlight;

vec3 sandevistan_palette(vec3 source) {
    float value = clamp(dot(source, vec3(0.2126, 0.7152, 0.0722)), 0.0, 1.0);
    if (value < 0.20) return mix(PaletteShadow, PaletteDark, smoothstep(0.0, 0.20, value));
    if (value < 0.60) return mix(PaletteDark, PaletteMidtone, smoothstep(0.20, 0.60, value));
    return mix(PaletteMidtone, PaletteHighlight, smoothstep(0.60, 1.0, value));
}
