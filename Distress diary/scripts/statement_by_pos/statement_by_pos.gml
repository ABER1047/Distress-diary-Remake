// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function statement_by_pos()
{
	//플레이어가 존재하는 룸에 해당 오브젝트가 존재하는지 체크
	var tmp_chk = (global.n_player_room_xx[global.my_player_id] == my_pos_xx && global.n_player_room_yy[global.my_player_id] == my_pos_yy);
	if (!tmp_chk)
	{
		visible = false;
		mask_index = spr_none;
			
		origin_x_axis = x;
		origin_y_axis = y;
		stop_cal_by_pos_statement = true;
	}
	else
	{
		if (origin_x_axis != -4)
		{
			visible = origin_visible_statement;
			mask_index = origin_hitbox;
			
			x = origin_x_axis;
			y = origin_y_axis;
			origin_x_axis = -4;
			origin_y_axis = -4;
			stop_cal_by_pos_statement = false;
		}
	}
}