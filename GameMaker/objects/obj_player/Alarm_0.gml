var px = bbox_left + (bbox_right - bbox_left) * 0.5;
var py = bbox_top  + (bbox_bottom - bbox_top) * 0.5;

var rings = 4;
var spacing = 20;

for (var i = 0; i < rings; i++) {
    var r = instance_create_layer(px, py, "Effects", obj_sonar_ring);
    r.radius = -i * spacing * r.speed;
}

alarm_set(0, 200);