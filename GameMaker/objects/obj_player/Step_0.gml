var h = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var v = keyboard_check(ord("S")) - keyboard_check(ord("W"));

x += h * move_speed;
y += v * move_speed;

if (place_meeting(x, y, obj_wall)) {
    x -= h * move_speed;
    y -= v * move_speed;
}

if (keyboard_check_pressed(vk_space)) {
    if (sonar_charges > 0) {
        sonar_charges--;

        var px = bbox_left + (bbox_right - bbox_left) * 0.5;
        var py = bbox_top  + (bbox_bottom - bbox_top) * 0.5;

        var rings = 4;
        var spacing = 12;

        for (var i = 0; i < rings; i++) {
            var r = instance_create_layer(px, py, "Effects", obj_sonar_ring);
            r.radius = -i * spacing * r.speed;
			
		
        }
    }
}