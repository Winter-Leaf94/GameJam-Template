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

			// Make Path to the player
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

// Wall unsticking - runs EVERY frame to prevent getting stuck
// This is critical for pathfinding to work properly
if(place_meeting(x, y, Wall)){
	for(var i = 1; i < 100; ++i) {
		if(!place_meeting(x + i, y, Wall)){
			x += i;
			show_debug_message("Unstuck: moved right " + string(i) + " pixels");
			path_end();
			calc_path_timer = 0;
			break;
		}
		if(!place_meeting(x - i, y, Wall)){
			x -= i;
			show_debug_message("Unstuck: moved left " + string(i) + " pixels");
			path_end();
			calc_path_timer = 0;
			break;
		}
		if(!place_meeting(x, y - i, Wall)){
			y -= i;
			show_debug_message("Unstuck: moved up " + string(i) + " pixels");
			path_end();
			calc_path_timer = 0;
			break;
		}
		if(!place_meeting(x, y + i, Wall)){
			y += i;
			show_debug_message("Unstuck: moved down " + string(i) + " pixels");
			path_end();
			calc_path_timer = 0;
			break;
		}
		if(!place_meeting(x + i, y - i, Wall)){
			x += i;
			y -= i;
			show_debug_message("Unstuck: moved diag " + string(i) + " pixels");
			path_end();
			calc_path_timer = 0;
			break;
		}
		if(!place_meeting(x - i, y - i, Wall)){
			x -= i;
			y -= i;
			show_debug_message("Unstuck: moved diag " + string(i) + " pixels");
			path_end();
			calc_path_timer = 0;
			break;
		}
		if(!place_meeting(x + i, y + i, Wall)){
			x += i;
			y += i;
			show_debug_message("Unstuck: moved diag " + string(i) + " pixels");
			path_end();
			calc_path_timer = 0;
			break;
		}
		if(!place_meeting(x - i, y + i, Wall)){
			x -= i;
			y += i;
			show_debug_message("Unstuck: moved diag " + string(i) + " pixels");
			path_end();
			calc_path_timer = 0;
			break;
		}
	}
}



