/// @description Draw enemy and path debug

draw_self();

// Draw path when Alt or P is held for debugging
if (keyboard_check(vk_alt) || keyboard_check(ord("P"))) {
	if (path_index != -1) {
		draw_set_color(c_yellow);
		draw_set_alpha(0.8);
		draw_path(path, x, y, true);
		draw_set_alpha(1);
		draw_set_color(c_white);
	}
}