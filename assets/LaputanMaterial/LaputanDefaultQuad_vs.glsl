

uniform mat4 worldViewProj;

attribute vec4 vertex;
attribute vec2 uv0;
attribute vec4 colour;

varying vec2 out_uv;
varying vec4 out_color;

void main()
{
	out_color = colour;	
	out_uv = uv0;
	gl_Position = worldViewProj * vertex;	
}


