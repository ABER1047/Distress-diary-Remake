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
	
	var tmp_var_name = "max_line_width,dir,direction,image_angle,image_xscale,image_yscale,attack_dmg,z,owner_player_id,knockback";
	var tmp_direction = tmp_angle-45 + ((to_swing_dir < 0) ? 90 : 0);
	var tmp_var = string(tmp_size)+","+string(to_swing_dir)+","+string(tmp_direction)+","+string(tmp_angle-90)+","+string(tmp_size/24)+","+string(tmp_size/38)+","+string(argument6)+","+string(argument2)+","+string(global.my_player_id)+","+string(global.knockback_power);
	var tmp_ins = instance_create_multiplayer_ext(obj_attack_effect,tmp_xx,tmp_yy,global.object_id_ind,0,false,-4,-4,tmp_var_name,tmp_var);
	
	return tmp_ins;
}