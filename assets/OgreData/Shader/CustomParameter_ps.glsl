


uniform sampler2D diffuse_texture;



varying vec2 out_uv;
varying vec4 out_color;


void main ()
{
   	vec4 texture_color = texture2D(diffuse_texture, out_uv);
	vec4 mix_color = texture_color * out_color;
	gl_FragColor = mix_color;

}

