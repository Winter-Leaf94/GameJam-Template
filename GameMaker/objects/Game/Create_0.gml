/// @description Initialize game systems

// Initialize grid variable to noone (not 0!)
global.mp_grid = noone;

// Grid cell size
var TS = 32;

var _w = ceil(room_width / TS);
var _h = ceil(room_height / TS);

// Create motion planning grid
global.mp_grid = mp_grid_create(0, 0, _w, _h, TS, TS);

if(room == MainMenu)
{
	audio_play_sound(MainMenuTheme, 1, true);
}
else if (room == Level1)
{
	audio_stop_sound(MainMenuTheme);
	audio_play_sound(IdleMusic, 1, true);	
}

// add solid instances
mp_grid_add_instances(global.mp_grid, Wall, true);

show_debug_message("Grid created: " + string(_w) + "x" + string(_h) + " cells");
show_debug_message("Wall count: " + string(instance_number(Wall)));
show_debug_message("Grid ID: " + string(global.mp_grid));

// Debug menu toggle
global.show_debug = false;