// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_all_players_ins_id()
{
	for(var i = 0; i < instance_number(obj_player); i++)
	{
		with(obj_player)
		{
			if (object_index == obj_player && obj_id_player_only == i)
			{
				global.my_player_ins_id[i] = id;
			}
		}
	}
}