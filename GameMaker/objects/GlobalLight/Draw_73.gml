part_system_drawit(global._part_system);

var camera = view_get_camera(0);

if(!surface_exists(self.light_surface))
{
	var cam_width = camera_get_view_width;
	var cam_height = camera_get_view_height;

	self.light_surface = surface_create(cam_width, cam_height);
}

surface_set_target(self.light_surface);
draw_clear_alpha(c_black, 0.3);
camera_apply(camera);

gpu_set_blendmode(bm_subtract);
draw_set_color(c_white);

var scale = 2;

// Player light punchout
if (instance_exists(obj_player)) {
	with (obj_player) {
		draw_sprite_ext(spr_lightpunchout, 0, x - (32 * scale), y - (32 * scale), scale, scale, 0, c_white, 1);
	}
}

// Sonar ring reveals
if (instance_exists(obj_sonar_ring)) {
	with (obj_sonar_ring) {
	    // Floor reveal - draw ring
	    draw_set_alpha(alpha);
	    draw_set_color(c_white);

	    // Draw outer circle outline
	    draw_circle(cx, cy, radius, true);

	    // Draw filled inner circle to create ring effect
	    var inner_radius = max(radius - thickness, 0);
	    draw_circle(cx, cy, inner_radius, false);

	    draw_set_alpha(1);
	}
}

gpu_set_blendmode(bm_normal);
draw_set_color(c_white);
draw_set_alpha(1);

surface_reset_target();
