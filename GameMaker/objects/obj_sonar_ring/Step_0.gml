radius += speed;
alpha -= fade_speed;

if (radius >= max_radius || alpha <= 0) {
    instance_destroy();
}