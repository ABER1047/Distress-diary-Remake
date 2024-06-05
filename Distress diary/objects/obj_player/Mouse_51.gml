/// @description Insert description here
// You can write your code in this editor
if (global.my_player_id == obj_id_player_only)
{
	a_timer ++;

	if (a_timer%5 == 0)
	{
		event_user(0);
	}
}