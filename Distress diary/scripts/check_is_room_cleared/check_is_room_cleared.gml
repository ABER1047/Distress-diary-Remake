// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function check_is_room_cleared()
{
	//방 클리어 판정
	var can_open_room = true;

	
	//퍼즐방 클리어 판정
	if (instance_exists(obj_floor_button))
	{
		with(obj_floor_button)
		{
			if (!stop_cal_by_pos_statement && image_index == s_img_ind && !is_cleared && image_index > 57)
			{
				can_open_room = false;
			}
		}
	}
	else if (instance_exists(obj_monster_parents)) //몬스터 방 클리어 판정
	{
		with(obj_monster_parents)
		{
			if (!stop_cal_by_pos_statement)
			{
				can_open_room = false;
			}
		}
	}

	
	
	if (can_open_room)
	{
		instance_destroy(obj_generation_puzzle);
		show_message_log("해당 방 클리어");
		
		//모든 버튼 싹다 눌려있도록 변경
		with(obj_floor_button)
		{
			if (!stop_cal_by_pos_statement)
			{
				is_cleared = true;
			}
		}
	}
	return can_open_room;
}