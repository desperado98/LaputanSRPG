
uniform mat4 worldViewProj;
uniform vec4 totalColor;
uniform vec4 customColor;


attribute vec4 vertex;
attribute vec2 uv0;

varying vec2 out_uv;
varying vec4 out_color;

void main()
{
	out_color = totalColor * customColor//vec4(totalColor.x * customColor.x, totalColor.y * customColor.y, totalColor.z * customColor.z, totalColor.w * customColor.w);	

	out_uv = uv0;
	gl_Position = worldViewProj * vertex;	
}
