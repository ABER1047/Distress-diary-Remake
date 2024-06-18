// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@desc load_room();
///@param x
///@param y
function load_room(argument0,argument1)
{
	//현재 룸 가로/세로 넓이
	global.n_room_width = global.map_room_width[argument1][argument0];
	global.n_room_height = global.map_room_height[argument1][argument0];
	show_debug_message("현재 룸 사이즈 (가로 x 세로) : "+string(global.n_room_width)+" x "+string(global.n_room_height));
	
	

	
	//모든 외부 투명벽 삭제
	for(var i = 0; i < 4; i++)
	{
		if (instance_exists(global.outside_of_map_wall[i]))
		{
			instance_destroy(global.outside_of_map_wall[i]);
		}
	}
	
	//모든 룸 이동 포탈 삭제
	instance_destroy(obj_nextroom);

	//모든 디버프 바닥 이펙트 삭제
	instance_destroy(obj_mucus_effect);
	
	//데미지 로그 ui지우기
	instance_destroy(obj_damage_display);
	
	

	//바닥 타일 이미지 재랜덤화
	with(obj_map_texture_draw)
	{
		event_user(0);
	}
	
	
	//룸 사이즈 맞게 벽 생성
	var tmp_xx = room_width*0.5;
	var tmp_yy = room_height*0.5;
	var tmp_scale = 2; //wall_parents의 image_scale (플레이어가 현재 2배 사이즈라서 2배 해줌)
	var tmp_sprite_size = 48*tmp_scale; //obj_wall_parents의 스프라이트 사이즈
	
	
	
	//가로 벽 2개 생성
	global.outside_of_map_wall[0] = instance_create_depth(tmp_xx-48,tmp_yy-global.n_room_height*0.5*tmp_sprite_size,0,obj_wall_parents);
	global.outside_of_map_wall[0].sprite_index = spr_wall_mask_upper;
	global.outside_of_map_wall[0].image_xscale = (global.n_room_width+2)*tmp_scale;
	global.outside_of_map_wall[0].image_yscale = tmp_scale;
	
	global.outside_of_map_wall[1] = instance_create_depth(tmp_xx-48,tmp_yy+(global.n_room_height*0.5+0.5)*tmp_sprite_size,0,obj_wall_parents);
	global.outside_of_map_wall[1].sprite_index = spr_wall_mask_bottom;
	global.outside_of_map_wall[1].image_xscale = (global.n_room_width+2)*tmp_scale;
	global.outside_of_map_wall[1].image_yscale = tmp_scale;
	
	
	
	//세로 벽 2개 생성
	global.outside_of_map_wall[2] = instance_create_depth(tmp_xx-global.n_room_width*0.5*tmp_sprite_size-128,tmp_yy,0,obj_wall_parents);
	global.outside_of_map_wall[2].sprite_index = spr_wall_mask_left;
	global.outside_of_map_wall[2].image_xscale = tmp_scale;
	global.outside_of_map_wall[2].image_yscale = (global.n_room_height+2)*tmp_scale;
	
	global.outside_of_map_wall[3] = instance_create_depth(tmp_xx+global.n_room_width*0.5*tmp_sprite_size+32,tmp_yy,0,obj_wall_parents);
	global.outside_of_map_wall[3].sprite_index = spr_wall_mask_right;
	global.outside_of_map_wall[3].image_xscale = tmp_scale;
	global.outside_of_map_wall[3].image_yscale = (global.n_room_height+2)*tmp_scale;
	
	
	
	
	
	//다음 방으로 이동하는 포탈 생성
	var tp_xx = [ global.n_room_width*0.5*tmp_sprite_size-64, -48, -global.n_room_width*0.5*tmp_sprite_size-32, -48 ];
	var tp_yy = [ 0, -global.n_room_height*0.5, 0, global.n_room_height*0.5+0.5 ];
	var dx = [ 1, 0, -1, 0 ];
	var dy = [ 0, -1, 0, 1 ];
	var n_xx = global.n_player_room_xx[global.my_player_id];
	var n_yy = global.n_player_room_yy[global.my_player_id];
	
	
	//새로운 방 방문 (= 플레이어가 적정 선 이상 이동시 방 문 닫기)
	if (global.map_arr[argument1][argument0] != 2)
	{
		code.alarm[0] = 10;
		global.visited_new_room = true;
		global.map_arr[argument1][argument0] = 3;
	}
	global.f_pos_xx = global.my_player_ins_id[global.my_player_id].x;
	global.f_pos_yy = global.my_player_ins_id[global.my_player_id].y;
	
	
	
	//내 방 위치정보 전송
	send_MyRoomPos();
	
	
	for(var i = 0; i < 4; i++)
	{
		var t_xx = global.n_player_room_xx[global.my_player_id]+dx[i];
		var t_yy = global.n_player_room_yy[global.my_player_id]+dy[i];

		var is_connected = 0;
		if (is_inside_array(global.map_width,t_xx) && is_inside_array(global.map_height,t_yy))
		{
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
		}

		
		//옆 방 이동 가능한 경우
		if (is_connected == 1)
		{
			var tmp_img_ang = (i-1)*90;
			var tmp_portal_xx = tmp_xx+tp_xx[i];
			var tmp_portal_yy = tmp_yy+tp_yy[i]*tmp_sprite_size;
			var tmp_ins = instance_create_depth(tmp_portal_xx,tmp_portal_yy,0,obj_nextroom);
			tmp_ins.tp_to = i;
			tmp_ins.image_angle = tmp_img_ang;
			
			//입구 주변 벽 생성
			for(var ii = -1; ii <= 1; ii += 2)
			{
				var tmp_ind = (ii == -1) ? 0 : 1;
				var tmp_comp_xx = (i%2 != 0) ? 0 : 44*sign(i-1);
				tmp_ins.ins_wall[tmp_ind] = instance_create_depth(tmp_portal_xx+tmp_comp_xx+lengthdir_x(ii*144,tmp_img_ang),tmp_portal_yy+48+lengthdir_y(ii*144,tmp_img_ang),depth,obj_wall_nearby_door);
			}
		}
	}	
}