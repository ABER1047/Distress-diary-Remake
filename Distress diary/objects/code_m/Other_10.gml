/// @description 핑차이가 너무 심하거나, 연결 상태가 좋지 못한 경우 연결 끊기

network_destroy(server);
with(obj_player)
{
	if (global.my_player_id == obj_id_player_only)
	{
		other.my_instance_id = id;
		obj_id = 0;
		soc = 0;
		obj_id_player_only = 0;
	}
	else
	{
		instance_destroy();
	}
}

global.my_player_id = 0;
server = -4;
				
show_message_log("연결 상태가 좋지 않아 연결이 끊어졌습니다.");
