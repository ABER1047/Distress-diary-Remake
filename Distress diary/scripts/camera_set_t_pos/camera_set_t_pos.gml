// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param x
///@param y
function camera_set_t_pos(argument0,argument1)
{
	global.camera_target_x = argument0;
	global.camera_target_y = argument1;
	global.camera_target = -4;
}