// Don't interfere with pathfinding - the mp_grid system handles walls
// This collision event can cause stuttering and stuck behavior
// Only log for debugging purposes
// show_debug_message("Enemy touched wall at (" + string(x) + ", " + string(y) + ")");