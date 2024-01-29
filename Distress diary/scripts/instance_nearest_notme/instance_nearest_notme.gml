// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param x
///@param y
///@param obj
function instance_nearest_notme(argument0,argument1,argument2)
{
	var tmp_pos_x = x;
	var tmp_pos_y = y;
	x = -9999;
	y = -9999;
	
	
	var tmp_ins = instance_nearest(argument0,argument1,argument2);
	x = tmp_pos_x;
	y = tmp_pos_y;
	
	return (tmp_ins != id) ? tmp_ins : noone;
}