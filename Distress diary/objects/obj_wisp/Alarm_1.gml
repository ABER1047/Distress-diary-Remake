/// @description Insert description here
// You can write your code in this editor

if (global.is_server)
{
	send_ImgData(obj_id,id,sprite_index,image_index,x,y,z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	alarm[1] = global.tickrate*25;
}