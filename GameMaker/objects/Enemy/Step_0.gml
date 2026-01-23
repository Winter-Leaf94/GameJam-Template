// movement for enemy AI
// Check if player is within alert distance
if (instance_exists(Player)) {
	var _dis = distance_to_object(Player);
	if (_dis <= alert_dis) {
		if (!alert) {
			show_debug_message("Enemy alerted! Player within range: " + string(_dis));
		}
		alert = true;
	} else {
		alert = false;
	}
} else {
	alert = false;
}

// Debug once per second
if (current_time mod 1000 < 16) {
	var grid_status = variable_global_exists("mp_grid") ? string(global.mp_grid) : "not initialized";
	show_debug_message("Alert: " + string(alert) + " | Distance: " + string(distance_to_object(Player)) + " | Timer: " + string(calc_path_timer) + " | Grid: " + grid_status + " | path_index: " + string(path_index) + " | speed: " + string(speed) + " | path_speed: " + string(path_speed));
}

// Only path if player is within alert distance and grid exists
if (alert) {
	if (!variable_global_exists("mp_grid") || global.mp_grid == noone) {
		show_debug_message("ERROR: Grid not initialized or is noone!");
	} else {
		// Countdown the timer
		calc_path_timer--;

		//conditions for checking path
		if (calc_path_timer <= 0) {
			//reset timer
			calc_path_timer = calc_path_delay;

			// Use current position for pathfinding (no snapping mid-movement)
			var start_x = x;
			var start_y = y;
			var player_grid_x = round(Player.x / grid_size) * grid_size + grid_size / 2;
			var player_grid_y = round(Player.y / grid_size) * grid_size + grid_size / 2;

			// Make Path to the player - disable diagonals to avoid corner issues
			show_debug_message("Calculating path from (" + string(start_x) + "," + string(start_y) + ") to player at (" + string(player_grid_x) + "," + string(player_grid_y) + ")");
			var found_Player = mp_grid_path(global.mp_grid, path, start_x, start_y, player_grid_x, player_grid_y, false);

			// start path if player can be reached
			if (found_Player) {
				path_end();
				path_start(path, move_spd, path_action_stop, false);
				show_debug_message("Path started! Speed: " + string(move_spd) + " | Path length: " + string(path_get_length(path)) + " | Points: " + string(path_get_number(path)));
			} else {
				show_debug_message("No path found to player! Check grid and walls.");
			}
		}

		// If path ended but player still in range, recalculate immediately
		if (path_index == -1) {
			calc_path_timer = 0; // Force immediate recalc
		}
	}
} else {
	// Stop following path if player is out of range
	if (path_index != -1) {
		path_end();
	}
}

// Wall collision handling - prevent getting stuck
if(place_meeting(x, y, Wall)){
	// Stop path immediately
	path_end();

	// Nudge away from wall - try small distances first
	var nudged = false;
	for(var i = 1; i <= 32; ++i) {
		// Try cardinal directions first (most reliable)
		if(!place_meeting(x + i, y, Wall)){
			x += i;
			show_debug_message("Nudged right " + string(i));
			calc_path_timer = 0; // Immediate recalc
			nudged = true;
			break;
		}
		if(!place_meeting(x - i, y, Wall)){
			x -= i;
			show_debug_message("Nudged left " + string(i));
			calc_path_timer = 0;
			nudged = true;
			break;
		}
		if(!place_meeting(x, y - i, Wall)){
			y -= i;
			show_debug_message("Nudged up " + string(i));
			calc_path_timer = 0;
			nudged = true;
			break;
		}
		if(!place_meeting(x, y + i, Wall)){
			y += i;
			show_debug_message("Nudged down " + string(i));
			calc_path_timer = 0;
			nudged = true;
			break;
		}
	}

	// If still stuck, try larger movements
	if (!nudged) {
		x = round(x / 32) * 32 + 16;
		y = round(y / 32) * 32 + 16;
		show_debug_message("Force snapped to grid center");
		calc_path_timer = 0;
	}
}

// If no path and player is in range, force recalc
if (alert && path_index == -1 && calc_path_timer > 2) {
	calc_path_timer = 2;
}



