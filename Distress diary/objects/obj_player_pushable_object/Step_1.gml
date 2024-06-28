/// @description Insert description here
// You can write your code in this editor



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

		//일정 거리 이상 멀어지면 밀기 효과 삭제
		if (pushing_timer <= 30 && point_distance(x,y-48,tmp_ins.x,tmp_ins.y) > 96)
		{
			pushing_timer = 0;
			pushing_animation = false;
			draw_xx = 0;
			draw_yy = 0;
		}

		//블럭 미는 애니메이션
		if (pushing_animation)
		{
			pushing_timer ++;
		
			//블럭 미는 애니메이션 상태 정보 전송
			if (tmp_is_my_player_pushing)
			{
				if (pushing_timer == 1)
				{
					send_InstanceMuchVariableData(id,"pushing_animation,pusher",string(true)+","+string(global.my_player_id));
				}
				pushing_animation = false;
			}
		}



		//애니메이션 재생 관련
		if (pushing_timer > 10)
		{
			//일정 시간 이상 밀었을 때
			if (tmp_is_my_player_pushing && pushing_timer > 30 && pushing_timer < 999)
			{
				//이동할 칸이 있는 경우 이동
				var tmp_val = four_of_angle(point_direction(x,y-64,tmp_ins.x,tmp_ins.y))-2;
				tmp_val += (tmp_val < 0) ? 4 : 0;
				

				if (tmp_val == global.n_dir)
				{
					var tmp_dir = tmp_val*90;
					var tmp_to_move_xx = lengthdir_x(tmp_scale,tmp_dir), tmp_to_move_yy = lengthdir_y(tmp_scale,tmp_dir);
					var tmp_chk_xx = x+lengthdir_x(tmp_scale,tmp_dir), tmp_chk_yy = y+lengthdir_y(tmp_scale,tmp_dir);
					if (!place_meeting(tmp_chk_xx,tmp_chk_yy,obj_nextroom) && !place_meeting(tmp_chk_xx,tmp_chk_yy,obj_wall_parents)  && !place_meeting(tmp_chk_xx,tmp_chk_yy,obj_mob_parents))
					{
						origin_xx += tmp_to_move_xx;
						origin_yy += tmp_to_move_yy;
						send_InstanceMuchVariableData(id,"origin_xx,origin_yy,pushing_timer",string(origin_xx)+","+string(origin_yy)+",999");
					}
				}
	
	
	
				//블럭 이동 효과음
				play_sound_pos(move_block_sfx,false,0.1,x,y,1280,false,-4,-4);
				play_sound_pos(choose(jump_start1_sfx,jump_start2_sfx),false,0.1,x,y,1280,false,-4,-4);


			
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
					
					//오브젝트를 밀은 사람이 정보 보내주기
					if (pusher != -4)
					{
						pusher = -4;
						send_InstanceVariableData(id,"pusher");
					}
				}
				else
				{
					//이동 중
					x += (origin_xx - x)*0.1;
					y += (origin_yy - y)*0.1;
				}
				
				//좌우로 흔들림 애니메이션 종료
				pushing_animation = false;
				draw_xx = 0;
				draw_yy = 0;
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
