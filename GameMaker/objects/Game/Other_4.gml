/// @description Room Start - Refresh grid with walls

// Destroy old grid if it exists
if (global.mp_grid != noone) {
	mp_grid_destroy(global.mp_grid);
}

// Grid cell size
var TS = 32;

var _w = ceil(room_width / TS);
var _h = ceil(room_height / TS);

// Create motion planning grid
global.mp_grid = mp_grid_create(0, 0, _w, _h, TS, TS);

// Add solid instances - this ensures all walls are added
mp_grid_add_instances(global.mp_grid, Wall, true);

show_debug_message("=== ROOM START: Grid refreshed ===");
show_debug_message("Grid size: " + string(_w) + "x" + string(_h) + " cells");
show_debug_message("Wall count: " + string(instance_number(Wall)));
show_debug_message("Grid ID: " + string(global.mp_grid));
