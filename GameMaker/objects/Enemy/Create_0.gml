alert = false;
isSeen = false;
// distance enemy will engage with player
alert_dis = 200;
// Create Path

path = path_add();
//speed of enemy

move_spd = 2;

// delay for calculating path (lower = more responsive but more CPU intensive)
calc_path_delay = 20;
//set timer - start at 0 so first path calculation happens immediately
calc_path_timer = 0;

count = 0;

// Ensure speed is 0 - path movement will control the enemy
speed = 0;
direction = 0;
hspeed = 0;
vspeed = 0;

// Grid size for pathfinding calculations
grid_size = 32;

show_debug_message("Enemy created at (" + string(x) + "," + string(y) + ") with move_spd: " + string(move_spd));

