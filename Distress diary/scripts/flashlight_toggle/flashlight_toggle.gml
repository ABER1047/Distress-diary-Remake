// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function flashlight_toggle()
{
	global.enable_flashlight = !global.enable_flashlight;
	global.fixed_dir = !global.fixed_dir;
	play_sound_pos(flash_light_sfx,false,0.1,x,y,256,false,-4,-4);
	//surface_free(global.flashlight_surf);
	//global.flashlight_surf = surface_create(4000,3000);
}