part_system_drawit(global._part_system);

var camera = view_get_camera(0);

if(!surface_exists(self.light_surface))
{
	var cam_width = camera_get_view_width;
	var cam_height = camera_get_view_height;

	self.light_surface = surface_create(cam_width, cam_height);
}

surface_set_target(self.light_surface);
draw_clear_alpha(c_black, 0.5);
camera_apply(camera);

gpu_set_blendmode(bm_subtract);

var scale = 2;

// Player light punchout
with (obj_player)
{
	draw_sprite_ext(spr_lightpunchout, 0, self.x, self.y, scale, scale, 0, c_white, 1);
}

// Sonar ring reveals
with (obj_sonar_ring) {
    // Floor reveal (shorter)
    draw_set_alpha(alpha);
    draw_circle(cx, cy, radius, true);
    draw_circle(cx, cy, max(radius - thickness, 0), false);

    // Wall reveal (longer)
    draw_set_alpha(alpha * 0.5); // walls persist longer
    with (obj_wall) {
        draw_circle(other.cx, other.cy, other.radius + 40, true);
        draw_circle(other.cx, other.cy, max(other.radius - other.thickness, 0), false);
    }

    draw_set_alpha(1);
}

gpu_set_blendmode(bm_normal);

surface_reset_target();
