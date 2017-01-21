
uniform mat4 worldViewProj;
uniform vec4 totalColor;
uniform vec4 customColor;


attribute vec4 vertex;
attribute vec2 uv0;

varying vec2 out_uv;
varying vec4 out_color;

void main()
{
	vec4 myColor = totalColor * customColor;
	out_color = myColor;
	out_uv = uv0;
	gl_Position = worldViewProj * vertex;	
}
