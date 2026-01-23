/// @description Draw pathfinding grid visualization

// Draw pathfinding grid when holding Alt
// This draws in world coordinates, so it works with the camera/viewport
if keyboard_check(vk_alt) {
	draw_set_color(c_white);
	if (global.mp_grid != noone) {
		draw_set_alpha(0.5);
		mp_grid_draw(global.mp_grid);
		draw_set_alpha(1);
	}
}
