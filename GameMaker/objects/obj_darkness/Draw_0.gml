// Create surface if needed
if (!surface_exists(dark_surface)) {
    dark_surface = surface_create(room_width, room_height);
}

// Draw darkness to surface
surface_set_target(dark_surface);
draw_clear(c_black);

// Subtract player vision
var px = obj_player.bbox_left + (obj_player.bbox_right - obj_player.bbox_left) * 0.5;
var py = obj_player.bbox_top  + (obj_player.bbox_bottom - obj_player.bbox_top) * 0.5;

gpu_set_blendmode(bm_subtract);
with (obj_sonar_ring) {

    // ----- FLOOR REVEAL (shorter) -----
    draw_set_alpha(alpha);
    draw_circle(cx, cy, radius, true);
    draw_circle(cx, cy, max(radius - thickness, 0), false);

    // ----- WALL REVEAL (longer) -----
    draw_set_alpha(alpha * 0.5); // walls persist longer
    with (obj_wall) {
        draw_circle(other.cx, other.cy, other.radius + 40, true);
        draw_circle(other.cx, other.cy, max(other.radius - other.thickness, 0), false);
    }

    draw_set_alpha(1);
}

// Restore blend mode
gpu_set_blendmode(bm_normal);
surface_reset_target();

// Draw surface to screen
draw_surface(dark_surface, 0, 0);