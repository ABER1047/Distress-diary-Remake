// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param x
///@param y
///@param z
///@param speed
///@param direction
///@param zspeed
///@param sprite_index
///@param image_index
///@param scale
///@param des_time
function create_bounce_object(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9)
{
	var tmp_ins = instance_create_depth(argument0,argument1,depth,obj_bouncing_object);
	tmp_ins.z = argument2;
	tmp_ins._speed = argument3;
	tmp_ins.direction = argument4;
	tmp_ins.zspeed = argument5;
	tmp_ins.sprite_index = argument6;
	tmp_ins.image_index = argument7;
	tmp_ins.image_xscale = argument8;
	tmp_ins.image_yscale = argument8;
	tmp_ins.t_des_time = argument9;
	
	return tmp_ins;
}