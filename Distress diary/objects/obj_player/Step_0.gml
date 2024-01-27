/// @description 클라이언트 영향 받는 스텝 이벤트
// You can write your code in this editor

//캐릭터가 본인의 캐릭터거나, 서버 자체를 열지 않은 경우 조작 가능
if ((instance_exists(code_m) && code_m.server == -4) || global.my_player_id == obj_id_player_only)
{
	if (global.camera_target != -4)
	{
		global.camera_target = id;
	}
	
	//이동 관련
	if (keyboard_check(ord("W")))
	{
		global.n_dir = 1;
		global.movement_vspeed += (-global.max_movement_vspeed - global.movement_vspeed)*0.1;
	}
	else if (keyboard_check(ord("S")))
	{
		global.n_dir = 3;
		global.movement_vspeed += (global.max_movement_vspeed - global.movement_vspeed)*0.1;
	}

	if (keyboard_check(ord("D")))
	{
		global.n_dir = 0;
		global.movement_hspeed += (global.max_movement_hspeed - global.movement_hspeed)*0.1;
	}
	else if (keyboard_check(ord("A")))
	{
		global.n_dir = 2;
		global.movement_hspeed += (-global.max_movement_hspeed - global.movement_hspeed)*0.1;
	}


	if (keyboard_check_released(ord("A")) || keyboard_check_released(ord("D")))
	{
		global.movement_hspeed = 0;
	}

	if (keyboard_check_released(ord("W")) || keyboard_check_released(ord("S")))
	{
		global.movement_vspeed = 0;
	}





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
}
else
{
	var tmp_tickrate = (abs(x - tickrate_x) < 256 && abs(y - tickrate_y) < 256 && abs(z - tickrate_z) < 256) ? global.tickrate : 1;

	x += (tickrate_x - x)/tmp_tickrate;
	y += (tickrate_y - y)/tmp_tickrate;
	z += (tickrate_z - z)/tmp_tickrate;
}