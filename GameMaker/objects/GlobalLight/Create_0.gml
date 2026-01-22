/// @description Insert description here
// You can write your code in this editor

var _lightRadius = 0;

// Initializes the surface

surf = noone;

// Create the surface if it does not exist already.

if (!surface_exists(surf))
{
	surf = surface_create(room_width, room_height);
}

// Draw to the surface

surface_set_target(surf);
draw_clear_alpha(c_black, 0.85); // Darken the room with a value of (0.0-1.0).

// Subtract a circle at the player's position

gpu_set_target(surf);
draw_set_colo(c_white);
draw_circle(obj_player.x, obj_player.y, _lightRadius, false); 
gpu_set_blendmode(bm_normal);

surface_reset_target();

// Draw the surface on the screen

draw_surface(surf, 0 , 0);

// Free Memory

if (surface_exists(surf)) 
{
	surface_free(surf)
}