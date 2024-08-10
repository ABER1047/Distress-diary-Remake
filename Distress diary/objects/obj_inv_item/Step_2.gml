/// @description Item info window
// You can write your code in this editor


//아이템 위에 마우스가 올라간 경우 (아이템 이동 중이 아닌 경우)
if (mouse_on == 1 && moving_now == 0)
{
	//마우스 올려놓은지 0.33초 뒤에 창 표기
	item_info_window_timer ++;
	if (item_info_window_timer > 20)
	{
		show_item_info = true;
		obj_cursor.hide_cursor = true;
	}
}
else
{
	show_item_info = false;
	item_info_window_timer = 0;
}









//아이템 우클릭한 경우
if (item_searched == 1 && mouse_on == 1 && mouse_check_button_pressed(mb_right))
{
	show_debug_message("right clicked");
	
	//어떤 아이템인지 확인
	if (sprite_index == spr_backpack)
	{
		var bp_changed = true;
		if (global.n_backpack != 0)
		{
			//백팩 장착 되어있는 상태일때
			var tmp_bp_size = string_split(set_inv_size_by_bp(image_index,true),",");
			tmp_bp_size[0] = real(tmp_bp_size[0]);
			tmp_bp_size[1] = real(tmp_bp_size[1]);
		
			//백팩 교체 가능한지 체크
			var chk_can_change_bp = true;
		
			//내 플레이어 관련 임시 변수
			var inv_owner = global.my_player_ins_id[global.my_player_id];
			var tmp_inv_width = inv_owner.inv_width, tmp_inv_height = inv_owner.inv_height;
		
			//교체 가능 체크용 임시 변수
			var tmp_width_range_min = min(tmp_inv_width,tmp_bp_size[0]), tmp_width_range_max = max(tmp_inv_width,tmp_bp_size[0]);
			var tmp_height_range_min = min(tmp_inv_height,tmp_bp_size[1]), tmp_height_range_max = max(tmp_inv_height,tmp_bp_size[1]);
			for(var i = tmp_height_range_min; i < tmp_height_range_max; i++)
			{
				for(var ii = tmp_width_range_min; ii < tmp_width_range_max; ii++)
				{
					if (inv_owner.inv_info_spr_ind[i][ii] != -4)
					{
						chk_can_change_bp = false;
						break;
						break;
					}
				}
			}
			
			
			if (chk_can_change_bp)
			{
				show_debug_message("right clicked - spr_backpack");
				var img_ind = global.n_backpack-1;
				set_item_info_values(sprite_index,image_index);
				var has_empty_pos = find_empty_pos(sprite_index,img_ind,global.item_width,global.item_height,-4,inv_owner);
				if (has_empty_pos == true)
				{
					set_inv_variable(inv_owner,global.inv_empty_xpos,global.inv_empty_ypos,sprite_index,img_ind,-4,global.inv_empty_rotated,1,0);
				}
				else
				{
					drop_item(sprite_index,img_ind,-4,global.item_width,global.item_height,0);
				}
			}
			else
			{
				bp_changed = false;
				show_message_log("가방 공간이 부족합니다");
			}
		}
		
		
		//백팩 장비 성공시에만 인벤토리 내의 아이템 삭제
		if (bp_changed)
		{
			var tmp_ins = parents_id.variable_owner;
			delete_inv_item(tmp_ins,x_pos,y_pos,item_width,item_height,item_rotated);
			global.n_backpack = image_index+1;
			instance_destroy();
		}
	}
	else
	{
		for(var i = 0; i < 9; i++)
		{
			if (global.quickslot_spr_ind[i] == -4)
			{
				set_quickslot_variable(i,sprite_index,image_index,stack_num,rare_rate,startag,item_weight);
				var tmp_ins = parents_id.variable_owner;
				delete_inv_item(tmp_ins,x_pos,y_pos,item_width,item_height,item_rotated);
				instance_destroy();
				break;
			}
		}
	}
}