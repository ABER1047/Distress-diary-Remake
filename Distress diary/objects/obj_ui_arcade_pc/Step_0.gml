/// @description Insert description here
// You can write your code in this editor



//얼굴 이모지 애니메이션
if (play_face_animation > 0)
{
	face_animation_timer ++;
	if (face_animation_timer > 50)
	{
		face_img_ind = (face_img_ind == 0) ? 1 : 0;
		play_face_animation --;
		face_animation_timer = 0;
		
		if (play_face_animation == 0)
		{
			face_img_ind = (play_result_animation <= 1) ? 4 : 2;
		}
	}
}





if (play_result_animation > 0)
{
	result_animation_timer ++;
	
	if (play_result_animation == 1) // ... 애니메이션
	{
		if (result_animation_timer > 30)
		{
			result_img_ind ++;
			if (result_img_ind > 3)
			{
				result_img_ind = 1;
			}
			result_animation_timer = 0;
		}
	}
	else if (play_result_animation <= 160) // 주사위 돌아가는 애니메이션
	{
		if (result_animation_timer > play_result_animation)
		{
			tmp_result_img_ind = result_img_ind;
				
			do
			{
				event_user(0);
			} 
			until(tmp_result_img_ind != result_img_ind);
			
			tmp_result_arr[2] = tmp_result_arr[1];
			tmp_result_arr[1] = tmp_result_arr[0];
			tmp_result_arr[0] = result_img_ind;

			play_sound_pos(arcade_bet_sfx,false,0.07,parent_id.x,parent_id.y,640,false,-4,-4);
			play_result_animation += sqrt(play_result_animation*0.1)+1;
			result_animation_timer = 0;
		}
	}
	else //61일때 주사위 깜빡거리는 애니메이션
	{
		if (result_animation_timer > 15)
		{
			if (result_img_ind == 0)
			{
				result_img_ind = tmp_result_img_ind;
			}
			else
			{
				tmp_result_img_ind = result_img_ind;
				result_img_ind = 0;
			}
			result_animation_timer = 0;
			play_result_animation ++;
			
			if (play_result_animation > 166)
			{
				result_img_ind = tmp_result_img_ind;
				play_result_animation = 0;
			}
		}
	}
	
	
	//애니메이션 재생시간 지나면 자동으로 끝내기
	if (result_animation_playtime != -4)
	{
		result_animation_timer_sec ++;
		if (result_animation_playtime < result_animation_timer_sec)
		{
			//최종 주사위 값 결정
			event_user(0);
			
			//주사위 깜빡거리는 애니메이션 재생
			play_result_animation = 161;
			result_animation_timer_sec = 0;
			
			//이겼는지 졌는지 체크
			if (my_bet_dice == tmp_result_arr[1]-4)
			{
				//이김
				show_message_log("승리!");
				play_sound_pos(arcade_win_sfx,false,0.07,parent_id.x,parent_id.y,640,false,-4,-4);
				face_img_ind = 4;
				
				//골드 지급
				event_user(1);
			}
			else
			{
				//짐
				show_message_log("패배!");
				play_sound_pos(arcade_loose_sfx,false,0.07,parent_id.x,parent_id.y,640,false,-4,-4);
				face_img_ind = 3;
			}
			
			//베팅 금액이 5이상인데 내 돈보다 많은 경우 자동 조정
			if (bet_amount > 5 && global.my_gold < bet_amount)
			{
				bet_amount = floor(global.my_gold/5)*5;
				if (bet_amount < 5)
				{
					bet_amount = 5;
				}
			}
		}
	}
}




//아케이드 PC가 없어진 경우 or 창닫기
if (!instance_exists(parent_id) || (play_result_animation <= 1 && keyboard_check_released(vk_escape)))
{
	instance_destroy();
}



//베팅
if (play_result_animation <= 1)
{
	//베팅할 골드
	if (global.my_gold >= bet_amount+5 && bet_amount < 50 && keyboard_check_pressed(vk_up))
	{
		bet_amount += 5;
		play_sound(arcade_bet_sfx,false,0.05);
	}
	else if (bet_amount > 5 && keyboard_check_pressed(vk_down))
	{
		bet_amount -= 5;
		play_sound(arcade_bet_sfx,false,0.05);
	}
	else if (keyboard_check_pressed(vk_left))
	{
		my_bet_dice --;
		if (my_bet_dice < 0)
		{
			my_bet_dice = 4;
		}
		play_sound(arcade_bet_sfx,false,0.05);
	}
	else if (keyboard_check_pressed(vk_right))
	{
		my_bet_dice ++;
		if (my_bet_dice > 4)
		{
			my_bet_dice = 0;
		}
		play_sound(arcade_bet_sfx,false,0.05);
	}
	else if (global.my_gold >= bet_amount && keyboard_check_pressed(ord("F")))
	{
		face_img_ind = 4;
		play_face_animation = 4;
		result_img_ind = 4;
		result_animation_playtime = 300;
		play_result_animation = 2;
		
		//골드 차감
		var tmp_owner = global.my_player_ins_id[global.my_player_id];
		var is_exists = find_item_pos("Golden Coin",tmp_owner);
		
		if (is_exists)
		{
			i = global.inv_empty_ypos;
			ii = global.inv_empty_xpos;
			if (tmp_owner.inv_info_stack_num[i][ii] > bet_amount) //해당 칸에 있는 돈이 충분히 여유가 있는 경우
			{
				tmp_owner.inv_info_stack_num[i][ii] -= bet_amount;
			}
			else if (tmp_owner.inv_info_stack_num[i][ii] == bet_amount) //해당 칸에 있는 돈이 딱 맞는 경우
			{
				delete_inv_item(tmp_owner,ii,i,1,1,0);
			}
			else //돈이 흩어져있는 상태여서 여러개 합쳐서 금액을 차감가능한 경우
			{
				var chk_decrease_amount = 0;
				while(true)
				{
					tmp_owner.inv_info_stack_num[i][ii] --;
					chk_decrease_amount++;
					if (tmp_owner.inv_info_stack_num[i][ii] == 0)
					{
						delete_inv_item(tmp_owner,ii,i,1,1,0);
					}
				
					//모두 차감 완료한 경우 while문 종료
					if (chk_decrease_amount == bet_amount)
					{
						break;
					}
					else
					{
						find_item_pos("Golden Coin",tmp_owner);
						i = global.inv_empty_ypos;
						ii = global.inv_empty_xpos;
					}
				}
			}
			
			global.my_gold -= bet_amount;
			show_message_log("베팅 완료! ["+string(ii)+", "+string(i)+" / "+string(tmp_owner.inv_info_stack_num[i][ii])+"]");
		}
	}
}