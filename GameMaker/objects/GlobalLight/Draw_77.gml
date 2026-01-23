draw_surface(application_surface, 0, 0);

if (surface_exists(self.light_surface)) {
	draw_surface_stretched(self.light_surface, 0, 0, window_get_width(), window_get_height());
}
