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
	show_message_log("현재 룸 사이즈 (가로 x 세로) : "+string(global.n_room_width)+" x "+string(global.n_room_height));
	
	
	
	
	//모든 혈흔 삭제
	instance_destroy(obj_blood_effect);
	
	//모든 벽 삭제
	instance_destroy(obj_wall_parents);
	
	//모든 룸 이동 포탈 삭제
	instance_destroy(obj_nextroom);
	
	
	//위쪽 벽 드로워 생성
	if (!instance_exists(obj_map_texture_draw))
	{
		instance_create_depth(0,0,0,obj_map_texture_draw);
	}
	else
	{
		//바닥 타일 이미지 재랜덤화
		with(obj_map_texture_draw)
		{
			event_user(0);
		}
	}
	
	
	//룸 사이즈 맞게 벽 생성
	var tmp_xx = room_width*0.5;
	var tmp_yy = room_height*0.5;
	var tmp_scale = 2; //wall_parents의 image_scale (플레이어가 현재 2배 사이즈라서 2배 해줌)
	var tmp_sprite_size = 48*tmp_scale; //obj_wall_parents의 스프라이트 사이즈
	
	
	
	//가로 벽 2개 생성
	var tmp_ins = instance_create_depth(tmp_xx-48,tmp_yy-global.n_room_height*0.5*tmp_sprite_size,0,obj_wall_parents);
	tmp_ins.sprite_index = spr_wall_mask_upper;
	tmp_ins.image_xscale = (global.n_room_width+2)*tmp_scale;
	tmp_ins.image_yscale = tmp_scale;
	
	var tmp_ins = instance_create_depth(tmp_xx-48,tmp_yy+(global.n_room_height*0.5+0.5)*tmp_sprite_size,0,obj_wall_parents);
	tmp_ins.sprite_index = spr_wall_mask_bottom;
	tmp_ins.image_xscale = (global.n_room_width+2)*tmp_scale;
	tmp_ins.image_yscale = tmp_scale;
	
	
	
	//세로 벽 2개 생성
	var tmp_ins = instance_create_depth(tmp_xx-global.n_room_width*0.5*tmp_sprite_size-128,tmp_yy,0,obj_wall_parents);
	tmp_ins.sprite_index = spr_wall_mask_left;
	tmp_ins.image_xscale = tmp_scale;
	tmp_ins.image_yscale = (global.n_room_height+2)*tmp_scale;
	
	var tmp_ins = instance_create_depth(tmp_xx+global.n_room_width*0.5*tmp_sprite_size+32,tmp_yy,0,obj_wall_parents);
	tmp_ins.sprite_index = spr_wall_mask_right;
	tmp_ins.image_xscale = tmp_scale;
	tmp_ins.image_yscale = (global.n_room_height+2)*tmp_scale;
	
	
	
	
	
	//다음 방으로 이동하는 포탈 생성
	var tp_xx = [ global.n_room_width*0.5*tmp_sprite_size-64, -48, -global.n_room_width*0.5*tmp_sprite_size-32, -48 ];
	var tp_yy = [ 0, -global.n_room_height*0.5, 0, global.n_room_height*0.5+0.5 ];
	var dx = [ 1, 0, -1, 0 ];
	var dy = [ 0, -1, 0, 1 ];
	var n_xx = global.n_player_room_xx[global.my_player_id];
	var n_yy = global.n_player_room_yy[global.my_player_id];
	
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