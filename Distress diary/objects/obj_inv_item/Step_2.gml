/// @description Item info window
// You can write your code in this editor

//내 플레이어
var tmp_my_p = global.my_player_ins_id[global.my_player_id];

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
	var tmp_ins = parents_id.variable_owner;
	if (sprite_index == spr_backpack)
	{
		var bp_changed = true;
		if (global.n_backpack != 0)
		{
			//백팩 장착 되어있는 상태일때
			var tmp_bp_size = string_split(set_inv_size_by_bp(image_index,true),",");
			tmp_bp_size[0] = real(tmp_bp_size[0]);
			tmp_bp_size[1] = real(tmp_bp_size[1]);
		
			
			//교체 가능한지 체크
			if (is_fully_empty(tmp_my_p))
			{
				with(tmp_my_p)
				{
					if (id == tmp_my_p)
					{
						set_inv_size_by_bp(global.n_backpack);
					}
				}
				show_debug_message("right clicked - spr_backpack");
				var img_ind = global.n_backpack-1;
				set_item_info_values(sprite_index,image_index);
				drop_item(sprite_index,img_ind,-4,global.item_width,global.item_height,0);
			}
			else
			{
				bp_changed = false;
				show_message_log("가방이 비어있지 않습니다");
			}
		}
		
		
		//백팩 장비 성공시에만 인벤토리 내의 아이템 삭제
		if (bp_changed)
		{
			delete_inv_item(tmp_ins,x_pos,y_pos,item_width,item_height,item_rotated);
			global.n_backpack = image_index+1;
			instance_destroy();
		}
		else
		{
			//가방 장착 못하면 인벤에 넣기
			var has_empty_pos = (tmp_my_p != tmp_ins) ? find_empty_pos(sprite_index,image_index,item_width,item_height,stack_num,tmp_my_p) : false;
			if (has_empty_pos != false)
			{
				set_inv_variable(tmp_my_p,global.inv_empty_xpos,global.inv_empty_ypos,sprite_index,image_index,(has_empty_pos == true) ? stack_num : has_empty_pos-1,global.inv_empty_rotated,1,startag);
				delete_inv_item(tmp_ins,x_pos,y_pos,item_width,item_height,item_rotated);
				instance_destroy();
			}
			else
			{
				//인벤에도 안 들어가면 퀵 슬롯에 넣기
				var quickslot_has_empty_pos = find_empty_pos_quickslot(sprite_index,image_index,stack_num);
				if (quickslot_has_empty_pos != -4)
				{
					set_quickslot_variable(quickslot_has_empty_pos[0],sprite_index,image_index,quickslot_has_empty_pos[1],rare_rate,startag,item_weight);
					delete_inv_item(tmp_ins,x_pos,y_pos,item_width,item_height,item_rotated);
					instance_destroy();
				}
			}
		}
	}
	else
	{
		//퀵 슬롯에 아이템 넣기
		var quickslot_has_empty_pos = find_empty_pos_quickslot(sprite_index,image_index,stack_num);
		if (quickslot_has_empty_pos != -4)
		{
			set_quickslot_variable(quickslot_has_empty_pos[0],sprite_index,image_index,quickslot_has_empty_pos[1],rare_rate,startag,item_weight);
			delete_inv_item(tmp_ins,x_pos,y_pos,item_width,item_height,item_rotated);
			instance_destroy();
		}
		else
		{
			//퀵 슬롯 공간 없으면 인벤에 넣기
			var has_empty_pos = (tmp_my_p != tmp_ins) ? find_empty_pos(sprite_index,image_index,item_width,item_height,stack_num,tmp_my_p) : false;
			if (has_empty_pos != false)
			{
				set_inv_variable(tmp_my_p,global.inv_empty_xpos,global.inv_empty_ypos,sprite_index,image_index,(has_empty_pos == true) ? stack_num : has_empty_pos-1,global.inv_empty_rotated,1,startag);
				delete_inv_item(tmp_ins,x_pos,y_pos,item_width,item_height,item_rotated);
				instance_destroy();
			}
		}
	}
}