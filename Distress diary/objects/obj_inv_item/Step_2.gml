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
		//백팩 장착 되어있는 상태
		var tmp_bp_changed = false;
		if (global.n_backpack != 0)
		{
			show_debug_message("right clicked - spr_backpack");
			var inv_owner = global.my_player_ins_id[global.my_player_id], img_ind = global.n_backpack-1;
			set_item_info_values(sprite_index,image_index);
			var has_empty_pos = find_empty_pos(sprite_index,img_ind,global.item_width,global.item_height,-4,inv_owner);
			if (has_empty_pos == true)
			{
				set_inv_variable(inv_owner,global.inv_empty_xpos,global.inv_empty_ypos,sprite_index,img_ind,-4,global.inv_empty_rotated,1,0);
				tmp_bp_changed = true;
			}
		}
		
		if (tmp_bp_changed)
		{
			var tmp_ins = parents_id.variable_owner;
			tmp_ins.inv_info_spr_ind[y_pos][x_pos] = -4;
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
				tmp_ins.inv_info_spr_ind[y_pos][x_pos] = -4;
				instance_destroy();
				break;
			}
		}
	}
}