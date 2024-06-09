// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param x
///@param y
///@param img_ind
///@param speed
///@param scale
///@param parents[ins_id]
///@param dmg
///@param z
///@param ErrorRange
function create_projectile(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8)
{
	var ER = irandom_range(0,argument8);
	var dir = point_direction(x,y,mouse_x,mouse_y);
	var tmp_ins = instance_create_multiplayer(obj_projectile,argument0,argument1,global.object_id_ind,argument2,false,-4,-4);
	tmp_ins.direction = dir+irandom_range(0,argument8)*choose(-1,1)*0.5;
	tmp_ins._speed = argument3;
	tmp_ins.parents_obj_ind = object_get_name(argument5.object_index);
	tmp_ins.parents = argument5;
	tmp_ins.attack_dmg = argument6;
	tmp_ins.z = argument7;
	tmp_ins.image_xscale = argument4;
	tmp_ins.image_yscale = argument4;
	
	return tmp_ins;
}