/// @description 클라이언트 영향 없는 스텝 이벤트
// You can write your code in this editor


//위치 (y축에 따라 depth 설정)
depth = -y;


//인터렉션 키 드로우 용
if (show_interaction_key > 0)
{
	show_interaction_key --;
}



if (my_backpack != b_my_backpack)
{
	set_inv_size_by_bp(my_backpack);
	b_my_backpack = my_backpack;
}


//나 말고 다른 사람이 같은 룸에 있는 경우 체크
if (global.n_player_room_xx[global.my_player_id] == global.n_player_room_xx[obj_id_player_only] && global.n_player_room_yy[global.my_player_id] == global.n_player_room_yy[obj_id_player_only])
{
	draw_alpha = image_alpha;
}
else
{
	draw_alpha = 0;
}

//다른사람이 내 인벤을 루팅 중인 경우, 루팅 중이라고 정보 보내기
if (is_opened != b_is_opened)
{
	send_InstanceVariableData(id,"is_opened");
	b_is_opened = is_opened;
}

