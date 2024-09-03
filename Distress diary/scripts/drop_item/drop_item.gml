// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param spr_ind
///@param img_ind
///@param stacks
///@param width
///@param height
///@param StarTag
///@param [singleInstance]
///@param [x-drop_pos]
///@param [y-drop_pos]
function drop_item(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8)
{
	var tmp_spr_ind = argument0, tmp_img_ind = argument1, tmp_stacks = argument2, tmp_width = argument3, tmp_height = argument4, tmp_startag = argument5;
	
	if (argument6 == undefined || argument6 == false)
	{
		var tmp_my_p = global.my_player_ins_id[global.my_player_id];
		var tmp_my_p_xx = tmp_my_p.x;
		var tmp_my_p_yy = tmp_my_p.y;
		var create_new_box = false; //새로운 박스 생성 유무
		
		
		
		var tmp_nearest_dropped_item = instance_nearest_by_pos(tmp_my_p_xx,tmp_my_p_yy,obj_dropped_item_box);
		if (instance_exists(tmp_nearest_dropped_item) && point_distance(tmp_my_p_xx,tmp_my_p_yy,tmp_nearest_dropped_item.x,tmp_nearest_dropped_item.y) < 160)
		{
			//근처에 떨궈진 아이템 보관중인 박스가 있는 경우
			tmp_nearest_dropped_item.des_timer = 0; //삭제 타이머 초기화
					
			//빈칸 있는지 체크
			tmp_nearest_dropped_item.inv_width = 9; //빈공간 검사 알고리즘 때문에 임시적으로 칸 수 늘려줬음
			tmp_nearest_dropped_item.inv_height = 9;
			var has_empty_pos = find_empty_pos(tmp_spr_ind,tmp_img_ind,tmp_width,tmp_height,tmp_stacks,tmp_nearest_dropped_item);
			if (has_empty_pos == true)
			{
				show_message_log("- 아이템 떨어뜨림 [빈칸에 아이템 집어넣기]");
						
				//새로운 자리에 아이템 정보 배열에 저장
				set_inv_variable(tmp_nearest_dropped_item,global.inv_empty_xpos,global.inv_empty_ypos,tmp_spr_ind,tmp_img_ind,tmp_stacks,global.inv_empty_rotated,1,tmp_startag);
				tmp_nearest_dropped_item.x = tmp_my_p_xx;
				tmp_nearest_dropped_item.y = tmp_my_p_yy;
				tmp_nearest_dropped_item.z = tmp_my_p.z-32;
				tmp_nearest_dropped_item.zspeed = -8;
						
				//인벤토리 ui 리로드
				var tmp_inv_ui = tmp_nearest_dropped_item.ui_ins;
				if (instance_exists(tmp_inv_ui))
				{
					tmp_inv_ui.reload_inv = 1;
				}
						
						

				if (global.n_dir == 0 || global.n_dir == 2)
				{
					tmp_nearest_dropped_item._hspeed = -sign_nonzero(tmp_my_p.image_xscale)*8;
				}
				else if (global.n_dir == 1)
				{
					tmp_nearest_dropped_item._vspeed = -8;
				}
				else
				{
					tmp_nearest_dropped_item._vspeed = 8;
				}
						
				//네트워크상으로 해당 박스 인벤토리 정보 전송
				send_InventoryDataSpecificPos(tmp_nearest_dropped_item.obj_id,obj_dropped_item_box,global.inv_empty_xpos,global.inv_empty_ypos);
			}
			else if (has_empty_pos == false)
			{
				//자리가 없으면 새로운 박스 생성
				create_new_box = true;
			}
					
					
			//임시적으로 늘린 칸 다시 줄여줌
			tmp_nearest_dropped_item.resize_inv = true;
		}
		else
		{
			//주변에 버려진 아이템 보관용 상자가 없는 경우 새로운 박스 생성 
			create_new_box = true;
		}
				
				
		//새로운 박스 생성 
		if (create_new_box)
		{
			show_message_log("- 아이템 떨어뜨림 [새로운 상자 생성]");
						
			//img_ind가 -4인경우 바닥에 떨군 아이템 보관용 박스 생성
			var tmp_obj_id = global.object_id_ind;
			var tmp_loot = create_loots(tmp_my_p_xx,tmp_my_p_yy,-4,9,9,"버려진 아이템",tmp_obj_id,0,-4,-4);
			tmp_loot.z = tmp_my_p.z-32;
			tmp_loot.zspeed = -8;
			tmp_loot.inv_width = tmp_width;
			tmp_loot.inv_height = tmp_height;
			//네트워크상으로 위치 전송하기 위한 용도
			tmp_loot.b_vspeed = -4;
			tmp_loot.b_hspeed = -4;
			tmp_loot.b_zspeed = -4;
			if (global.n_dir == 0 || global.n_dir == 2)
			{
				tmp_loot._hspeed = -sign_nonzero(tmp_my_p.image_xscale)*8;
			}
			else if (global.n_dir == 1)
			{
				tmp_loot._vspeed = -8;
			}
			else
			{
				tmp_loot._vspeed = 8;
			}
						
			//새로운 자리에 아이템 정보 배열에 저장
			set_inv_variable(tmp_loot,0,0,tmp_spr_ind,tmp_img_ind,tmp_stacks,0,0,tmp_startag);
					
			//네트워크상으로 해당 박스 인벤토리 정보 전송
			tmp_loot.alarm[0] = 1;
		}
				
		with(obj_inv_ui)
		{
			reload_inv = 1; //인벤토리 ui정보 리로드
		}
	}
	else
	{
		var tmp_val_name = "spr_ind, stack_num, startag, item_width, item_height, img_ind";
		var tmp_val = string(tmp_spr_ind)+","+string(tmp_stacks)+","+string(tmp_startag)+","+string(tmp_width)+","+string(tmp_height)+","+string(tmp_img_ind);
		var tmp_ins = instance_create_multiplayer_ext(obj_dropped_item,argument7,argument8,global.object_id_ind,tmp_img_ind,false,-4,-4,tmp_val_name,tmp_val);
		return tmp_ins;
	}
}
