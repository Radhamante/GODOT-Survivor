shader_type canvas_item;

uniform vec2 offset = vec2(0.0);

void fragment() {
	vec2 uv_offset = UV + offset;
	COLOR = texture(TEXTURE, uv_offset);
}
