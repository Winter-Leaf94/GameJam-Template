/// @description Insert description here
// You can write your code in this editor

move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
move_x = move_x * move_speed;

move_y = keyboard_check(vk_up) - keyboard_check(vk_down);
move_y = move_y * move_speed;

if(place_meeting(x, y +2, my_tilemap)) 
{
	move_y = 0;
}else{
	if(move_y < 10)
	{
		move_y += 1;
	}
}

move_and_collide(move_x, move_y, my_tilemap);
	