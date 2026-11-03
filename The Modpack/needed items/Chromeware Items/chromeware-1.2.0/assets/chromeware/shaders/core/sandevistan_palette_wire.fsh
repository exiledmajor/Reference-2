#version 150

#moj_import <fog.glsl>
#moj_import <chromeware:sandevistan_palette.glsl>

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
in float vertexDistance;
in vec4 vertexColor;
out vec4 fragColor;

void main() {
    vec4 source = vertexColor * ColorModulator;
    if (source.a <= 0.0) discard;
    fragColor = linear_fog(vec4(sandevistan_palette(source.rgb), 1.0), vertexDistance, FogStart, FogEnd, FogColor);
}
