// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

var xx, yy, tilemap, xp, yp, meeting;

xx = argument0;
yy = argument1;
tilemap = argument2;

xp = x;
yp = y;

x = xx;
y = yy;

meeting =		tilemap_get_at_pixel(tilemap, bbox_right, bbox_top)
				||
				tilemap_get_at_pixel(tilemap, bbox_right, bbox_bottom)
				||
				tilemap_get_at_pixel(tilemap, bbox_left, bbox_top)
				||
				tilemap_get_at_pixel(tilemap, bbox_left, bbox_botom);
				
				
x = xp;
y = yp;

return(meeting);