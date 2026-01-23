var h = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var v = keyboard_check(ord("S")) - keyboard_check(ord("W"));

x += h * move_speed;
y += v * move_speed;

if (place_meeting(x, y, obj_wall)) {
    x -= h * move_speed;
    y -= v * move_speed;
}

if (place_meeting(x,y, obj_enemy))
{
	room_restart();
}