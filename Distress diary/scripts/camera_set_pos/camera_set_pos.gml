// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param x
///@param y
function camera_set_pos(argument0,argument1)
{
	obj_camera.x = argument0;
	obj_camera.y = argument1;
	global.camera_target_x = argument0;
	global.camera_target_y = argument1;
}