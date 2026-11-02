#version 150
#moj_import <fog.glsl>
uniform sampler2D Sampler0;
uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
in float vertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec4 overlayColor;
in vec2 texCoord0;
out vec4 fragColor;
void main() {
    vec4 source = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (source.a < 0.1) discard;
    source.rgb = mix(overlayColor.rgb, source.rgb, overlayColor.a);
    source *= lightMapColor;
    fragColor = linear_fog(source, vertexDistance, FogStart, FogEnd, FogColor);
}
