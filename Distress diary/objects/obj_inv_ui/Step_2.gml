/// @description Item searching system



//위치적으로 순차로 돌면서 서치되지 않은 아이템이면 서치하는 시스템
if (search_item)
{
	//인벤토리 정보 변수를 가지고 있는 인스턴스 
	var tmp_owner = variable_owner;
	var repeat_for = 0;

	for(var i = 0; (i < tmp_owner.inv_height && repeat_for == 0); i++)
	{
		for(var ii = 0; (ii < tmp_owner.inv_width && repeat_for == 0); ii++)
		{
			if (sprite_exists(tmp_owner.inv_info_spr_ind[i][ii]))
			{
				show_debug_message("searching_now : "+string(ii)+", "+string(i));
				if (tmp_owner.inv_info_searched[i][ii] < 1)
				{
					//효과음 재생
					if (searching_sfx == -4)
					{
						searching_sfx = play_sound(item_searching_sfx,true,0.1);
					}
				
					tmp_owner.inv_info_searched[i][ii] += 1/global.searching_time;
					repeat_for = 1;
				}
				else
				{
					tmp_owner.inv_info_searched[i][ii] = 1;
					with(obj_inv_item)
					{
						if (parents_id == other.id && x_pos == ii && y_pos == i)
						{
							item_searched = 1;
						}
					}
				}
			}
			
			if (repeat_for == 0 && i == tmp_owner.inv_height-1 && ii == tmp_owner.inv_width-1)
			{
				if (searching_sfx != -4)
				{
					audio_stop_sound(searching_sfx);
				}
				search_item = false;
				show_debug_message("searching_end");
			}
		}
	}
}