/// @description Insert description here
// You can write your code in this editor

var tmp_my_p = (global.my_player_id < array_length(global.my_player_ins_id)) ? global.my_player_ins_id[global.my_player_id] : global.my_player_ins_id[0];

//라이트 서피스 (광원)
if (global.enable_light_surf && surface_exists(global.light_surf))
{
	var xx = camera_get_view_x(view_camera[0]);
	var yy = camera_get_view_y(view_camera[0]);
	
	//플래시라이트
	surface_set_target(global.flashlight_surf);
	draw_clear_alpha(c_black,0);
	//거리에 따른 라이트 크기 조절
	var light_col = c_white;
	var tmp_player_xx = tmp_my_p.x;
	var tmp_player_yy = tmp_my_p.y-24;
	var tmp_light_xx_surf = tmp_player_xx-xx;
	var tmp_light_yy_surf = tmp_player_yy-tmp_my_p.z-yy;
	var light_ang = point_direction(tmp_player_xx,tmp_player_yy,mouse_x,mouse_y);
	//플레이어가 바라보는 방향을 마우스 방향으로 고정
	if (global.fixed_dir == 1)
	{
		if (light_ang <= 50 || light_ang >= 310)
		{
			global.n_dir = 0;
		}
		else if (light_ang > 50 && light_ang < 130)
		{
			global.n_dir = 1;
		}
		else if (light_ang >= 130 && light_ang <= 230)
		{
			global.n_dir = 2;
		}
		else
		{
			global.n_dir = 3;
		}
	}
	
	
	//버블이펙트 (is_bright == true인 경우)
	with(obj_bubble_effect)
	{
		if (is_bright)
		{
			var tmp_img_scale = image_xscale*0.054*4;
			draw_sprite_ext(spr_grad_circle,0,x-xx,y-yy,tmp_img_scale,tmp_img_scale,image_angle,merge_color(image_blend,c_white,0.3),image_alpha*2);
		}
	}
		
	
	
	
	//플레이어 주변 광원
	var tmp_radius = (4/1191)*(64+(128*global.enable_flashlight)+(global.time_response_light*480));
	draw_sprite_ext(spr_grad_circle,0,tmp_light_xx_surf,tmp_light_yy_surf,tmp_radius,tmp_radius,0,light_col,0.65*(1+global.time_response_light));
	//draw_circle(tmp_light_xx_surf,tmp_light_yy_surf,128,false);
	
	if (global.enable_flashlight)
	{
		var light_scale = 0.25;
		var max_light_dis = 1278*light_scale;
		var light_dis = fix_num_inside(point_distance(tmp_player_xx,tmp_player_yy,mouse_x,mouse_y),0,max_light_dis);
		var i = 0;
		var tmp_light_graphic_quality = ceil(27/(global.graphics_quality+1));
		//플레이어가 바라보는 방향에 대해 플레이어부터 벽까지의 거리값
		for(; i < light_dis; i += tmp_light_graphic_quality)
		{
			if (position_meeting(tmp_player_xx+lengthdir_x(i,light_ang),tmp_player_yy+lengthdir_y(i,light_ang),obj_wall_parents))
			{
				break;
			}
		}
			
		//라이트 이미지 바디 부분
		var light_inner_deg = radtodeg(arctan(360/1278))*(1+(max_light_dis-i)/110); //삼각형 내부 끼인 각의 절반값 (라이트)
		show_debug_message("dis : "+string(i)+" / deg : "+string(light_inner_deg)+" / ang : "+string(global.n_dir)+" ("+string(light_ang)+")");
		var tmp_val1 = light_ang-light_inner_deg;
		var tmp_val2 = light_ang+light_inner_deg;
		var tmp_light_xx1_body = tmp_light_xx_surf+lengthdir_x(i,tmp_val1);
		var tmp_light_yy1_body = tmp_light_yy_surf+lengthdir_y(i,tmp_val1);
		var tmp_light_xx2_body = tmp_light_xx_surf+lengthdir_x(i,tmp_val2);
		var tmp_light_yy2_body = tmp_light_yy_surf+lengthdir_y(i,tmp_val2);
		draw_set_alpha(0.7);
		draw_set_color(light_col);
		draw_triangle(tmp_light_xx_surf,tmp_light_yy_surf,tmp_light_xx1_body,tmp_light_yy1_body,tmp_light_xx2_body,tmp_light_yy2_body,false)
	
		//라이트 이미지 헤드 부분
		var tmp_light_xx_head = tmp_light_xx_surf+lengthdir_x(i,light_ang);
		var tmp_light_yy_head = tmp_light_yy_surf+lengthdir_y(i,light_ang);
		var radius_pixel = 360*light_scale-(i-max_light_dis)*light_scale;
		draw_set_alpha(1);
		draw_circle(tmp_light_xx_head,tmp_light_yy_head,radius_pixel,false);
	}
	surface_reset_target();
	
	
	


	surface_set_target(global.light_surf);
	//검은색 배경
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_color);
	draw_set_color($ffffff);
	draw_set_alpha(1);
	draw_rectangle(0, 0, 1920*2, 1080*2, 0);
	
	//flashlight 서피스
	draw_clear(0);
	var light_alpha = 0.68+(0.32*global.time_response_light)+(0.1*global.enable_flashlight); //라이트 밝기
	gpu_set_blendmode(bm_add);
	draw_surface_ext(global.flashlight_surf,0,0,1,1,0,c_white,light_alpha);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	//draw_set_alpha(0.2);
}



//새로운 방 방문 (= 플레이어가 적정 선 이상 이동시 방 문 닫기)
if (global.can_check_room_cleared)
{
	if (instance_exists(tmp_my_p))
	{
		var tmp_xx = global.n_player_room_xx[global.my_player_id];
		if (tmp_xx != -4)
		{
			var tmp_yy = global.n_player_room_yy[global.my_player_id];
			if (global.visited_new_room)
			{
				//방 문을 닫기 전에 먼저 해당 룸이 클리어 된 상태인지 체크
				if (check_is_room_cleared())
				{
					global.visited_new_room = false;
					global.can_check_room_cleared = false;
					alarm[0] = 10;
				}
				else
				{
					// 플레이어가 적정 선 이상 이동시 방 문 닫기
					if (point_distance(global.f_pos_xx,global.f_pos_yy,tmp_my_p.x,tmp_my_p.y) > 32)
					{
						//방 정보 보내기
						send_SpecificPosRoomData(tmp_xx,tmp_yy);
						global.visited_new_room = false;
						global.can_check_room_cleared = false;
						alarm[0] = 10;
					}
				}
			}
			else
			{
				//클리어 판정 체크 후 방 오픈
				if (global.map_arr[tmp_yy][tmp_xx] >= 3 && check_is_room_cleared())
				{
					global.can_check_room_cleared = false;
					global.map_arr[tmp_yy][tmp_xx] = 2;
					send_SpecificPosRoomData(tmp_xx,tmp_yy);
				}
			}
		}
	}
}