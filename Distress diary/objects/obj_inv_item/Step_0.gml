/// @description Insert description here
// You can write your code in this editor

if (instance_exists(parents_id))
{
	//이미지 스케일 조정
	if (tmp_n_camera_zoom != global.n_camera_zoom)
	{
		var slot_size = 160*global.n_camera_zoom; //1칸당 픽셀 사이즈
		image_xscale = slot_size/sprite_get_width(sprite_index);
		image_yscale = slot_size/sprite_get_height(sprite_index);
		tmp_n_camera_zoom = global.n_camera_zoom;
	}
	
	
	if ((mouse_on == 1 || moving_now == 1) && mouse_check_button(mb_left))
	{
		moving_now = 1;
	}
	else
	{
		if (moving_now == 1)
		{
			var new_x_pos = moving_item_x_pos;
			var new_y_pos = moving_item_y_pos;
			
			//아이템의 옮기려는 위치가 기존 위치랑 똑같은지 체크
			if (new_x_pos == x_pos && new_y_pos == y_pos)
			{
				moving_now = 0;
			}
			else
			{
				//현재 내 마우스 위치랑 가장 가까운 인벤토리
				var tmp_nearest_inv_ui = instance_nearest(mouse_x,mouse_y,obj_inv_ui);
				
				//가장 가까운 인벤토리의 변수들을 보유하고 있는 실제 인스턴스 (가장 가까운게 parents_id일 수도 있음)
				var nearsest_inv_variable_owner_ins = tmp_nearest_inv_ui.variable_owner;
				
				//기존에 해당 아이템을 들고 있던 인벤토리 UI가 참조하고 있는 변수 원본 값을 가진 인스턴스 (ex. obj_player)
				var variable_owner_ins = parents_id.variable_owner;
		
		
				//옮기고 있는 아이템이 인벤토리 칸 밖인 경우
				if (is_moving_item_outside == 0) //옮기고 있는 아이템이 인벤토리 칸 안인 경우
				{
					//아이템을 해당 포지션으로 옮기기 (= 기존 아이템은 삭제하고 해당 위치에 아이템 재생성)
					var origin_spr = variable_owner_ins.inv_info_spr_ind[y_pos][x_pos];
					var origin_img = variable_owner_ins.inv_info_img_ind[y_pos][x_pos];
					var origin_name = variable_owner_ins.inv_info_name[y_pos][x_pos];
					var origin_stack_num = variable_owner_ins.inv_info_stack_num[y_pos][x_pos];
					nearsest_inv_variable_owner_ins.inv_info_spr_ind[new_y_pos][new_x_pos] = origin_spr;
					nearsest_inv_variable_owner_ins.inv_info_img_ind[new_y_pos][new_x_pos] = origin_img;
					nearsest_inv_variable_owner_ins.inv_info_name[new_y_pos][new_x_pos] = origin_name;
					nearsest_inv_variable_owner_ins.inv_info_stack_num[new_y_pos][new_x_pos] = origin_stack_num;
					
					
					//바뀐 데이터 전송
					send_InventoryData(nearsest_inv_variable_owner_ins.obj_id,nearsest_inv_variable_owner_ins.object_index);
					
					//(아이템 재생성 부분)
					create_inv_item(origin_spr,origin_img,origin_name,origin_stack_num,tmp_nearest_inv_ui,new_x_pos,new_y_pos);
				}
		
				//기존에 있던 아이템은 삭제
				variable_owner_ins.inv_info_spr_ind[y_pos][x_pos] = -4; //아이템 삭제는 inv_info_spr_ind값만 -4로 해주면 됨
				instance_destroy();
			}
		}
	}
}
else
{
	instance_destroy();
}



