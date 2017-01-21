

uniform sampler2D diffuse_texture;

#if FOG_ON == 1
uniform vec4 in_fog_data;
#endif

varying vec2 out_uv;
varying vec4 out_color;

void main(void)
{

	vec4 texture_color = texture2D(diffuse_texture, out_uv);
	vec4 mix_color = texture_color * out_color;

#if FOG_ON == 1
	float alpha = mix_color.w;
	vec3 fog_color =  in_fog_data.xyz;
	float fog_value = in_fog_data.w;

	vec3 origin_color = mix_color.xyz;    	
	vec3 origin_color_minus = vec3(1 - fog_value,1 - fog_value,1 - fog_value);
	vec3 origin_color_rate = origin_color * origin_color_minus;

	vec3 fog_rate = vec3(fog_value,fog_value,fog_value);
	vec3 fog_color_rate = fog_color * fog_rate;
        vec3 last_color = origin_color_rate + fog_color_rate;
        mix_color = vec4(last_color.xyz,alpha); 	
#endif

	gl_FragColor = mix_color;
}


