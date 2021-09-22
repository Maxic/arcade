shader_type canvas_item;
render_mode blend_mul;
uniform float scroll_speed;

void fragment() {
	vec2 shifteduv = UV;
	shifteduv.y += scroll_speed;
	vec4 color = texture(TEXTURE, shifteduv);
	COLOR = color;
}