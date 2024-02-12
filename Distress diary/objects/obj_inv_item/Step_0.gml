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
	
	
	//뎁스 값 조정
	if (moving_now == 0)
	{
		depth = parents_id.depth-5;
	}
	else
	{
		depth = global.min_depth-15;
	}
	
	
	if ((!instance_exists(global.is_moving_item_now) || global.is_moving_item_now == id) && (mouse_on == 1 || moving_now == 1) && mouse_check_button(mb_left))
	{
		moving_now = 1;
		global.is_moving_item_now = id;
		
		
		//기존에 해당 아이템을 들고 있던 인벤토리 UI가 참조하고 있는 변수 원본 값을 가진 인스턴스 (ex. obj_player)
		variable_owner_ins = parents_id.variable_owner;
		
		//현재 내 마우스 위치랑 가장 가까운 인벤토리
		tmp_nearest_inv_ui = instance_nearest(mouse_x,mouse_y,obj_inv_ui);
		
		//가장 가까운 인벤토리의 변수들을 보유하고 있는 실제 인스턴스 (가장 가까운게 parents_id일 수도 있음)
		nearsest_inv_variable_owner_ins = tmp_nearest_inv_ui.variable_owner;
		
				
		//새로 옮기려는 위치
		new_x_pos = moving_item_x_pos;
		new_y_pos = moving_item_y_pos;

		
		if (moving_now == 1 && is_moving_item_outside == 0)
		{
			//아이템을 해당 포지션으로 옮기기 (= 기존 아이템은 삭제하고 해당 위치에 아이템 재생성)
			origin_spr = variable_owner_ins.inv_info_spr_ind[y_pos][x_pos];
			origin_img = variable_owner_ins.inv_info_img_ind[y_pos][x_pos];
			origin_name = variable_owner_ins.inv_info_name[y_pos][x_pos];
			origin_stack_num = variable_owner_ins.inv_info_stack_num[y_pos][x_pos];
			origin_max_stack_num = variable_owner_ins.inv_info_max_stack_num[y_pos][x_pos];
					
			new_spr = nearsest_inv_variable_owner_ins.inv_info_spr_ind[new_y_pos][new_x_pos];
			new_img = nearsest_inv_variable_owner_ins.inv_info_img_ind[new_y_pos][new_x_pos];
			new_name = nearsest_inv_variable_owner_ins.inv_info_name[new_y_pos][new_x_pos];
			new_stack_num = nearsest_inv_variable_owner_ins.inv_info_stack_num[new_y_pos][new_x_pos];
			new_max_stack_num = nearsest_inv_variable_owner_ins.inv_info_max_stack_num[new_y_pos][new_x_pos];
		}
		
		
		if (is_moving_item_outside == 0) //옮기고 있는 아이템이 인벤토리 칸 안인 경우
		{
			if (new_spr == -4) //자리 자체가 비어있음
			{
				if (origin_stack_num > 1 && keyboard_check(vk_shift))
				{
					is_moveable_pos = 4;
				}
				else
				{
					is_moveable_pos = 1;
				}
			}
			else if (!keyboard_check(vk_shift) && new_spr != -4 && new_stack_num != -4 && origin_stack_num != -4 && new_spr == origin_spr && new_img == origin_img && new_name == origin_name)
			{
				//만약 스택 최대 갯수를 초과했을 경우
				if (new_stack_num >= new_max_stack_num) //이미 옮기려던 자리에 있던 아이템이 스택 갯수 max치인 경우
				{
					is_moveable_pos = -4;
				}
				else if (origin_stack_num+new_stack_num > new_max_stack_num)
				{
					is_moveable_pos = 3; //겹치기 해서 옮기기 가능한 자리임을 나타냄 (최대 스택 갯수 초과)
				}
				else
				{
					is_moveable_pos = 2; //겹치기 해서 옮기기 가능한 자리임을 나타냄 (최대 스택 갯수 미만)
				}
			} 
			else
			{
				is_moveable_pos = -4;
			}
			
			//아이템의 옮기려는 위치가 기존 위치랑 똑같은지 체크
			if (tmp_nearest_inv_ui == parents_id && new_x_pos == x_pos && new_y_pos == y_pos)
			{
				is_moveable_pos = -4;
			}
		}
	}
	else if (mouse_check_button_released(mb_left))
	{
		if (moving_now == 1)
		{
			//옮기고 있는 아이템이 인벤토리 칸 밖인 경우
			if (is_moving_item_outside == 0) //옮기고 있는 아이템이 인벤토리 칸 안인 경우
			{
				//아이템이 겹치기 가능한 아이템인 경우
				if (is_moveable_pos == 1)
				{
					nearsest_inv_variable_owner_ins.inv_info_spr_ind[new_y_pos][new_x_pos] = origin_spr;
					nearsest_inv_variable_owner_ins.inv_info_img_ind[new_y_pos][new_x_pos] = origin_img;
					nearsest_inv_variable_owner_ins.inv_info_name[new_y_pos][new_x_pos] = origin_name;
					nearsest_inv_variable_owner_ins.inv_info_stack_num[new_y_pos][new_x_pos] = origin_stack_num;
					nearsest_inv_variable_owner_ins.inv_info_max_stack_num[new_y_pos][new_x_pos] = origin_max_stack_num;
					
					
					//(아이템 재생성 부분)
					create_inv_item(origin_spr,origin_img,origin_name,origin_stack_num,origin_max_stack_num,tmp_nearest_inv_ui,new_x_pos,new_y_pos);
				}
				else if (is_moveable_pos == 2) //겹치기 해서 옮기기 가능한 자리임을 나타냄 (최대 스택 갯수 미만)
				{
					nearsest_inv_variable_owner_ins.inv_info_stack_num[new_y_pos][new_x_pos] = origin_stack_num+new_stack_num;
				}
				else if (is_moveable_pos == 3) //겹치기 해서 옮기기 가능한 자리임을 나타냄 (최대 스택 갯수 초과)
				{
					variable_owner_ins.inv_info_stack_num[y_pos][x_pos] = (origin_stack_num+new_stack_num)-new_max_stack_num;
					nearsest_inv_variable_owner_ins.inv_info_stack_num[new_y_pos][new_x_pos] = new_max_stack_num;
				}
				else if (is_moveable_pos == 4) //아이템 반절 나누기
				{
					var tmp_half = floor(origin_stack_num/2);
					variable_owner_ins.inv_info_stack_num[y_pos][x_pos] = origin_stack_num-tmp_half;
					
					nearsest_inv_variable_owner_ins.inv_info_spr_ind[new_y_pos][new_x_pos] = origin_spr;
					nearsest_inv_variable_owner_ins.inv_info_img_ind[new_y_pos][new_x_pos] = origin_img;
					nearsest_inv_variable_owner_ins.inv_info_name[new_y_pos][new_x_pos] = origin_name;
					nearsest_inv_variable_owner_ins.inv_info_stack_num[new_y_pos][new_x_pos] = tmp_half;
					nearsest_inv_variable_owner_ins.inv_info_max_stack_num[new_y_pos][new_x_pos] = origin_max_stack_num;
				}
			}
				
			if ((is_moveable_pos > 0 && is_moveable_pos != 3 && is_moveable_pos != 4) || is_moving_item_outside != 0)
			{
				//기존에 있던 아이템은 삭제(내부 변수 숫자값으로만)
				variable_owner_ins.inv_info_spr_ind[y_pos][x_pos] = -4; //아이템 삭제는 inv_info_spr_ind값만 -4로 해주면 됨
					
				//기존에 있던 아이템은 삭제 (obj_inv_item 인스턴스)
				instance_destroy();
			}
			else
			{
				moving_now = 0;
			}
				
				
			//해당 인벤토리 내부에 있는 모든 아이템 정보 전송
			if (is_moveable_pos > 0)
			{
				send_InventoryData(variable_owner_ins.obj_id,variable_owner_ins.object_index);
				parents_id.reload_inv = 1; //인벤토리 ui정보 리로드
				if (variable_owner_ins != nearsest_inv_variable_owner_ins)
				{
					send_InventoryData(nearsest_inv_variable_owner_ins.obj_id,nearsest_inv_variable_owner_ins.object_index);
					tmp_nearest_inv_ui.reload_inv = 1; //인벤토리 ui정보 리로드
				}
			}
		}
			
		//인벤토리 아이템 옮기는 중
		global.is_moving_item_now = -4;
	}
}
else
{
	instance_destroy();
}



