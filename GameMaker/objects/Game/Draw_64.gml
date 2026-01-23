/// @description Debug Menu and Grid Visualization

// Draw pathfinding grid when holding Alt
if keyboard_check(vk_alt) {
	draw_set_color(c_white);
	if (global.mp_grid != noone) {
		draw_set_alpha(0.5);
		mp_grid_draw(global.mp_grid);
		draw_set_alpha(1);
		draw_text(10, 10, "Grid active - Green=walkable, Red=blocked");
	} else {
		draw_text(10, 10, "Grid not initialized! Value: " + string(global.mp_grid));
		draw_text(10, 30, "Game exists: " + string(instance_exists(Game)));
	}
}

// Toggle debug stats menu with Ctrl key
if (keyboard_check_pressed(vk_control)) {
	global.show_debug = !global.show_debug;
	show_debug_message("Debug stats toggled: " + string(global.show_debug));
}

// Draw debug menu if enabled
if (global.show_debug) {
	var _x = 10;
	var _y = 10;
	var _line_height = 20;

	// Draw semi-transparent background
	draw_set_alpha(0.8);
	draw_set_color(c_black);
	draw_rectangle(_x - 5, _y - 5, _x + 450, _y + 220, false);
	draw_set_alpha(1);

	// Draw debug info
	draw_set_color(c_lime);
	draw_set_font(-1);

	draw_text(_x, _y, "=== DEBUG MENU (Alt to toggle) ===");
	_y += _line_height * 1.5;

	// FPS
	draw_text(_x, _y, "FPS: " + string(fps));
	_y += _line_height;

	// Room info
	draw_text(_x, _y, "Room: " + room_get_name(room));
	_y += _line_height;

	// Grid status
	var grid_status = "NOT INITIALIZED";
	if (variable_global_exists("mp_grid") && global.mp_grid != noone) {
		grid_status = "INITIALIZED (ID: " + string(global.mp_grid) + ")";
	}
	draw_text(_x, _y, "MP Grid: " + grid_status);
	_y += _line_height;

	// Instance counts
	draw_text(_x, _y, "Enemies: " + string(instance_number(Enemy)));
	_y += _line_height;
	draw_text(_x, _y, "Walls: " + string(instance_number(Wall)));
	_y += _line_height;
	draw_text(_x, _y, "Players: " + string(instance_number(Player)));
	_y += _line_height;

	// Player position if exists
	if (instance_exists(Player)) {
		draw_text(_x, _y, "Player pos: (" + string(round(Player.x)) + ", " + string(round(Player.y)) + ")");
		_y += _line_height;
	}

	// Enemy info if exists
	if (instance_exists(Enemy)) {
		var _enemy = instance_find(Enemy, 0);
		if (variable_instance_exists(_enemy, "alert")) {
			if (instance_exists(Player)) {
				var _dist = point_distance(_enemy.x, _enemy.y, Player.x, Player.y);
				draw_text(_x, _y, "Enemy alert: " + string(_enemy.alert) + " | Distance: " + string(round(_dist)));
			} else {
				draw_text(_x, _y, "Enemy alert: " + string(_enemy.alert) + " | No player");
			}
		}
	}

	// Reset color
	draw_set_color(c_white);
}