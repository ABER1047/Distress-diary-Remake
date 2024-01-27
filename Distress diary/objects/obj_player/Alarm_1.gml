/// @description 매 틱레이트마다 정보 전송

if (!variable_instance_exists(id,"soc"))
{
	obj_id = 0;
	soc = -4;
	nickname = global.nickname;
	obj_id_player_only = 0;
}





if (obj_id == global.my_player_id)
{
	//나 말고 다른 사람이 같은 룸에 있는 경우 체크 (요거 좀 수정해야됨)
	global.is_anyone_same_room = 0;
	for(var i = 0; i < array_length(global.n_player_room_xx); i++)
	{
		if (i != global.my_player_id)
		{
			if (global.n_player_room_xx[i] == global.n_player_room_xx[global.my_player_id] && global.n_player_room_yy[i] == global.n_player_room_yy[global.my_player_id])
			{
				global.is_anyone_same_room = 1;
			}
		}
	}



	//내 룸 포지션이 변경된 경우
	if (my_room_pos_xx != global.n_player_room_xx[global.my_player_id] || my_room_pos_xx != global.n_player_room_yy[global.my_player_id])
	{
		my_room_pos_xx = global.n_player_room_xx[global.my_player_id];
		my_room_pos_yy = global.n_player_room_yy[global.my_player_id];
		send_MyRoomPos();
	}

	//현재 바라보는 각도 보내기
	if (my_n_dir != global.n_dir)
	{
		my_n_dir = global.n_dir;
		send_InstanceVariableData(id,"my_n_dir");
	}

	//장착중인 백팩 정보 보내기
	if (my_backpack != global.n_backpack)
	{
		my_backpack = global.n_backpack;
		send_InstanceVariableData(id,"my_backpack");
	}



	if (global.my_player_id == obj_id_player_only)
	{
		send_ImgData(obj_id,id,sprite_index,image_index,x,y,z,image_xscale,image_yscale,image_angle,image_blend,image_alpha*global.is_anyone_same_room);
	}
	alarm[1] = global.tickrate;
}

