/// @description 매 틱레이트마다 정보 전송

if (!variable_instance_exists(id,"soc"))
{
	obj_id = 0;
	soc = 0;
	nickname = global.nickname;
	obj_id_player_only = 0;
	get_all_players_ins_id();
}



if (obj_id_player_only == global.my_player_id)
{
	//현재 바라보는 각도 보내기
	if (b_n_dir != global.n_dir)
	{
		b_n_dir = global.n_dir;
		send_InstanceVariableData(id,"my_n_dir");
	}

	//장착중인 백팩 정보 보내기
	if (my_backpack != global.n_backpack)
	{
		my_backpack = global.n_backpack;
		send_InstanceVariableData(id,"my_backpack");
	}



	send_ImgData(obj_id,id,sprite_index,image_index,x,y,z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	alarm[1] = global.tickrate;
}

