/// @description 클라이언트 영향 받는 스텝 이벤트
// You can write your code in this editor


//캐릭터가 본인의 캐릭터거나, 서버 자체를 열지 않은 경우 조작 가능
if ((instance_exists(code_m) && code_m.server == -4) || global.my_player_id == obj_id_player_only)
{
	//데미지 애니메이션
	if (dmg_cooltime > 0)
	{
		dmg_cooltime --;
		if (dmg_cooltime%4 == 0)
		{
			image_alpha = (image_alpha == 1) ? 0.5 : 1;
		}
		
		if (dmg_cooltime == 0)
		{
			image_alpha = 1;
		}
		
		//데미지 받았을때 잠깐동안 이속 감소
		if (dmg_cooltime > 50)
		{
			global.movement_vspeed += (0 - global.movement_vspeed)*0.3;
			global.movement_hspeed += (0 - global.movement_hspeed)*0.3;
		}
	}
	
	
	//플래시 라이트
	if (!global.chat_activated && keyboard_check_pressed(ord("E")))
	{
		flashlight_toggle();
	}
	
	//폭탄 던지기
	if (!global.chat_activated && keyboard_check_pressed(ord("G")))
	{
		var m_speed = abs(global.movement_hspeed)+abs(global.movement_vspeed);
		var tmp_dir = (m_speed == 0) ? global.n_dir*90 : point_direction(0,0,global.movement_hspeed,global.movement_vspeed);
		var rd_bomb = choose(false,true);
		if (rd_bomb)
		{
			var tmp_val_name = "zspeed,_hspeed,_vspeed,z";
			var tmp_val = string(zspeed*1.5)+","+string(lengthdir_x(54+m_speed,tmp_dir))+","+string(lengthdir_y((64+m_speed)*0.48,tmp_dir))+","+string(z);
			var tmp_ins = instance_create_multiplayer_ext(obj_bomb,x,y+12,global.object_id_ind,0,false,-4,-4,tmp_val_name,tmp_val);
		}
		else
		{
			var tmp_val_name = "zspeed,_hspeed,_vspeed,z";
			var tmp_val = "-8,"+string(lengthdir_x(76+m_speed,tmp_dir))+","+string(lengthdir_y((96+m_speed)*0.55,tmp_dir))+","+string(z+1);
			var tmp_ins = instance_create_multiplayer_ext(obj_cherry_bomb,x,y+12,global.object_id_ind,0,false,-4,-4,tmp_val_name,tmp_val);
		}
	}
	
	
	
	//hp정보 보내기 (멀티플레이)
	if (hp != b_hp)
	{
		//사망시 이동 불가능하게
		if (hp <= 0)
		{
			if (b_hp != -4)
			{
				zspeed = -10;
				
				b_hp = -4; //아래 코드들이 1번만 실행되도록
				b_prohibit_movement_input = global.prohibit_movement_input;
				global.prohibit_movement_input = true;
				global.n_dir = (sign(image_xscale) > 0) ? 2 : 0;
			
				//퀵슬롯 내의 모든 아이템 드랍
				drop_index = 0;
				alarm[0] = 1;
			}
		}
		else
		{
			if (hp-b_hp < 0)
			{
				//데미지 입었을 때, 화면 흔들림 이펙트
				view_shake(2,2,2,2);
				
				//재생 시간 리셋
				global.hp_recovery_time = 0;
			}
		
			b_hp = hp;
			if (!b_prohibit_movement_input)
			{
				global.prohibit_movement_input = false;
			}
		}
	}
	
	
	//HP 재생
	if (hp > 0 && hp < global.max_hp)
	{
		global.hp_recovery_time ++;
		if (global.hp_recovery_time > 600)
		{
			hp += global.hp_recovery_degree;
			b_hp = hp;
			global.hp_recovery_time = 300;
		}
	}
	
	
	//내 플레이어 각도 설정
	my_n_dir = global.n_dir;
	
	
	//카메라 위치 설정
	if (global.camera_target != -4)
	{
		global.camera_target = id;
	}
	
	//이동 관련
	if (!global.prohibit_movement_input)
	{
		var tmp_max_vspeed = global.max_movement_speed;
		var tmp_max_hspeed = global.max_movement_speed;
		if (global.movement_vspeed != 0 && global.movement_hspeed != 0)
		{
			tmp_max_vspeed = tmp_max_vspeed/sqrt(2);//= sin(pi/4);
		
			//수직 이동은 속도가 좀 더 느리게 이동함
			tmp_max_hspeed = tmp_max_hspeed/sqrt(2)*0.98;//= cos(pi/4);
		}
	
		if (keyboard_check(ord("W")))
		{
			global.n_dir = (global.fixed_dir == 0) ? 1 : global.n_dir;
			global.movement_vspeed += (-tmp_max_vspeed - global.movement_vspeed)*0.1;
		}
		else if (keyboard_check(ord("S")))
		{
			global.n_dir = (global.fixed_dir == 0) ? 3 : global.n_dir;
			global.movement_vspeed += (tmp_max_vspeed - global.movement_vspeed)*0.1;
		}
		else
		{
			global.movement_vspeed += (0 - global.movement_vspeed)*((z > 0) ? 0.05 : 0.3);
			if (abs(global.movement_vspeed) < 0.5)
			{
				global.movement_vspeed = 0;
			}
		}

		if (keyboard_check(ord("D")))
		{
			global.n_dir = (global.fixed_dir == 0) ? 0 : global.n_dir;
			global.movement_hspeed += (tmp_max_hspeed - global.movement_hspeed)*0.1;
		}
		else if (keyboard_check(ord("A")))
		{
			global.n_dir = (global.fixed_dir == 0) ? 2 : global.n_dir;
			global.movement_hspeed += (-tmp_max_hspeed - global.movement_hspeed)*0.1;
		}
		else
		{
			global.movement_hspeed += (0 - global.movement_hspeed)*((z > 0) ? 0.05 : 0.3);
			if (abs(global.movement_hspeed) < 0.5)
			{
				global.movement_hspeed = 0;
			}
		}

	
	
	
	
		//무게 시스템
		//무게에 의한 이동속도
		var tmp_weight_ratio = fix_to_zero(global.my_weight-global.over_weight)/90;
		speed_by_weight = fix_to_zero(power(1-tmp_weight_ratio,2));
	
	
	
		//달리기
		var stamina_decreasement = 0.6*(1+tmp_weight_ratio);
		if (abs(global.movement_hspeed)+abs(global.movement_vspeed) > 0 && stamina >= stamina_decreasement && (stamina >= 10 && keyboard_check_pressed(vk_shift) || global.n_running))
		{
			//스태미나 10 이상인 상태에서 쉬프트 누르고 있으면 달리기
			global.max_movement_speed = 9*speed_by_weight*(1+(sign(global.buff_left_time[1])*0.15 - sign(global.buff_left_time[0])*0.65));
		
			//달리기 도중 쉬프트에서 손 때면 그만 달리기
			global.n_running = keyboard_check(vk_shift);
		
			//스테미나 닳는거
			stamina -= stamina_decreasement;
		
			//스테미나 회복 쿨타임 (프레임 단위)
			stamina_cooltime = 10;
		}
		else
		{
			//스테미나 자동 회복
			if (stamina_cooltime <= 0)
			{
				if (stamina < global.max_stamina)
				{
					stamina += 0.5*(1-tmp_weight_ratio);
				}
				else
				{
					stamina = global.max_stamina;
				}
			}
			else
			{
				stamina_cooltime --;
			}
			global.max_movement_speed = 7*speed_by_weight*(1+(sign(global.buff_left_time[1])*0.15 - sign(global.buff_left_time[0])*0.65));
			global.n_running = false;
		}
		
		
		//점프 관련
		if (z == 0)
		{
			if (played_jump_sfx)
			{
				//점프 효과음
				play_sound_pos(choose(footstep1_sfx,footstep2_sfx,footstep3_sfx),false,0.1,x,y,1600,false,-4,-4);
				played_jump_sfx = false;
			}
		
			if (keyboard_check_pressed(vk_space))
			{
				zspeed = -8*speed_by_weight; //무게에 따른 점프력 감소
		
				//점프 효과음
				play_sound_pos(choose(jump_start1_sfx,jump_start2_sfx),false,0.1,x,y,1280,false,-4,-4);
				played_jump_sfx = true;
			}
		}
	}
	else
	{
		//움직임 인풋 금지되어있을 때 속도 0으로 고정
		global.movement_hspeed = 0;
		global.movement_vspeed = 0;
		global.n_running = false;
	}
	


	

	

	z_axis_gravity();



	//이동 속도에 따른 실제 이동
	for(var i = 0; i < abs(global.movement_hspeed); i++)
	{
		var tmp = sign(global.movement_hspeed);
		var tmp_ins = instance_place(x+tmp,y,obj_wall_parents);
		//벽에 막혔는지 체크
		if (!instance_exists(tmp_ins))
		{
			x += tmp;
		}
		else
		{
			//오브젝트 밀기 효과
			if (object_get_parent(tmp_ins.object_index) == obj_player_pushable_object && point_distance(x,y,tmp_ins.x,tmp_ins.y-48) <= 96)
			{
				tmp_ins.pushing_animation = true;
				tmp_ins.pusher = global.my_player_id;
			}
			global.movement_hspeed = 0;
			break;
		}
	}

	for(var i = 0; i < abs(global.movement_vspeed); i++)
	{
		var tmp = sign(global.movement_vspeed);
		var tmp_ins = instance_place(x,y+tmp,obj_wall_parents);
		//벽에 막혔는지 체크
		if (!instance_exists(tmp_ins))
		{
			y += tmp;
		}
		else
		{
			//오브젝트 밀기 효과
			if (object_get_parent(tmp_ins.object_index) == obj_player_pushable_object && point_distance(x,y,tmp_ins.x,tmp_ins.y-48) <= 96)
			{
				tmp_ins.pushing_animation = true;
				tmp_ins.pusher = global.my_player_id;
			}
			global.movement_vspeed = 0;
			break;
		}
	}




	//움직임 애니메이션
	if (global.movement_hspeed == 0 && global.movement_vspeed == 0)
	{
		image_index += (0 - image_index)*0.1;
	}
	else
	{
		image_index += max(abs(global.movement_hspeed),abs(global.movement_vspeed))*0.015;
		
		
		//발소리 효과음
		if (floor(image_index) == 0 || floor(image_index) == 2)
		{
			if (!played_footstep_sfx)
			{
				played_footstep_sfx = true;
				play_sound_pos(choose(footstep1_sfx,footstep2_sfx,footstep3_sfx),false,0.1,x,y,1280,false,-4,-4);
			}
		}
		else
		{
			played_footstep_sfx = false;
		}
	}



	if (image_index < 0)
	{
		image_index += image_number;
	}
	else if (image_index > image_number)
	{
		image_index -= image_number;
	}






	//바라보는 방향에 따른 스프라이트 설정
	if (hp > 0)
	{
		if (global.n_dir == 0 || global.n_dir == 2)
		{
			var tmp_skin_spr = [ spr_original_p0, spr_original_b0, spr_original_d0, spr_original_r0, spr_original_m0, spr_original_h0 ];
			sprite_index = tmp_skin_spr[global.player_skin];
			image_xscale = (global.n_dir == 0) ? -abs(image_xscale) : abs(image_xscale);
		}
		else if (global.n_dir == 1)
		{
			var tmp_skin_spr = [ spr_original_p1, spr_original_b1, spr_original_d1, spr_original_r1, spr_original_m1, spr_original_h1 ];
			sprite_index = tmp_skin_spr[global.player_skin];
		}
		else
		{
			var tmp_skin_spr = [ spr_original_p2, spr_original_b2, spr_original_d2, spr_original_r2, spr_original_m2, spr_original_h2 ];
			sprite_index = tmp_skin_spr[global.player_skin];
		}
	}
	else
	{
		var tmp_skin_spr = [ spr_original_p3, spr_original_b3, spr_original_d3, spr_original_r3, spr_original_m3, spr_original_h3 ];
		sprite_index = tmp_skin_spr[global.player_skin];
	}





	//룸 이동
	if (move_to_other_room == -5)
	{
		var tmp_ins = instance_nearest(x,y,obj_nextroom);
		if (point_distance(x,y,tmp_ins.x,tmp_ins.y) > 64)
		{
			move_to_other_room = -4;
		}
	}
	else
	{
		move_to_other_room = instance_place(x,y,obj_nextroom);
		if (instance_exists(move_to_other_room))
		{
			var xx_w = camera_get_view_width(view_camera[0]);
			var yy_h = camera_get_view_height(view_camera[0]);
			var tmp_xx = [ 1, 0, -1, 0 ];
			var tmp_yy = [ 0, -1, 0, 1 ];
			var tmp_tp_to = move_to_other_room.tp_to;
		
			var n_xx = global.n_player_room_xx[global.my_player_id];
			var n_yy = global.n_player_room_yy[global.my_player_id];
			var t_xx = n_xx+tmp_xx[tmp_tp_to];
			var t_yy = n_yy+tmp_yy[tmp_tp_to];
		
		
			//문이 열려있음
			if (move_to_other_room.can_use_tp)
			{
				//룸 이동 애니메이션 (카메라 이동 효과)
				var tmp_camera_xx = move_to_other_room.x+tmp_xx[tmp_tp_to]*xx_w*0.5;
				var tmp_camera_yy = move_to_other_room.y+tmp_yy[tmp_tp_to]*yy_h*0.5;
				if (global.camera_target != -4)
				{
					camera_set_t_pos(tmp_camera_xx,tmp_camera_yy);
					b_prohibit_movement_input = global.prohibit_movement_input;
					global.prohibit_movement_input = true;
				}
			
			
				//카메라 이동이 끝난 경우 실제로 룸 이동
				if (point_distance(tmp_camera_xx,tmp_camera_yy,obj_camera.x,obj_camera.y) < yy_h*0.25)
				{
					//포탈 이동 후 플레이어 위치 지정용
					var tmp_scale = 2; //wall_parents의 image_scale (플레이어가 현재 2배 사이즈라서 2배 해줌)
					var tmp_sprite_size = 48*tmp_scale; //obj_wall_parents의 스프라이트 사이즈
					var tmp_n_room_width = global.map_room_width[t_yy][t_xx]*0.5*tmp_sprite_size;
					var tmp_n_room_height = global.map_room_height[t_yy][t_xx]*0.5*tmp_sprite_size;
					var p_xx = [ -tmp_n_room_width+4, -48, tmp_n_room_width-100, -48 ];
					var p_yy = [ 0, tmp_n_room_height, 0, -tmp_n_room_height+32 ];

	
					//이동 예정인 룸이 배열 밖인지 체크
					if (is_inside_array(global.map_width,t_xx) && is_inside_array(global.map_height,t_yy))
					{
						//show_message_log("조건 1 만족 ("+string(n_xx)+", "+string(n_yy)+")");
		
						//이동 예정인 룸이 현재 룸과 연결되어 있는지 체크
						var condition1 = (global.room_connected_to_xx[t_yy][t_xx] == n_xx && global.room_connected_to_yy[t_yy][t_xx] == n_yy);
						var condition2 = (global.room_connected_to_xx[n_yy][n_xx] == t_xx && global.room_connected_to_yy[n_yy][n_xx] == t_yy);
						var condition3 = (global.room_connected_to_xx_sec[t_yy][t_xx] == n_xx && global.room_connected_to_yy_sec[t_yy][t_xx] == n_yy);
						var condition4 = (global.room_connected_to_xx_sec[n_yy][n_xx] == t_xx && global.room_connected_to_yy_sec[n_yy][n_xx] == t_yy);
						var is_connected = (condition1 || condition2 || condition3 || condition4);
		
						//룸 연결됨
						if (is_connected)
						{
							//플레이어 및 카메라 위치 설정
							var tmp_p_xx = room_width*0.5+p_xx[tmp_tp_to];
							var tmp_p_yy = room_height*0.5+p_yy[tmp_tp_to];
							x = tmp_p_xx;
							y = tmp_p_yy;
							camera_set_pos_by_ins(id);
							move_to_other_room = -5;
							obj_camera.x = tmp_p_xx-tmp_xx[tmp_tp_to]*xx_w;
							obj_camera.y = tmp_p_yy-tmp_yy[tmp_tp_to]*yy_h;
			
			
							//룸 이동
							show_debug_message("룸 이동 : ("+string(n_xx)+", "+string(n_yy)+") -> ("+string(t_xx)+", "+string(t_yy)+")");
				
							//지도상의 위치 설정
							global.n_player_room_xx[global.my_player_id] = t_xx;
							global.n_player_room_yy[global.my_player_id] = t_yy;
						
						
			
							load_room(t_xx,t_yy);
							global.prohibit_movement_input = b_prohibit_movement_input;
						}
					}
				}
			}
			else
			{
				//룸 이동 실패
				show_debug_message("룸 이동 실패 [문 닫힘] : ("+string(global.map_arr[n_yy][n_xx])+") -> ("+string(global.map_arr[t_yy][t_xx])+")");
				move_to_other_room = -5;
			}
		}
	}
	
	
	
	
	
	
	//다른 죽은 플레이어 루팅하기
	var is_lootable = "";
	var tmp_ins = instance_nearest_notme(x,y,obj_player);
	if (instance_exists(tmp_ins) && tmp_ins.hp == 0 && tmp_ins.draw_alpha > 0 && point_distance(x,y,tmp_ins.x,tmp_ins.y) <= 128)
	{
		is_lootable = string(tmp_ins.nickname)+"'의 인벤토리";
	}
	else
	{
		tmp_ins = instance_nearest_notme(x,y,obj_dropped_item_box);
		if (instance_exists(tmp_ins) && !tmp_ins.stop_cal_by_pos_statement && point_distance(x,y,tmp_ins.x,tmp_ins.y) <= 128)
		{
			is_lootable = "버려진 아이템";
		}
		else
		{
			//오브젝트 상호작용 하기
			tmp_ins = -4;
			with(obj_parents)
			{
				if (!stop_cal_by_pos_statement && point_distance(x,y-48,other.x,other.y) <= 132)
				{
					tmp_ins = id;
					break;
				}
			}
		
			if (instance_exists(tmp_ins))
			{
				switch(tmp_ins.object_index)
				{
					case obj_loots:
						is_lootable = string(tmp_ins.loots_name);
					break;
				
					case obj_vending_machine:
						is_lootable = "자동판매기";
					break;
				
					case obj_arcade_pc:
						is_lootable = "PC";
					break;
				
					case obj_ineractable_fire:
						is_lootable = "Fire";
					break;
				}
			}
		}
	}
	

	
	
	//아이템 상호작용 키 표시 및 게이지 차는 로직
	if (is_lootable != "" && place_meeting(tmp_ins.x,tmp_ins.y,obj_cursor))
	{
		var tmp_key = "mb_r";
		if (tmp_ins.interaction_message != "불 켜기/끄기")
		{
			if (tmp_ins.is_opened != -4)
			{
				tmp_key = -4;
				draw_interaction_key(tmp_ins,tmp_key,string(tmp_ins.interaction_message)+" 중");
			}
			else
			{
				draw_interaction_key(tmp_ins,tmp_key,string(tmp_ins.interaction_message)+" 하기");
			}
		}
		else
		{
			draw_interaction_key(tmp_ins,tmp_key,string(tmp_ins.interaction_message));
		}

		
		
		
		if (tmp_key != -4 && !instance_exists(n_looting_inv_id))
		{
			//상호작용 후에도 계속 키를 꾹 눌렀을때 계속 상호작용 되는거 방지
			if (global.interaction_hold_time == -1 && keyboard_check_pressed(ord(tmp_key)))
			{
				global.interaction_hold_time = 0;
			}
			
			if (mouse_check_button(mb_right))
			{
				if (global.interaction_hold_time != -1)
				{
					global.interaction_hold_time_max = 30;
					global.interaction_hold_time ++;
				
					if (global.interaction_hold_time > global.interaction_hold_time_max)
					{
						if (tmp_ins.interaction_message == "루팅")
						{
							var xx_w = camera_get_view_width(view_camera[0]);
							n_looting_inv_id = show_inv_ui(xx_w*0.5+480,640,is_lootable,tmp_ins,128);
							tmp_ins.is_opened = n_looting_inv_id;
							
							if (!instance_exists(global.showing_inv))
							{
								global.showing_inv = show_inv_ui(xx_w*0.5-480,640,"인벤토리",global.my_player_ins_id[global.my_player_id],-4,1);
							}
						}
						else if (tmp_ins.interaction_message == "상호작용")
						{
							tmp_ins.is_opened = id;
						}
						else if (tmp_ins.interaction_message == "불 켜기/끄기")
						{
							tmp_ins.is_activated = !tmp_ins.is_activated;
						}
						global.interaction_hold_time = -1;
					}
				}
			}
			else
			{
				global.interaction_hold_time = 0;
			}
		}
	}
}
else
{
	var tmp_tickrate = (abs(x - tickrate_x) < 256 && abs(y - tickrate_y) < 256 && abs(z - tickrate_z) < 256) ? global.tickrate : 1;

	x += (tickrate_x - x)/tmp_tickrate;
	y += (tickrate_y - y)/tmp_tickrate;
	z += (tickrate_z - z)/tmp_tickrate;
}