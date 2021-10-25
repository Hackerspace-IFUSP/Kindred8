shader_type canvas_item;

render_mode blend_mix;


uniform vec2 offset = vec2(0.02, 0.02);
uniform float speed_offset = 1.0;
uniform float speed_shadow = 0.1;
uniform vec4 modulate : hint_color;
//uniform float shadow_size :hint_range(0.5,2.,0.05) = .95;

uniform vec2 texture_size; //uncomment for GLES2

const float PI = 3.14159265358979323846;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

/**void vertex(){
	VERTEX.x = VERTEX.y + VERTEX.x*cos(TIME);
	VERTEX.y = VERTEX.x + VERTEX.y*cos(TIME + PI);
	
}**/

void fragment() {
	vec2 ps = TEXTURE_PIXEL_SIZE;
	vec2 uv = UV;

	float sizex = texture_size.x; //uncomment for GLES2
	float sizey = texture_size.y; //uncomment for GLES2
	
	//uv.y+=offset.y*ps.y + offset.y*sin(TIME*speed_offset);
	uv.x+=offset.x*ps.x + offset.x*cos(TIME*speed_offset);
	
	//vec2 timefunc = vec2(cos(TIME*1000.0),0);
	
	//uv.y+=offset.y*ps.y + offset.y*cos(random(timefunc) + TIME);
	//uv.x+=offset.x*ps.x + offset.x*cos(random(timefunc) + TIME);
	
	float shadow_var = 1.1*abs(cos(TIME*speed_shadow));
	float shadow_size = clamp(shadow_var, 0.95, 1.1);
 	vec4 shadow = vec4(modulate.rgb, texture(TEXTURE, shadow_size*uv + (1. - shadow_size)/2.).a * modulate.a);
	vec4 col = texture(TEXTURE, UV);
	COLOR = mix(shadow, col, col.a);
}