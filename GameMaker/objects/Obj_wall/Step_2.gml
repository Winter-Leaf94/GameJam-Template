/// @description Insert description here
// You can write your code in this editor

if (tile_meeting(x + spdx, y, "Tiles_1"))
{
	while (!tile_meeting(x + sign(spdx), y, "Tiles_1"))
	{
		x += sign(spdx);
	}
	spdx = 0;
}

if (tile_meeting(x, y + spdy, "Tiles_1"))
{
	while (!tile_meeting(x, y + sign(spdy), "Tiles_1"))
	{
		y += sign(spdy);
	}
	spdy = 0;
}

x += spdx;
y += spdy;