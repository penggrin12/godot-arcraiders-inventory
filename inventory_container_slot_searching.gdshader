shader_type canvas_item;

uniform vec3 shine_color: source_color = vec3(1);
uniform float alpha_mult = 1.0;

void fragment() {
	float line = clamp(0.35 - abs(sin(TIME * 3.0 + UV.y)), 0, 1);
	COLOR = vec4(shine_color, line * alpha_mult);
}
