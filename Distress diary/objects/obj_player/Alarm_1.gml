/// @description Insert description here
// You can write your code in this editor
if (!variable_instance_exists(id,"soc"))
{
	obj_id = 0;
	soc = -4;
	nickname = global.nickname;
}

if (global.my_player_id == obj_id)
{
	send_ImgData(obj_id,id,sprite_index,image_index,x,y,z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}
alarm[1] = global.tickrate;


