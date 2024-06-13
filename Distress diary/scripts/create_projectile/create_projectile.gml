// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param x
///@param y
///@param img_ind
///@param speed
///@param scale
///@param dmg
///@param z
///@param ErrorRange
///@param direction
function create_projectile(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8)
{
	var ErrorRange = irandom_range(0,argument7)*choose(-1,1)*0.5;
	var tmp_dir = argument8 + ErrorRange;
	var tmp_var_name = "direction,_speed,attack_dmg,z,image_xscale,image_yscale";
	var tmp_var = string(tmp_dir)+","+string(argument3)+","+string(argument5)+","+string(argument6)+","+string(argument4)+","+string(argument4);
	var tmp_ins = instance_create_multiplayer_ext(obj_projectile,argument0,argument1,global.object_id_ind,argument2,false,-4,-4,tmp_var_name,tmp_var);

	return tmp_ins;
}