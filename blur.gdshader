shader_type canvas_item;
render_mode unshaded;

uniform float strength : hint_range(0.0, 10.0) = 7;
uniform float opacity : hint_range(0.0, 1.0) = 0.3;
uniform int sample_power : hint_range(3, 8, 1) = 4;
uniform bool is_canvas_group = false;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

vec2 rotate(vec2 v, float angle) {
	mat2 rotation_matrix = mat2(vec2(cos(angle), sin(angle)), vec2(-sin(angle), cos(angle)));
	return v * rotation_matrix;
}

void fragment() {
	vec2 pixel_size = is_canvas_group ? SCREEN_PIXEL_SIZE : TEXTURE_PIXEL_SIZE;
	vec2 uv = is_canvas_group ? SCREEN_UV : UV;

	float samples = float(pow(2.0, float(sample_power)));
	float layer_increment = strength / samples;
	float angle_increment = TAU / samples;

	// On va uniquement accumuler l'**alpha** pour flouter la forme.
	float alpha = 0.0;

	// Premier échantillon : pixel central
	vec4 base_color;
	if (is_canvas_group) {
		base_color = textureLod(screen_texture, uv, 0.0);
	} else {
		base_color = textureLod(TEXTURE, uv, 0.0);
	}
	alpha += base_color.a;

	// Flou radial
	for (float d = layer_increment; d <= strength && strength > 0.0; d += layer_increment) {
		float layer_alpha = 0.0;

		for (float t = 0.0; t < TAU; t += angle_increment) {
			vec2 sample_uv = uv + rotate(pixel_size * d, t);
			vec4 sample_color;
			if (is_canvas_group) {
				sample_color = textureLod(screen_texture, sample_uv, 0.0);
			} else {
				sample_color = textureLod(TEXTURE, sample_uv, 0.0);
			}
			layer_alpha += sample_color.a;
		}

		layer_alpha /= samples;
		float weight = 1.0 - sqrt(d / strength);
		alpha = mix(alpha, layer_alpha, weight);
	}

	// Sortie : couleur noire + alpha flouté
	COLOR = vec4(0.0, 0.0, 0.0, alpha * opacity);
}
