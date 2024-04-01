// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@param soundid
///@param loops
///@param volume
///@param x
///@param y
///@param max_dis
function play_sound_pos(argument0,argument1,argument2,argument3,argument4,argument5)
{
	var distance_ = fix_to_zero(1-point_distance(argument3,argument4,obj_camera.x,obj_camera.y)/argument5);
	return play_sound(argument0,argument1,argument2*distance_);
}