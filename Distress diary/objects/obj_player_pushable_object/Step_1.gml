/// @description Insert description here
// You can write your code in this editor


//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
statement_by_pos();



//블럭 밀기 시스템
if (pusher != -4)
{
	var tmp_ins = global.my_player_ins_id[pusher];
	if (instance_exists(tmp_ins))
	{
		var tmp_scale = 96;
		var tmp_xx = x - tmp_ins.x;
		var tmp_yy = y - tmp_ins.y;
		var tmp_is_my_player_pushing = (pusher == global.my_player_id);



		//블럭 미는 애니메이션
		if (pushing_animation)
		{
			pushing_timer ++;
		
			//블럭 미는 애니메이션 상태 정보 전송
			if (tmp_is_my_player_pushing && pushing_timer == 1)
			{
				send_InstanceVariableData(id,"pushing_animation",true);
				send_InstanceVariableData(id,"pusher",global.my_player_id);
			}
		
			if ((tmp_is_my_player_pushing && global.n_running) || point_distance(x,y,tmp_ins.x,tmp_ins.y) > sprite_width)
			{
				pushing_animation = false;
			}
		}



		//애니메이션 재생 관련
		if (pushing_timer > 10)
		{
			//일정 시간 이상 밀었을 때
			if (tmp_is_my_player_pushing && pushing_timer > 30 && pushing_timer < 999)
			{
				//이동할 칸이 있는 경우
				if (abs(tmp_xx) > abs(tmp_yy))
				{
					var tmp_cal = tmp_scale*sign(tmp_xx);
					var tmp_chk_xx = x+tmp_cal;
					origin_xx += (!place_meeting(tmp_chk_xx,y,obj_nextroom) && !place_meeting(tmp_chk_xx,y,obj_wall_parents) && !place_meeting(tmp_chk_xx,y,obj_mob_parents)) ? tmp_cal : 0;
					send_InstanceVariableData(id,"origin_xx");
				}
				else
				{
					var tmp_cal = tmp_scale*sign(tmp_yy);
					var tmp_chk_yy = y+tmp_cal;
					origin_yy += (!place_meeting(x,tmp_chk_yy,obj_nextroom) && !place_meeting(x,tmp_chk_yy,obj_wall_parents)  && !place_meeting(x,tmp_chk_yy,obj_mob_parents)) ? tmp_cal : 0;
					send_InstanceVariableData(id,"origin_yy");
				}
	
	
	
				//블럭 이동 효과음
				play_sound_pos(move_block_sfx,false,0.1,x,y,1280,false);
				play_sound_pos(choose(jump_start1_sfx,jump_start2_sfx),false,0.1,x,y,1280,false);
	
	
				//사용한 스테미나 일부 회복
				var tmp_recovery = 25;
				if (tmp_ins.stamina < (tmp_ins.max_stamina)-tmp_recovery)
				{
					tmp_ins.stamina += tmp_recovery;
				}
				else
				{
					tmp_ins.stamina = tmp_ins.max_stamina;
				}
			
			
				//블럭 이동 애니메이션 재생 시작
				pushing_timer = 999;
			}
			else if (pushing_timer >= 999 || (!tmp_is_my_player_pushing && pushing_timer > 30))
			{
				//블럭 이동 애니메이션
				if (abs(origin_xx - x) <= 1 && abs(origin_yy - y) <= 1)
				{
					//이동 완료
					x = origin_xx;
					y = origin_yy;
					pusher = -4;
					send_InstanceVariableData(id,"pusher");
				}
				else
				{
					//이동 중
					x += (origin_xx - x)*0.1;
					y += (origin_yy - y)*0.1;
				}
				
				//좌우로 흔들림 애니메이션 종료
				pushing_animation = false;
			}
			else
			{
				//좌우로 흔들리는 애니메이션
				var tmp_sign = ((pushing_timer-10)%5 == 0) ? 4 : -4;
				if (abs(tmp_xx) < abs(tmp_yy))
				{
					draw_xx = tmp_sign;
				}
				else
				{
					draw_yy = tmp_sign;
				}
			}
		}
	}
}
else
{
	pushing_animation = false;
	pushing_timer = 0;
	draw_xx = 0;
	draw_yy = 0;
}
