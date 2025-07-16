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
///@param type[arrow/fireball...]
///@param [sprite_index]
///@param [exp_dmg]
///@param [exp_rad]
function create_projectile(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11,argument12)
{
	var ErrorRange = irandom_range(0,argument7)*choose(-1,1)*0.5;
	var tmp_dir = argument8 + ErrorRange;
	var tmp_var_name = "direction,_speed,attack_dmg,z,image_xscale,image_yscale,attacker_id,critical_chance,knockback,magnification,bleeding_chance,poisoning_chance,burning_chance,type";
	var tmp_var = string(tmp_dir)+","+string(argument3)+","+string(argument5)+","+string(argument6)+","+string(argument4)+","+string(argument4)+","+string(global.my_player_id)+","+string(global.knockback_power)+","+string(global.critical_chance)+","+string(global.critical_dmg_magnification)+","+string(global.bleeding_chance)+","+string(global.poisoing_chance)+","+string(global.burning_chance)+","+string(argument9);
	if (argument10 != undefined)
	{
		tmp_var_name = string(tmp_var_name)+",sprite_index";
		tmp_var = string(tmp_var)+","+string(sprite_get_name(argument10));
	}
	if (argument11 != undefined)
	{
		tmp_var_name = string(tmp_var_name)+",explosion_dmg";
		tmp_var = string(tmp_var)+","+string(sprite_get_name(argument11));
	}
	if (argument12 != undefined)
	{
		tmp_var_name = string(tmp_var_name)+",explosion_rad";
		tmp_var = string(tmp_var)+","+string(sprite_get_name(argument12));
	}
	
	
	
	var tmp_ins = instance_create_multiplayer_ext(obj_projectile,argument0,argument1,global.object_id_ind,argument2,false,-4,-4,tmp_var_name,tmp_var);

	return tmp_ins;
}