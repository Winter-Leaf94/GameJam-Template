/// @description Bounce off other enemies

// Get direction away from other enemy
var push_dir = point_direction(other.x, other.y, x, y);

// Push both enemies apart
x += lengthdir_x(4, push_dir);
y += lengthdir_y(4, push_dir);

// Stop current path and recalculate soon
path_end();
calc_path_timer = 5; // Recalc in 5 frames