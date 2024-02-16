// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_all_players_ins_id()
{
	for(var i = 0; i < instance_number(obj_player); i++)
	{
		with(obj_player)
		{
			if (object_index == obj_player)
			{
				global.my_player_ins_id[obj_id_player_only] = id;
			}
		}
	}
	
	show_message_log("플레이어 정보 리로드");
}