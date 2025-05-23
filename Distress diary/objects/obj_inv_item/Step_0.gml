/// @description Insert description here
// You can write your code in this editor

if (instance_exists(parents_id))
{
	//뎁스 값 조정
	if (moving_now == 0)
	{
		depth = parents_id.depth-5;
		
		//인벤토리 아이템 옮기는 중
		if (!global.is_mouse_inside_quickslot)
		{
			global.is_moving_item_now = -4;
			global.is_mouse_on_quickslot = -4;
		}
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
		tmp_nearest_inv_ui = instance_position(mouse_x,mouse_y,obj_inv_ui);
		
		//가장 가까운 인벤토리의 변수들을 보유하고 있는 실제 인스턴스 (가장 가까운게 parents_id일 수도 있음)
		nearsest_inv_variable_owner_ins = (instance_exists(tmp_nearest_inv_ui)) ? tmp_nearest_inv_ui.variable_owner : -4;
		if (!instance_exists(nearsest_inv_variable_owner_ins))
		{
			is_moving_item_outside = 1;
		}
				
		//새로 옮기려는 위치
		new_x_pos = moving_item_x_pos;
		new_y_pos = moving_item_y_pos;
		
		
		
		//아이템 옮기는 중
		if (moving_now == 0 && mouse_check_button_pressed(mb_left))
		{
			moving_now = 1;
		
			//현재 옮기고 있는 아이템 rotated정보
			moving_item_rotation = item_rotated;
			
			//효과음
			play_sound(draging_item,false,0.03);
			
			var tmp_spr_ind = variable_owner_ins.inv_info_spr_ind[y_pos][x_pos];
			origin_spr = tmp_spr_ind;
			
			//옮기려는 아이템이 차지하는 공간은 일단 지움
			delete_inv_item(variable_owner_ins,x_pos,y_pos,item_width,item_height,item_rotated);
		}
		


		
		if (moving_now == 1 && is_moving_item_outside == 0) //옮기고 있는 아이템이 인벤토리 칸 안인 경우
		{
			//아이템을 해당 포지션으로 옮기기 (= 기존 아이템은 삭제하고 해당 위치에 아이템 재생성)
			var tmp_i = y_pos;
			var tmp_ii = x_pos;
			origin_img = variable_owner_ins.inv_info_img_ind[tmp_i][tmp_ii];
			origin_stack_num = variable_owner_ins.inv_info_stack_num[tmp_i][tmp_ii];
			origin_item_width = variable_owner_ins.inv_info_width[tmp_i][tmp_ii];
			origin_item_height = variable_owner_ins.inv_info_height[tmp_i][tmp_ii];
			origin_item_rorated = variable_owner_ins.inv_info_rotated[tmp_i][tmp_ii];
			origin_item_searched = variable_owner_ins.inv_info_searched[tmp_i][tmp_ii];
			origin_startag = variable_owner_ins.inv_info_startag[tmp_i][tmp_ii];
			
					
					
			var tmp_i = new_y_pos;
			var tmp_ii = new_x_pos;
			new_spr = nearsest_inv_variable_owner_ins.inv_info_spr_ind[tmp_i][tmp_ii];
			new_img = nearsest_inv_variable_owner_ins.inv_info_img_ind[tmp_i][tmp_ii];
			new_stack_num = nearsest_inv_variable_owner_ins.inv_info_stack_num[tmp_i][tmp_ii];
			new_max_stack_num = nearsest_inv_variable_owner_ins.inv_info_max_stack_num[tmp_i][tmp_ii];
	
	
	
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
			
			//2번 연산하는거 1번 연산으로 최적화 할려고 만든 임시 변수
			var tmp_if = (tmp_nearest_inv_ui == parents_id && new_x_pos == x_pos && new_y_pos == y_pos && moving_item_rotation == origin_item_rorated)
			
			if (is_all_place_empty && (!tmp_if)) //자리 비어있음
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
			else if (!keyboard_check(vk_shift) && new_spr != -4 && new_stack_num != -4 && origin_stack_num != -4 && new_spr == origin_spr && new_img == origin_img)
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
			if (tmp_if)
			{
				if (keyboard_check(vk_shift))
				{
					is_moveable_pos = 5; //Shift 키를 누르고 있으면, 아이템 다른 인벤토리 창으로 자동 이동
				}
				else //안누르면 그냥 이동 안하는 걸로
				{
					is_moveable_pos = -4;
				}
			}
		}
	}
	else if (mouse_check_button_released(mb_left) && origin_startag != -4)
	{
		if (moving_now == 1)
		{
			//효과음
			play_sound(draged_item,false,0.03);
			
			var tmp_k = y_pos;
			var tmp_kk = x_pos;
			var is_mouse_placed = (global.is_mouse_on_quickslot != -4);
			if (is_mouse_placed)
			{
				//퀵 슬롯에 아이템 옮기기
				var tmp_index = global.is_mouse_on_quickslot;
				var tmp_origin_spr = sprite_index, tmp_origin_img = image_index, tmp_origin_stacks = stack_num;
				
				//퀵 슬롯에 아이템 넣기
				show_message_log("item_added_on_slot");
				if (global.quickslot_spr_ind[tmp_index] != -4) //이미 아이템이 있는 퀵 슬롯에 아이템 넣기
				{
					//아이템 삭제
					delete_inv_item(variable_owner_ins,tmp_kk,tmp_k,item_width,item_height,item_rotated);

					
					var tmp_quickslot_spr = global.quickslot_spr_ind[tmp_index], tmp_quickslot_img = global.quickslot_img_ind[tmp_index], tmp_quickslot_stacks = global.quickslot_stack_num[tmp_index], tmp_quickslot_startag = global.quickslot_startag[tmp_index];
					set_item_info_values(tmp_quickslot_spr,tmp_quickslot_img); //아이템 데이터 불러오기
					var has_empty_pos = find_empty_pos(tmp_quickslot_spr,tmp_quickslot_img,global.item_width,global.item_height,tmp_quickslot_stacks,global.my_player_ins_id[global.my_player_id]);
					if (has_empty_pos != false)
					{
						is_mouse_placed = -4;
						show_message_log("has_empty_pos = true");
						//인벤토리에 공간이 있는 경우
						set_inv_variable(global.my_player_ins_id[global.my_player_id],global.inv_empty_xpos,global.inv_empty_ypos,tmp_quickslot_spr,tmp_quickslot_img,tmp_quickslot_stacks,global.inv_empty_rotated,1,tmp_quickslot_startag);
					}
					else
					{
						show_message_log("has_empty_pos = false");
						//인벤토리에 공간이 없는 경우
						//is_mouse_on_quickslot = false [아이템 박스를 생성을 위해, 바로 아래에 있는 코드를 실행]
						is_mouse_placed = false;
						origin_spr = tmp_quickslot_spr;
						origin_img = tmp_quickslot_img;
						origin_stack_num = tmp_quickslot_stacks;
						origin_item_width = global.item_width;
						origin_item_height = global.item_height;
						origin_startag = tmp_quickslot_startag;
						is_moving_item_outside = 1;
					}
				}
				
				//후처리
				set_quickslot_variable(tmp_index,tmp_origin_spr,tmp_origin_img,tmp_origin_stacks,rare_rate,startag,item_weight);
				global.is_moving_item_now = -4;
				global.is_mouse_on_quickslot = -4;
				alarm[0] = 1; //instance_destroy();
			}
			
			
			//퀵 슬롯에 아이템 옮기는 경우가 아닌 경우
			if (is_mouse_placed == false)
			{
				//최적화 용 임시 변수
				var tmp_i = new_y_pos;
				var tmp_ii = new_x_pos;
			
			
			
				if ((is_moveable_pos > 0 && is_moveable_pos != 3 && is_moveable_pos != 4) || is_moving_item_outside != 0)
				{
					//아이템 삭제
					delete_inv_item(variable_owner_ins,tmp_kk,tmp_k,item_width,item_height,item_rotated);
					
					//기존에 있던 아이템은 삭제 (obj_inv_item 인스턴스)
					alarm[0] = 1; //instance_destroy();
				}
				else
				{
					//자리때문에 옮기기에 실패한 경우, 전에 일단 지워뒀던 아이템 정보를 다시 복구 시킴
					set_inv_variable(variable_owner_ins,x_pos,y_pos,origin_spr,origin_img,origin_stack_num,origin_item_rorated,origin_item_searched,origin_startag);
					moving_now = 0;
				}
			
			
				//옮기고 있는 아이템이 인벤토리 칸 밖인 경우
				if (is_moving_item_outside == 0) //옮기고 있는 아이템이 인벤토리 칸 안인 경우
				{
					//아이템이 겹치기 가능한 아이템인 경우
					if (is_moveable_pos == 1)
					{
						//아이템 정보 배열에 저장
						set_inv_variable(nearsest_inv_variable_owner_ins,tmp_ii,tmp_i,origin_spr,origin_img,origin_stack_num,moving_item_rotation,origin_item_searched,origin_startag);
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
						set_inv_variable(nearsest_inv_variable_owner_ins,tmp_ii,tmp_i,origin_spr,origin_img,tmp_half,moving_item_rotation,origin_item_searched,origin_startag);
					}
					else if (is_moveable_pos == 5) //아이템 다른 인벤으로 자동 이동
					{
						//열려있는 창이 총 2개인 경우
						var tmp_selected_window = -4;
						if (instance_number(obj_inv_ui) == 2)
						{
							//2개만 열려 있는 경우 해당 아이템을 가지고 있지 않은 다른 창을 선택
							with(obj_inv_ui)
							{
								if (id != other.parents_id)
								{
									tmp_selected_window = id;
								}
							}
						}
						else if (instance_exists(global.showing_inv) && instance_number(obj_inv_ui) > 2)
						{
							//2개 초과로 열려 있고, 내 인벤토리도 열려 있는 경우 내 인벤토리를 선택
							tmp_selected_window = global.showing_inv;
						}
						else
						{
							//1개만 열려 있는 경우 해당 아이템을 가지고 있는 인벤토리 창 자신을 선택
							tmp_selected_window = parents_id;
						}
					
						//자동 이동시, 선택된 창으로 아이템이 이동됨
						tmp_nearest_inv_ui = tmp_selected_window;
						nearsest_inv_variable_owner_ins = tmp_nearest_inv_ui.variable_owner; //아이템이 옮겨질 자리
					
						//빈 자리 찾기 알고리즘 실행
						var has_empty_pos = find_empty_pos(origin_spr,origin_img,origin_item_width,origin_item_height,origin_stack_num,nearsest_inv_variable_owner_ins);
						if (has_empty_pos != false)
						{
							//새로운 자리에 아이템 정보 배열에 저장
							set_inv_variable(nearsest_inv_variable_owner_ins,global.inv_empty_xpos,global.inv_empty_ypos,origin_spr,origin_img,(has_empty_pos == true) ? origin_stack_num : has_empty_pos-1,global.inv_empty_rotated,origin_item_searched,origin_startag);
						}
						else
						{
							var quickslot_has_empty_pos = find_empty_pos_quickslot(origin_spr,origin_img,origin_stack_num);
							if (quickslot_has_empty_pos != -4)
							{
								set_quickslot_variable(quickslot_has_empty_pos[0],origin_spr,origin_img,quickslot_has_empty_pos[1],rare_rate,origin_startag,item_weight);
							}
							else
							{
								//자리가 없으면 삭제한 아이템 복구
								set_inv_variable(variable_owner_ins,tmp_kk,tmp_k,origin_spr,origin_img,origin_stack_num,origin_item_rorated,origin_item_searched,origin_startag);
							}
						}
					}
				}
				else //인벤토리 칸 밖에다가 아이템 버린경우
				{
					//아이템 떨구기
					drop_item(origin_spr,origin_img,origin_stack_num,origin_item_width,origin_item_height,origin_startag);
				}
				
		
				
				
				//해당 인벤토리 내부에 있는 모든 아이템 정보 전송
				if (is_moveable_pos > 0)
				{
					send_InventoryDataSpecificPos(variable_owner_ins.obj_id,variable_owner_ins.object_index,tmp_kk,tmp_k);
					if (instance_exists(nearsest_inv_variable_owner_ins))
					{
						send_InventoryDataSpecificPos(nearsest_inv_variable_owner_ins.obj_id,nearsest_inv_variable_owner_ins.object_index,tmp_ii,tmp_i);
					}
					parents_id.reload_inv = 1; //인벤토리 ui정보 리로드
					if (is_moving_item_outside == 0 && variable_owner_ins != nearsest_inv_variable_owner_ins)
					{
						tmp_nearest_inv_ui.reload_inv = 1; //인벤토리 ui정보 리로드
					}
				}
			}
		}
	}
}
else
{
	//옮기는 도중에 갑자기 인벤토리가 닫힌 경우, 전에 일단 지워뒀던 아이템 정보를 다시 복구 시킴
	if (moving_now == 1)
	{
		set_inv_variable(variable_owner_ins,x_pos,y_pos,origin_spr,origin_img,origin_stack_num,origin_item_rorated,origin_item_searched,origin_startag);
	}
	
	instance_destroy();
}



