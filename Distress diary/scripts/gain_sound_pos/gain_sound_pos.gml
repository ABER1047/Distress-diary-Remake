// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@param soundid
///@param volume
///@param x
///@param y
///@param max_dis
function gain_sound_pos(argument0,argument1,argument2,argument3,argument4)
{
	var distance_ = fix_to_zero(1-point_distance(argument2,argument3,obj_camera.x,obj_camera.y)/argument4);
	audio_sound_gain(argument0,argument1*distance_,0);
	
	return argument0;
}