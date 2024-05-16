// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param x
///@param y
///@param z
///@param col1
///@param col2
///@param des_speed
///@param _vspeed
///@param _hspeed
///@param speed_to_zero
///@param image_speed
///@param is_bright
///@param force_depth
///@param force_des_time
function create_bubble_effect(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11,argument12)
{
	var tmp_ins = instance_create_depth(argument0,argument1+argument2,(argument11 == undefined) ? -argument1 : argument11,obj_bubble_effect);
	tmp_ins.col1 = argument3;
	tmp_ins.col2 = argument4;
	tmp_ins.des_speed = argument5;
	tmp_ins.vspeed = argument6;
	tmp_ins.hspeed = argument7;
	tmp_ins.speed_to_zero = argument8;
	tmp_ins.image_blend = argument3;
	tmp_ins.image_speed = argument9;
	tmp_ins.is_bright = argument10;
	tmp_ins.parent_id = bubble_ef_ins;
	tmp_ins.force_des_time = (argument12 == undefined) ? -4 : argument12;
	bubble_ef_ins.child_num ++;
	
	return tmp_ins;
}