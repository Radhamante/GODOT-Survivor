shader_type canvas_item;

uniform sampler2D main_texture;
uniform sampler2D alpha_mask;

void fragment() {
    vec4 color = texture(main_texture, UV);
    float mask_alpha = texture(alpha_mask, UV).r; // On prend le canal rouge du masque
    color.a *= mask_alpha;
    COLOR = color;
}
