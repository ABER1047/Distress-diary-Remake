// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param spr_ind[item]
///@param img_ind[item]
///@param width[item]
///@param height[item]
///@param stack[item]
///@param to_find_target[var_owner]
function find_empty_pos(argument0,argument1,argument2,argument3,argument4,argument5)
{
	//인벤토리 창 관련 임시 변수
	var tmp_variable_owner = argument5;
	if (instance_exists(tmp_variable_owner))
	{
		var tmp_inv_width = tmp_variable_owner.inv_width;
		var tmp_inv_height = tmp_variable_owner.inv_height;
		show_debug_message("- find_empty_pos : "+string(tmp_inv_width)+" / "+string(tmp_inv_height));
	
		//아이템 관련 임시 변수
		var tmp_item_spr_ind = argument0;
		var tmp_item_img_ind = argument1;
		var tmp_item_width = argument2;
		var tmp_item_height = argument3;
		var tmp_item_stacks = argument4;


	
	
		//스택 가능한지부터 체크
		//show_message_log("- 자동 자리 배치 준비 중... ["+string(tmp_item_max_stack)+" / "+string(tmp_variable_owner)+"]");
		
		//인벤창에서 빈자리 찾기
		for(var i = 0; i < tmp_inv_height; i++) //height (y)
		{
			for(var ii = 0; ii < tmp_inv_width; ii++) //width (x)
			{
				//(ii,i) 칸 기준으로 width/height 넓이가 비어있는지 체크
				for(var j = 0; j < 2; j++) //j는 회전 적용해서 넓이 체크하는 용도
				{
					show_debug_message("빈칸 검사 중... ["+string(ii)+", "+string(i)+"]");
					if (j == 1) //j가 0일때 비회전 상태, 1일때 회전 상태
					{
						tmp_item_width = argument3;
						tmp_item_height = argument2;
						global.inv_empty_rotated = 1;
					}
					else
					{
						//그냥 1칸짜리 아이템이면 2번 검사 필요 없음
						if (tmp_item_width == 1 && tmp_item_height == 1)
						{
							j = 1;
						}
						else
						{
							//j가 0일때 비회전 상태, 1일때 회전 상태
							tmp_item_width = argument2;
							tmp_item_height = argument3;
						}
						global.inv_empty_rotated = 0;
					}
					
					
					var has_empty_pos = true, k = 0, kk = 0; //자리가 있는지 없는지를 반환해주는 임시 변수
					//회전상태 적용된 상태로 칸 체크
					for(; k < tmp_item_height; k++)
					{
						for(kk = 0; kk < tmp_item_width; kk++)
						{
							var target_pos_xx = ii+kk;
							var target_pos_yy = i+k;
							show_debug_message("tmp_inv_width : "+string(tmp_inv_width)+" / tmp_inv_height : "+string(tmp_inv_height));
							show_debug_message("target_pos_xx : "+string(target_pos_xx)+" / target_pos_yy : "+string(target_pos_yy));
							if (is_inside_rectangle(target_pos_xx,target_pos_yy,-1,-1,tmp_inv_width,tmp_inv_height)) //그냥 어레이 밖을 벗어난 경우 컷하기
							{
								var var_owner_spr_ind = tmp_variable_owner.inv_info_spr_ind[target_pos_yy][target_pos_xx];
								if (var_owner_spr_ind != -4) //자리가 있는지 없는지 체크
								{
									show_debug_message("자리가 있는지 없는지 체크");
									
									var tmp_item_max_stack = tmp_variable_owner.inv_info_max_stack_num[target_pos_yy][target_pos_xx];
									if (tmp_item_max_stack > 1) //최대 스택 갯수가 2이상인 경우 (겹칠 수 있나 체크용)
									{
										var var_owner_img_ind = tmp_variable_owner.inv_info_img_ind[target_pos_yy][target_pos_xx];
										var var_owner_stacks = tmp_variable_owner.inv_info_stack_num[target_pos_yy][target_pos_xx];

										//같은 종류의 아이템인지 체크
										show_debug_message("같은 종류의 아이템인지 체크 ["+string(sprite_get_name(var_owner_spr_ind))+string(sprite_get_name(tmp_item_spr_ind))+"]");
										if (var_owner_spr_ind == tmp_item_spr_ind && var_owner_img_ind == tmp_item_img_ind)
										{
											//두 아이템 겹쳤을 때 갯수가 최대 갯수 초과 안 했을 경우
											var tmp_total_stack = tmp_item_stacks+var_owner_stacks;
											if (tmp_total_stack <= tmp_item_max_stack)
											{
												//갯수 초과가 안 나면 아이템 겹치기
												tmp_variable_owner.inv_info_stack_num[target_pos_yy][target_pos_xx] = tmp_total_stack;
												
												//초과 안해도 해당 자리에 아이템을 배치하는 것이 아닌
												//스택 값만 좀 수정해주면 되서, 배치 안하는걸로 함
												global.inv_empty_xpos = ii;
												global.inv_empty_ypos = i;
												return -4; //-4는 아이템 복구 없이 그냥 삭제만 한다는 뜻
											}
										}
									}

									//(겹칠 수 있을 때)같은 종류 아이템이 아니거나,
									//겹칠 수 있는 최대 갯수를 초과했거나,
									//아에 못겹치는 경우 해당 칸은 패스
									has_empty_pos = false;
									break;
									break;
								}
							}
							else
							{
								//어레이 밖을 벗어난 경우 해당 자리는 패스
								has_empty_pos = false;
								break;
								break;
							}
						}
					}
					
					
					
					//만약 빈 칸이 있는 경우
					if (has_empty_pos)
					{
						//빈 자리 위치를 저장
						global.inv_empty_xpos = ii;
						global.inv_empty_ypos = i;
						
						show_debug_message("- 자동 자리 배치 ["+string(ii)+", "+string(i)+"]");
						
						return true;
					}
				}
			}
		}
	}
	
	
	//모든 칸 끝까지 찾아봤는데 빈 자리가 없는 경우, 자리를 저장하는 변수 초기화
	global.inv_empty_xpos = -4;
	global.inv_empty_ypos = -4;
	global.inv_empty_rotated = -4;
	return false;
}