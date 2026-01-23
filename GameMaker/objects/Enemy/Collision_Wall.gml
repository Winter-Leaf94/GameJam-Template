/// @description Stop and recalculate when touching wall
// Stop the current path
if (path_index != -1) {
	path_end();
}

// Move back slightly to get away from wall
var push_dir = point_direction(other.x, other.y, x, y);
x += lengthdir_x(2, push_dir);
y += lengthdir_y(2, push_dir);

// Force immediate path recalculation
calc_path_timer = 0;