// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param x
///@param y
///@param col
///@param id
///@param text
function damage_display(argument0,argument1,argument2,argument3,argument4)
{
	var tmp_depth = -(argument1+16);
	var tmp_ins_for_depth = argument3;
	if (instance_exists(tmp_ins_for_depth))
	{
		tmp_depth = argument3.depth-32;
	}
	
	var tmp_ins = instance_create_depth(argument0,argument1,tmp_depth,obj_damage_display);
	tmp_ins.image_blend = argument2;
	tmp_ins.text = argument4;
	
	return tmp_ins;
}