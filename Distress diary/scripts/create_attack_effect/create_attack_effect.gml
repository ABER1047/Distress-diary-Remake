// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param x
///@param y
///@param z
///@param to_swing_dir[-1/1]
///@param image_angle
///@param size
///@param dmg
function create_attack_effect(argument0,argument1,argument2,argument3,argument4,argument5,argument6)
{
	var tmp_size = argument5;
	var tmp_angle = argument4;
	var tmp_xx = argument0;
	var tmp_yy = argument1-32;
	var to_swing_dir = argument3;
	
	
	var tmp_ins = instance_create_depth(tmp_xx,tmp_yy,-tmp_yy,obj_attack_effect);
	tmp_ins.max_line_width = tmp_size;
	tmp_ins.dir = to_swing_dir;
	tmp_ins.direction = tmp_angle-45;
	tmp_ins.direction += (to_swing_dir < 0) ? 90 : 0;
	tmp_ins.image_angle = tmp_angle-90;
	tmp_ins.image_xscale = tmp_size/24;
	tmp_ins.image_yscale = tmp_size/52;
	tmp_ins.attack_dmg = argument6;
	tmp_ins.z = argument2;
	
	return tmp_ins;
}