
uniform mat4 worldViewProj;
uniform vec4 totalColor;

attribute vec4 vertex;
attribute vec2 uv0;

varying vec2 out_uv;
varying vec4 out_color;

void main()
{
	out_color = totalColor;	
	out_uv = uv0;
	gl_Position = worldViewProj * vertex;	
}
