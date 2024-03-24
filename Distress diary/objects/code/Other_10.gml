/// @description surf reset
// You can write your code in this editor
if (!surface_exists(global.light_surf))
{
	global.light_surf = surface_create(4000,3000);
}

if (!surface_exists(outter_room_surf))
{
	outter_room_surf = surface_create(4000,3000);
}

if (surface_exists(application_surface))
{
	surface_resize(application_surface, window_get_width(), window_get_height());
}


















