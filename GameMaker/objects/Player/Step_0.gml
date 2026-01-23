/// @description Insert description here
// You can write your code in this editor

move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
move_x = move_x * move_speed;

move_y = keyboard_check(vk_down) - keyboard_check(vk_up);
move_y = move_y * move_speed;

if(place_meeting(x, y, obj_wall)) 
{
	move_y = 0;
}

if(place_meeting(x, y, obj_wall))
{
	move_x = 0;
}

move_and_collide(move_x, move_y, obj_wall);
	