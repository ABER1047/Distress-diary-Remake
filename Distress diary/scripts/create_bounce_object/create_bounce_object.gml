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
///@param [xpos]
///@param [ypos]
///@param [DoNotSend]
function create_bounce_object(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11,argument12)
{
	var tmp_xpos = (argument10 == undefined || argument10 == -4) ? global.n_player_room_xx[global.my_player_id] : argument10;
	var tmp_ypos = (argument11 == undefined || argument11 == -4) ? global.n_player_room_yy[global.my_player_id] : argument11;
	if (argument12 == undefined || argument12 == true)
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
		tmp_ins.my_pos_xx = tmp_xpos;
		tmp_ins.my_pos_yy = tmp_ypos;
	}
	else
	{
		var tmp_var_name = "z, _speed, direction, zspeed, sprite_index, image_index, image_xscale, image_yscale, t_des_time";
		var tmp_var = string(argument2)+","+string(argument3)+","+string(argument4)+","+string(argument5)+","+string(sprite_get_name(argument6))+","+string(argument7)+","+string(argument8)+","+string(argument8)+","+string(argument9);
		var tmp_ins = instance_create_multiplayer_ext(obj_bouncing_object,argument0,argument1,global.object_id_ind,argument7,false,tmp_xpos,tmp_ypos,tmp_var_name,tmp_var);
	}
	
	return tmp_ins;
}