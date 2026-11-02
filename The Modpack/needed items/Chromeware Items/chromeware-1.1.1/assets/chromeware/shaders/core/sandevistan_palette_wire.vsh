#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform mat4 EchoTransform;

out float vertexDistance;
out vec4 vertexColor;

void main() {
    vec3 position = (EchoTransform * vec4(Position, 1.0)).xyz;
    gl_Position = ProjMat * ModelViewMat * vec4(position, 1.0);
    vertexDistance = fog_distance(position, FogShape);
    vertexColor = Color;
}
