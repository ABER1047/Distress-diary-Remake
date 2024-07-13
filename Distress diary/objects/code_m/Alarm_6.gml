/// @description 서버 연결 끊기 
// You can write your code in this editor


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

