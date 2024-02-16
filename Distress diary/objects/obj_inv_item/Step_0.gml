/// @description Insert description here
// You can write your code in this editor

if (instance_exists(parents_id))
{
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
		//현재 옮기고 있는 아이템 ins_id
		global.is_moving_item_now = id;
		
		//아이템 회전
		if (keyboard_check_pressed(ord("R")))
		{
			moving_item_rotation = (moving_item_rotation == 0) ? 1 : 0;
			show_message_log("아이템 회전 ["+string(moving_item_rotation*90)+"]");
		}
		
		//아이템 회전 적용
		var tmp_item_width = (moving_item_rotation == 0) ? item_width : item_height;
		var tmp_item_height = (moving_item_rotation == 0) ? item_height : item_width;
		
		
		
		//기존에 해당 아이템을 들고 있던 인벤토리 UI가 참조하고 있는 변수 원본 값을 가진 인스턴스 (ex. obj_player)
		variable_owner_ins = parents_id.variable_owner;
		
		//현재 내 마우스 위치랑 가장 가까운 인벤토리
		tmp_nearest_inv_ui = instance_nearest(mouse_x,mouse_y,obj_inv_ui);
		
		//가장 가까운 인벤토리의 변수들을 보유하고 있는 실제 인스턴스 (가장 가까운게 parents_id일 수도 있음)
		nearsest_inv_variable_owner_ins = tmp_nearest_inv_ui.variable_owner;
		
				
		//새로 옮기려는 위치
		new_x_pos = moving_item_x_pos;
		new_y_pos = moving_item_y_pos;
		
		
		
		//아이템 옮기는 중
		if (moving_now == 0)
		{
			moving_now = 1;
		
			//현재 옮기고 있는 아이템 rotated정보
			moving_item_rotation = item_rotated;
			
			//아이템 회전 적용
			var tmp_origin_item_width = (item_rotated == 0) ? item_width : item_height;
			var tmp_origin_item_height = (item_rotated == 0) ? item_height : item_width;
			
			//옮기려는 아이템이 차지하는 공간은 일단 지움
			var tmp_spr_ind = variable_owner_ins.inv_info_spr_ind[y_pos][x_pos];
			origin_spr = tmp_spr_ind;
			for(var i = 0; i < tmp_origin_item_height; i++) //height
			{
				for(var ii = 0; ii < tmp_origin_item_width; ii++) //width
				{
					variable_owner_ins.inv_info_spr_ind[y_pos+i][x_pos+ii] = -4;
				}
			}
		}
		


		
		if (moving_now == 1 && is_moving_item_outside == 0)
		{
			//아이템을 해당 포지션으로 옮기기 (= 기존 아이템은 삭제하고 해당 위치에 아이템 재생성)
			var tmp_i = y_pos;
			var tmp_ii = x_pos;
			origin_img = variable_owner_ins.inv_info_img_ind[tmp_i][tmp_ii];
			origin_name = variable_owner_ins.inv_info_name[tmp_i][tmp_ii];
			origin_stack_num = variable_owner_ins.inv_info_stack_num[tmp_i][tmp_ii];
			origin_max_stack_num = variable_owner_ins.inv_info_max_stack_num[tmp_i][tmp_ii];
			origin_item_width = variable_owner_ins.inv_info_width[tmp_i][tmp_ii];
			origin_item_height = variable_owner_ins.inv_info_height[tmp_i][tmp_ii];
			origin_item_rorated = variable_owner_ins.inv_info_rotated[tmp_i][tmp_ii];
					
					
			var tmp_i = new_y_pos;
			var tmp_ii = new_x_pos;
			new_spr = nearsest_inv_variable_owner_ins.inv_info_spr_ind[tmp_i][tmp_ii];
			new_img = nearsest_inv_variable_owner_ins.inv_info_img_ind[tmp_i][tmp_ii];
			new_name = nearsest_inv_variable_owner_ins.inv_info_name[tmp_i][tmp_ii];
			new_stack_num = nearsest_inv_variable_owner_ins.inv_info_stack_num[tmp_i][tmp_ii];
			new_max_stack_num = nearsest_inv_variable_owner_ins.inv_info_max_stack_num[tmp_i][tmp_ii];
			new_item_width = variable_owner_ins.inv_info_width[tmp_i][tmp_ii];
			new_item_height = variable_owner_ins.inv_info_height[tmp_i][tmp_ii];
			new_item_rorated = variable_owner_ins.inv_info_rotated[tmp_i][tmp_ii];
		}
		
		
		if (is_moving_item_outside == 0) //옮기고 있는 아이템이 인벤토리 칸 안인 경우
		{
			//자리 비어있는지 체크하는 알고리즘
			var is_all_place_empty = true;
			var tmp_inv_width = nearsest_inv_variable_owner_ins.inv_width;
			var tmp_inv_height = nearsest_inv_variable_owner_ins.inv_height;
			
			//아이템이 인벤토리 칸 밖을 벗어났는지 아닌지 체크
			if (is_inside_rectangle(tmp_ii,tmp_i,-1,-1,tmp_inv_width,tmp_inv_height) && (is_inside_rectangle(tmp_ii+tmp_item_width-1,tmp_i+tmp_item_height-1,-1,-1,tmp_inv_width,tmp_inv_height)))
			{
				for(var i = 0; i < tmp_item_height; i++) //height
				{
					for(var ii = 0; ii < tmp_item_width; ii++) //width
					{
						if (nearsest_inv_variable_owner_ins.inv_info_spr_ind[tmp_i+i][tmp_ii+ii] != -4)
						{
							is_all_place_empty = false;
						}
					}
				}
			}
			else
			{
				is_all_place_empty = false;
			}
			
			
			if (is_all_place_empty) //자리 비어있음
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
			
			//아이템의 옮기려는 위치가 기존 위치랑 똑같은지 체크 (rorated도 똑같은지)
			if (tmp_nearest_inv_ui == parents_id && new_x_pos == x_pos && new_y_pos == y_pos && moving_item_rotation == origin_item_rorated)
			{
				is_moveable_pos = -4;
			}
		}
	}
	else if (mouse_check_button_released(mb_left))
	{
		if (moving_now == 1)
		{
			//최적화 용 임시 변수
			var tmp_i = new_y_pos;
			var tmp_ii = new_x_pos;
				
			var tmp_k = y_pos;
			var tmp_kk = x_pos;
			
			
			
			if ((is_moveable_pos > 0 && is_moveable_pos != 3 && is_moveable_pos != 4) || is_moving_item_outside != 0)
			{
				//회전 및 아이템 가로/세로 길이만큼 칸 차지하는 거 적용
				var visual_width = (item_rotated == 0) ? item_width : item_height;
				var visual_height = (item_rotated == 0) ? item_height : item_width;
	
				for(var k = 0; k < visual_height; k++)
				{
					for(var kk = 0; kk < visual_width; kk++)
					{
						//기존에 있던 아이템은 삭제(내부 변수 숫자값으로만)
						variable_owner_ins.inv_info_spr_ind[tmp_k+k][tmp_kk+kk] = -4; //아이템 삭제는 inv_info_spr_ind값만 -4로 해주면 됨
					}
				}
					
				//기존에 있던 아이템은 삭제 (obj_inv_item 인스턴스)
				instance_destroy();
			}
			else
			{
				//자리때문에 옮기기에 실패한 경우, 전에 일단 지워뒀던 아이템 정보를 다시 복구 시킴
				set_inv_variable(variable_owner_ins,x_pos,y_pos,origin_spr,origin_img,origin_name,origin_stack_num,origin_max_stack_num,origin_item_width,origin_item_height,origin_item_rorated);
				moving_now = 0;
			}
			
			
			//옮기고 있는 아이템이 인벤토리 칸 밖인 경우
			if (is_moving_item_outside == 0) //옮기고 있는 아이템이 인벤토리 칸 안인 경우
			{
				//아이템이 겹치기 가능한 아이템인 경우
				if (is_moveable_pos == 1)
				{
					//아이템 정보 배열에 저장
					set_inv_variable(nearsest_inv_variable_owner_ins,tmp_ii,tmp_i,origin_spr,origin_img,origin_name,origin_stack_num,origin_max_stack_num,origin_item_width,origin_item_height,moving_item_rotation);
				}
				else if (is_moveable_pos == 2) //겹치기 해서 옮기기 가능한 자리임을 나타냄 (최대 스택 갯수 미만)
				{
					nearsest_inv_variable_owner_ins.inv_info_stack_num[tmp_i][tmp_ii] = origin_stack_num+new_stack_num;
				}
				else if (is_moveable_pos == 3) //겹치기 해서 옮기기 가능한 자리임을 나타냄 (최대 스택 갯수 초과)
				{
					variable_owner_ins.inv_info_stack_num[tmp_k][tmp_kk] = (origin_stack_num+new_stack_num)-new_max_stack_num;
					nearsest_inv_variable_owner_ins.inv_info_stack_num[tmp_i][tmp_ii] = new_max_stack_num;
				}
				else if (is_moveable_pos == 4) //아이템 반절 나누기
				{
					var tmp_half = floor(origin_stack_num/2);
					variable_owner_ins.inv_info_stack_num[tmp_k][tmp_kk] = origin_stack_num-tmp_half;
					
					//새로운 자리에 아이템 정보 배열에 저장
					set_inv_variable(nearsest_inv_variable_owner_ins,tmp_ii,tmp_i,origin_spr,origin_img,origin_name,tmp_half,origin_max_stack_num,origin_item_width,origin_item_height,moving_item_rotation);
				}
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
	//옮기는 도중에 갑자기 인벤토리가 닫힌 경우, 전에 일단 지워뒀던 아이템 정보를 다시 복구 시킴
	if (moving_now == 1)
	{
		set_inv_variable(variable_owner_ins,x_pos,y_pos,origin_spr,origin_img,origin_name,origin_stack_num,origin_max_stack_num,origin_item_width,origin_item_height,origin_item_rorated);
	}
	
	instance_destroy();
}



