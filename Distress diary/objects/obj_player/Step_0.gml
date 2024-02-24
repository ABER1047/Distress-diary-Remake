/// @description 클라이언트 영향 받는 스텝 이벤트
// You can write your code in this editor


//캐릭터가 본인의 캐릭터거나, 서버 자체를 열지 않은 경우 조작 가능
if ((instance_exists(code_m) && code_m.server == -4) || global.my_player_id == obj_id_player_only)
{
	//pushable_objects끼리 밀리는 효과
	pushable_objects_physics();
	
	
	
	//hp정보 보내기 (멀티플레이)
	if (hp != b_hp)
	{
		send_InstanceVariableData(id,"hp");
		b_hp = hp;
	}
	
	
	//내 플레이어 각도 설정
	my_n_dir = global.n_dir;
	
	
	//카메라 위치 설정
	if (global.camera_target != -4)
	{
		global.camera_target = id;
	}
	
	//이동 관련
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
		global.n_dir = 1;
		global.movement_vspeed += (-tmp_max_vspeed - global.movement_vspeed)*0.1;
	}
	else if (keyboard_check(ord("S")))
	{
		global.n_dir = 3;
		global.movement_vspeed += (tmp_max_vspeed - global.movement_vspeed)*0.1;
	}

	if (keyboard_check(ord("D")))
	{
		global.n_dir = 0;
		global.movement_hspeed += (tmp_max_hspeed - global.movement_hspeed)*0.1;
	}
	else if (keyboard_check(ord("A")))
	{
		global.n_dir = 2;
		global.movement_hspeed += (-tmp_max_hspeed - global.movement_hspeed)*0.1;
	}


	if (keyboard_check_released(ord("A")) || keyboard_check_released(ord("D")))
	{
		global.movement_hspeed = 0;
	}

	if (keyboard_check_released(ord("W")) || keyboard_check_released(ord("S")))
	{
		global.movement_vspeed = 0;
	}
	
	
	
	//무게 시스템
	//무게에 의한 이동속도
	var tmp_weight_ratio = fix_to_zero(global.my_weight-10)/120;
	speed_by_weight = fix_to_zero(power(1-tmp_weight_ratio,2));
	
	
	
	//달리기
	var stamina_decreasement = 0.6*(1+tmp_weight_ratio);
	if (stamina >= stamina_decreasement && (stamina >= 10 && keyboard_check_pressed(vk_shift) || global.n_running))
	{
		//스태미나 10 이상인 상태에서 쉬프트 누르고 있으면 달리기
		global.max_movement_speed = 12*speed_by_weight;
		
		//달리기 도중 쉬프트에서 손 때면 그만 달리기
		global.n_running = keyboard_check(vk_shift);
		
		//스테미나 닳는거
		stamina -= stamina_decreasement;
		
		//스테미나 회복 쿨타임 (프레임 단위)
		stamina_cooltime = 60;
	}
	else
	{
		if (stamina_cooltime <= 0)
		{
			if (stamina < max_stamina)
			{
				stamina += 0.5*(1-tmp_weight_ratio);
			}
		}
		else
		{
			stamina_cooltime --;
		}
		global.max_movement_speed = 7*speed_by_weight;
		global.n_running = false;
	}
	


	

	//점프 관련
	if (z == 0 && keyboard_check_pressed(vk_space))
	{
		zspeed = -8;
	}

	z_axis_gravity();



	//이동 속도에 따른 실제 이동
	for(var i = 0; i < abs(global.movement_hspeed); i++)
	{
		var tmp = sign(global.movement_hspeed);
		//벽에 막혔는지 체크
		if (!place_meeting(x+tmp,y,obj_wall_parents))
		{
			x += tmp;
		}
		else
		{
			global.movement_hspeed = 0;
			break;
		}
	}

	for(var i = 0; i < abs(global.movement_vspeed); i++)
	{
		var tmp = sign(global.movement_vspeed);
		//벽에 막혔는지 체크
		if (!place_meeting(x,y+tmp,obj_wall_parents))
		{
			y += tmp;
		}
		else
		{
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
			var tmp_skin_spr = [ spr_original_p0, spr_original_b0, spr_original_d0 ];
			sprite_index = tmp_skin_spr[global.player_skin];
			image_xscale = (global.n_dir == 0) ? -abs(image_xscale) : abs(image_xscale);
		}
		else if (global.n_dir == 1)
		{
			var tmp_skin_spr = [ spr_original_p1, spr_original_b1, spr_original_d1 ];
			sprite_index = tmp_skin_spr[global.player_skin];
		}
		else
		{
			var tmp_skin_spr = [ spr_original_p2, spr_original_b2, spr_original_d2 ];
			sprite_index = tmp_skin_spr[global.player_skin];
		}
	}
	else
	{
		var tmp_skin_spr = [ spr_original_p3, spr_original_b3, spr_original_d3 ];
		sprite_index = tmp_skin_spr[global.player_skin];
	}





	//룸 이동
	var ins_place = instance_place(x,y,obj_nextroom);
	if (instance_exists(ins_place) && ins_place.can_use_tp == 1)
	{
		var n_xx = global.n_player_room_xx[global.my_player_id];
		var n_yy = global.n_player_room_yy[global.my_player_id];
		var tmp_xx = [ 1, 0, -1, 0 ];
		var tmp_yy = [ 0, -1, 0, 1 ];
		var t_xx = n_xx+tmp_xx[ins_place.tp_to];
		var t_yy = n_yy+tmp_yy[ins_place.tp_to];
	
		//이동 예정인 룸이 배열 밖인지 체크
		if (is_inside_array(global.map_width,t_xx) && is_inside_array(global.map_height,t_yy))
		{
			//show_message_log("조건 1 만족 ("+string(n_xx)+", "+string(n_yy)+")");
		
			//이동 예정인 룸이 현재 룸과 연결되어 있는지 체크
			var is_connected = 0;
			var condition1 = (global.room_connected_to_xx[t_yy][t_xx] == n_xx && global.room_connected_to_yy[t_yy][t_xx] == n_yy);
			var condition2 = (global.room_connected_to_xx[n_yy][n_xx] == t_xx && global.room_connected_to_yy[n_yy][n_xx] == t_yy);
			var condition3 = (global.room_connected_to_xx_sec[t_yy][t_xx] == n_xx && global.room_connected_to_yy_sec[t_yy][t_xx] == n_yy);
			var condition4 = (global.room_connected_to_xx_sec[n_yy][n_xx] == t_xx && global.room_connected_to_yy_sec[n_yy][n_xx] == t_yy);
			if (condition1 || condition2 || condition3 || condition4)
			{
				is_connected = 1;
			}
		
			//룸 연결됨 => 룸 이동함
			if (is_connected == 1)
			{
				x = room_width*0.5;
				y = room_height*0.5;
			
			
				show_message_log("룸 이동 : ("+string(n_xx)+", "+string(n_yy)+") -> ("+string(t_xx)+", "+string(t_yy)+")");
			
				global.n_player_room_xx[global.my_player_id] = t_xx;
				global.n_player_room_yy[global.my_player_id] = t_yy;
			
				load_room(t_xx,t_yy);
			}
		}
	}
	
	
	//다른 죽은 플레이어 루팅하기
	var is_lootable = "";
	var tmp_ins = instance_nearest_notme(x,y,obj_player);
	if (instance_exists(tmp_ins) && tmp_ins.hp == 0 && tmp_ins.draw_alpha > 0 && point_distance(x,y,tmp_ins.x,tmp_ins.y) <= 96)
	{
		is_lootable = string(tmp_ins.nickname)+"'s inventory";
	}
	else
	{
		//상자 루팅하기
		tmp_ins = instance_nearest_notme(x,y,obj_loots);
		if (instance_exists(tmp_ins) && point_distance(x,y,tmp_ins.x,tmp_ins.y) <= 128)
		{
			is_lootable = string(tmp_ins.loots_name);
		}
		else
		{
			//버려진 아이템 루팅하기 (= 아이템 버렸을 때 생성되는 특수 상자)
			tmp_ins = instance_nearest_notme(x,y,obj_dropped_item);
			if (instance_exists(tmp_ins) && point_distance(x,y,tmp_ins.x,tmp_ins.y) <= 128)
			{
				is_lootable = "바닥에 떨어진 아이템";
			}
		}
	}

	
	
	//아이템 루팅 중...
	if (is_lootable != "")
	{
		var tmp_key;
		if (tmp_ins.is_opened != -4)
		{
			tmp_key = -4;
			draw_interaction_key(tmp_ins,tmp_key,"루팅 중");
		}
		else
		{
			tmp_key = "F";
			draw_interaction_key(tmp_ins,tmp_key,"루팅 하기");
		}
		
		
		
		if (tmp_key != -4 && keyboard_check_pressed(ord(tmp_key)) && !instance_exists(n_looting_inv_id))
		{
			n_looting_inv_id = show_inv_ui(1000,300,is_lootable,tmp_ins,128);
			tmp_ins.is_opened = n_looting_inv_id;
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