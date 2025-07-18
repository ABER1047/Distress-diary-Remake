///len = image_xscale (최대 뻗혀 나가는 길이가 아닌 실제 외관상의 길이를 의미)


///@param x
///@param y
///@param z
///@param len
///@param wide
///@param dir
///@param count_reflect
///@param max_reflect
///@param color
///@param attacker_id
///@param rd_snap_rad
///@param dmg_info_arr
///@param [xpos]
///@param [ypos]
///@param [cnt_con]

//target값에 instance의 id입력시 두 오브젝트 사이를 있는 번개 생성됨
///@param [target]


///@param [doNotSend]

function create_shockbolt(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11,argument12,argument13,argument14,argument15,argument16)
{
	//생성 위치
	var tmp_x = argument0;
	var tmp_y = argument1;
	var tmp_z = argument2;
	
	//x-ypos
	var tmp_xpos = (argument12 != undefined) ? argument12 : -4;
	var tmp_ypos = (argument13 != undefined) ? argument13 : -4;
	
	//image_xscale-yscale
	var tmp_len = argument3;
	var tmp_wide = argument4;
	
	//dir
	var tmp_dir = argument5;
	
	//count_reflection
	var tmp_cnt_refl = argument6;
	
	//max_reflection
	var tmp_max_refl = argument7;
	
	//image_blend
	var tmp_col = argument8;
	
	//attacker_id
	var tmp_attacker_id = argument9;
	
	//random snap radius
	var tmp_rd_snap = argument10;
	
	
	//count_connection
	var tmp_cnt_con = (argument14 != undefined) ? argument14 : 0;
	
	//target_ins
	var tmp_target = (argument15 != undefined) ? argument15 : -4;
	
	
	if (instance_exists(tmp_target))
	{
		var tmp_var_name = "image_angle,image_xscale,image_yscale,max_reflection_num,image_blend,attacker_id,count_connection,tx,ty,target,z";
		var tx = tmp_target.x;
		var ty = tmp_target.y;
		var tmp_angle = point_direction(tmp_x,tmp_y,tx,ty);
		var tmp_dis = point_distance(tmp_x,tmp_y,tx,ty);
		var tmp_val = string(tmp_angle)+","+string(tmp_dis)+","+string(tmp_wide)+",0,"+string(tmp_col)+","+string(tmp_attacker_id)+",0,"+string(tx)+","+string(ty)+",1,"+string(tmp_z);
	}
	else
	{
		var tmp_var_name = "image_xscale,image_yscale,image_angle,count_reflection,max_reflection_num,image_blend,attacker_id,rd_snap_rad,count_connection,z";
		var tmp_val = string(tmp_len)+","+string(tmp_wide)+","+string(tmp_dir)+","+string(tmp_cnt_refl)+","+string(tmp_max_refl)+","+string(tmp_col)+","+string(tmp_attacker_id)+","+string(tmp_rd_snap)+","+string(tmp_cnt_con)+","+string(tmp_z);
	}
	
	tmp_var_name = string(tmp_var_name)+",attack_damage,knockback_power,critical_chance,critical_dmg_magnification,bleeding_chance,poisoning_chance,burning_chance";
	var tmp_dmg_info_arr = argument11;
	for(var i = 0; i < array_length(tmp_dmg_info_arr); i++)
	{
		tmp_val = string(tmp_val)+","+string(tmp_dmg_info_arr[i]);
	}
	
	var tmp_ins = instance_create_multiplayer_ext(obj_lightning_shock,tmp_x,tmp_y,global.object_id_ind,0,argument16,tmp_xpos,tmp_ypos,tmp_var_name,tmp_val);
	
	return tmp_ins;
}