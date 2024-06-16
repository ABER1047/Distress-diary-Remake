/// @description Insert description here
// You can write your code in this editor
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);

var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);

var xx_center = xx+xx_w*0.5;
var yy_center = yy+yy_h*0.5;

var tmp_c_x = 0.5//global.n_camera_zoom;


var tmp_room_xx = room_width*0.5;
var tmp_room_yy = room_height*0.5;
var tmp_wall_scale = 2;
var tmp_wall_sprite_size = tmp_wall_scale*48;
var n_wall_type = global.n_room_tileset;
if (global.enable_light_surf && global.is_map_exists != -4 && surface_exists(global.outter_room_surf))
{
	surface_set_target(global.outter_room_surf);
	draw_clear(0);
	draw_sprite_ext(spr_wall_mask_bottom,1,0,0,84,84,0,c_black,1);
	

	gpu_set_blendmode(bm_subtract);
	draw_set_alpha(1);
	draw_set_color(c_white);
	var tmp_xx1_surf = tmp_room_xx-global.n_room_width*0.5*tmp_wall_sprite_size;
	var tmp_yy1_surf = tmp_room_yy-global.n_room_height*0.5*tmp_wall_sprite_size;
	var tmp_xx2_surf = tmp_room_xx+global.n_room_width*0.5*tmp_wall_sprite_size;
	var tmp_yy2_surf = tmp_room_yy+global.n_room_height*0.5*tmp_wall_sprite_size;
	draw_rectangle(tmp_xx1_surf-47-xx,tmp_yy1_surf-192-yy,tmp_xx2_surf-48-xx,tmp_yy2_surf-4-yy,false);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();

	draw_surface_ext(global.outter_room_surf,xx,yy,1,1,0,c_black,1);
}


//현재 불러와진 룸 그리기
for(var i = 0; i < global.n_room_width; i++)
{
	//아래쪽 벽 그리기
	var tmp_spr_ind = n_wall_type*9+5;
	if (i == 0)
	{
		tmp_spr_ind -= 1;
	}
	else if (i == global.n_room_width-1)
	{
		tmp_spr_ind += 1;
	}
	draw_sprite_ext(spr_tiles_walls,tmp_spr_ind,tmp_room_xx+(-global.n_room_width*0.5+i)*tmp_wall_sprite_size,tmp_room_yy+global.n_room_height*0.5*tmp_wall_sprite_size,tmp_wall_scale,tmp_wall_scale,0,c_white,1);
}



var tmp_wall_sprite_size2 = tmp_wall_scale*96;
for(var i = -1; i < floor((global.n_room_height-1)*0.5); i++)
{
	//왼쪽 벽 그리기
	var tmp_spr_ind = n_wall_type*9+7;
	if (i == -1)
	{
		tmp_spr_ind += 1;
	}
	draw_sprite_ext(spr_tiles_walls,tmp_spr_ind,tmp_room_xx-global.n_room_width*0.5*tmp_wall_sprite_size,tmp_room_yy-global.n_room_height*0.5*tmp_wall_sprite_size+i*tmp_wall_sprite_size2+tmp_wall_sprite_size2,-tmp_wall_scale,tmp_wall_scale,0,c_white,1);
	
	
	//오른쪽 벽 그리기
	draw_sprite_ext(spr_tiles_walls,tmp_spr_ind,tmp_room_xx+global.n_room_width*0.5*tmp_wall_sprite_size-8*tmp_wall_scale,tmp_room_yy-global.n_room_height*0.5*tmp_wall_sprite_size+i*tmp_wall_sprite_size2+tmp_wall_sprite_size2,-tmp_wall_scale,tmp_wall_scale,0,c_white,1);
}






//라이트 서피스 그리기
if (global.enable_light_surf && surface_exists(global.light_surf))
{
	gpu_set_blendmode(bm_subtract);
	draw_surface_ext(global.light_surf,xx,yy,1,1,0,c_white,1);
	gpu_set_blendmode(bm_normal);
}












//개발자 모드 디버그 용
if (global.dev_mode == 1)
{
	if (!global.chat_activated)
	{
		draw_set_font(font_normal);
		draw_set_alpha(1);
	
		draw_text_k_scale(xx+8,yy+32,"전체화면 [ESC]\n지도 보기 [`]\n채팅창 [U/Enter]\n닉네임 변경 [Q]\n스킨 변경 [Y]\n가방 변경 [T]\n명령어 가이드 [/help]\n\n인벤토리 열기/닫기 [Tab]\n아이템 회전 [R]\n아이템 반절 나누기 [Shift]\n랜덤 상자 생성 [P]\n플래시 라이트 [E]",64,-1,1,c_white,1,-1,font_normal,0.3,0.3,0);
	
		var tmp_my_player_id = 0;
		if (global.my_player_id >= 0 && global.my_player_id < array_length(global.my_player_ins_id))
		{
			tmp_my_player_id = global.my_player_id;
		}
		var tmp_my_p = global.my_player_ins_id[tmp_my_player_id];
		var tmp_xx = global.n_player_room_xx[tmp_my_player_id];
		var tmp_yy = global.n_player_room_yy[tmp_my_player_id];
		var tmp_str = "no room";
		if (tmp_xx >= 0)
		{
			tmp_str = global.map_arr[tmp_xx][tmp_yy];
		}
		var tmp_guide_txt1 = "초당 평균 프레임 : "+string(global.average_fps_for_draw)+"\n온라인 서버 생성 [F12]\n온라인 서버 접속 [F11]\n디버그 창 열기/닫기 [F10]\n접속 인원 보기 [Capslock]\n현재 시간 : "+string(global.time_display)+" ["+string((global.time_is_day) ? "Day" : "Night")+"]";
		var tmp_guide_txt2 = "초당 평균 프레임 : "+string(global.average_fps_for_draw)+"\n초대 코드 : "+string(global.invite_code)+"\n"+string(keyboard_check(ord("I")) ? "내 아이피 : "+string(global.my_ip) : "아이피 보기[I]")+"\nglobal.is_server : "+string(global.is_server)+"\nTickRate : "+string(global.tickrate)+"\n최대 허용 핑 : "+string(global.maximum_ping_acception);
	
		var in_room_obj_num = 0;
		with(obj_parents)
		{
			if (!stop_cal_by_pos_statement)
			{
				in_room_obj_num ++;
			}
		}
		draw_text_k_scale(xx+xx_w-8,yy+yy_h-640,string((code_m.server == -4) ? tmp_guide_txt1 : tmp_guide_txt2)+"\n\n닉네임 : "+string(global.nickname)+"\n\n내 플레이어 id : "+string(global.my_player_id)+"\n플레이어 위치 :\nx "+string(global.n_player_room_xx)+"\ny "+string(global.n_player_room_yy)+"\nweight : "+string(global.my_weight)+"\nhspeed : "+string(global.movement_hspeed)+" _vspeed : "+string(global.movement_vspeed)+"\n현재 룸 정보 : "+string(tmp_str)+"\n오브젝트 갯수 : "+string(instance_number(all))+" / effects : "+string(instance_number(obj_effect_parents))+" / in_room : "+string(in_room_obj_num),64,-1,1,c_white,1,1,font_normal,0.3,0.3,0);
	
		//맵 드로우
		global.show_map_data = keyboard_check(222) || keyboard_check(192) || keyboard_check(ord("`"));
	
		//랜덤 닉네임
		if (keyboard_check_pressed(ord("Q")))
		{
			global.nickname = randomized_nickname();
			show_message_log("- 변경된 닉네임 : "+string(global.nickname));

			tmp_my_p.nickname = global.nickname;
			send_InstanceVariableData(tmp_my_p,"nickname");
		}
	
	
	
	
	
	
		//접속인원
		if (keyboard_check(20))
		{
			var tmp_yy = yy+yy_h*0.3;
			var tmp_width = 320*(1920/xx_w);
			var outline_weight = 3*(1920/xx_w);
			var tmp_player_num = ds_list_size(global.client_num);
		
			draw_text_kl_scale(xx_center,tmp_yy-tmp_player_num*48-128,"접속 인원",64,-1,1,c_white,-1,0,font_normal,0.3,0.3,0);
		
		
			//전체 내부 배경
			draw_set_alpha(0.9);
			draw_set_color(c_black);
			draw_rectangle(xx_center-tmp_width,tmp_yy-tmp_player_num*48,xx_center+tmp_width,tmp_yy+tmp_player_num*64,false);
		
			//전체 외곽선
			draw_set_alpha(1);
			draw_set_color(c_white);
			for(var i = 0; i < outline_weight; i++)
			{
				draw_rectangle(xx_center-tmp_width-i,tmp_yy-tmp_player_num*48-i,xx_center+tmp_width+i,tmp_yy+tmp_player_num*64+i,true);
			}
		
			for(var i = 0; i <= tmp_player_num; i++)
			{
				var tmp_player_id = fix_to_zero(ds_list_find_value(global.client_num,i));
				var tmp_yy2 = (tmp_yy-tmp_player_num*48) + ((i+1)*32);
				if (i != tmp_player_num)
				{
					//플레이어 칸 나누는 선
					draw_set_alpha(0.7);
					draw_line_width(xx_center-tmp_width,tmp_yy2,xx_center+tmp_width,tmp_yy2,outline_weight);
			
					//플레이어 이름
					draw_text_kl_scale(xx_center-tmp_width+outline_weight*4,tmp_yy2-48,string(global.my_player_ins_id[tmp_player_id].nickname),64,-1,1,c_white,-1,-1,font_normal,0.3,0.3,0);
			
					//핑
					var tmp_ping_real = (tmp_player_id < 1) ? 0 : global.users_ping_display[tmp_player_id-1];
					var tmp_img_ind = fix_num_inside(round(256-tmp_ping_real)/45,0,5);
					draw_sprite_ext(spr_ping_state,tmp_img_ind,xx_center+tmp_width-outline_weight*16,tmp_yy2-16,1.25*(1920/xx_w),1.25*(1920/xx_w),0,c_white,1);
					draw_text_kl_scale(xx_center+tmp_width-outline_weight*32,tmp_yy2-32,"["+string(tmp_ping_real)+"ms]",64,-1,1,c_white,-1,1,font_normal,0.25,0.25,0);
				}
				else
				{
					//플레이어 이름
					draw_text_kl_scale(xx_center,tmp_yy2-60,"...",64,-1,1,c_white,-1,0,font_normal,0.3,0.3,0);
				}
			}
		}
	}
	
	
	if (!global.chat_activated)
	{
		//모든 상자에 아이템 생성
		if (keyboard_check_pressed(ord("B")))
		{
			with(obj_loots)
			{
				if (object_index == obj_loots)
				{
					set_inv_variable(id,0,0,spr_comp,7,-4,0,0);
				}
			}
		}
		
		//스킨 변경
		if (keyboard_check_pressed(ord("Y")))
		{
			global.player_skin ++;
			if (global.player_skin < 0)
			{
				global.player_skin = global.player_skin_num-1;
			}
			else if (global.player_skin >= global.player_skin_num)
			{
				global.player_skin = 0;
			}
			show_message_log("- 플레이어 스킨 변경 : "+string(sprite_get_name(obj_player.sprite_index)));
		}
	
		//가방 변경
		if (keyboard_check_pressed(ord("T")))
		{
			global.n_backpack ++;
			if (global.n_backpack < 0)
			{
				global.n_backpack = global.backpack_num-1;
			}
			else if (global.n_backpack >= global.backpack_num)
			{
				global.n_backpack = 0;
			}
			show_message_log("- 가방 변경 : "+string(global.n_backpack));
		}
	
	
	
		//랜덤 상자 생성
		var tmp_img = choose(0,2,4,6,8,10,12,14,16,18,24,26)
		var tmp_xx = room_width*0.5+round((mouse_x-room_width*0.5)/96)*96;
		var tmp_yy = room_height*0.5+round((mouse_y-room_height*0.5)/96)*96;
		var tmp_ins = instance_place(mouse_x,mouse_y,obj_parents);
		if (keyboard_check(ord("P")))
		{
			if (!instance_exists(tmp_ins))
			{
				draw_sprite_ext(spr_block_hitbox,1,tmp_xx,tmp_yy,2.5,2.5,0,#4AD05A,0.3);
				draw_sprite_ext(spr_objects,tmp_img,tmp_xx,tmp_yy,2.5,2.5,0,c_white,0.5);
			}
			else
			{
				draw_sprite_ext(spr_block_hitbox,1,tmp_xx,tmp_yy,2.5,2.5,0,#E64A53,0.5);
			}
		}

		if (keyboard_check_released(ord("P")))
		{
			if (instance_exists(tmp_ins))
			{
				instance_destroy_multiplayer(tmp_ins);
			}
			else
			{
				create_randomized_loots(tmp_xx,tmp_yy,tmp_img,global.object_id_ind,0,-4,-4);
			}
		}
	
	
	
		//블럭 생성
		var tmp_img = 0;
		var tmp_xx = room_width*0.5+round((mouse_x-room_width*0.5)/96)*96;
		var tmp_yy = room_height*0.5+round((mouse_y-room_height*0.5)/96)*96;
		var tmp_ins = instance_place(mouse_x,mouse_y,obj_parents);
		if (keyboard_check(ord("O")))
		{
			if (!instance_exists(tmp_ins))
			{
				draw_sprite_ext(spr_block_hitbox,1,tmp_xx,tmp_yy,2.5,2.5,0,#4AD05A,0.3);
				draw_sprite_ext(spr_objects,tmp_img,tmp_xx,tmp_yy,2.5,2.5,0,c_white,0.5);
			}
			else
			{
				draw_sprite_ext(spr_block_hitbox,1,tmp_xx,tmp_yy,2.5,2.5,0,#E64A53,0.5);
			}
		}

		if (keyboard_check_released(ord("O")))
		{
			if (instance_exists(tmp_ins))
			{
				instance_destroy_multiplayer(tmp_ins);
			}
			else
			{
				var rd_choose = choose(0,4,5,5,5,5,5);
				if (rd_choose == 0)
				{
					instance_create_multiplayer(obj_vending_machine,tmp_xx,tmp_yy,global.object_id_ind,9,false,-4,-4);
				}
				else if (rd_choose == 1)
				{
					instance_create_multiplayer(obj_only_breakable,tmp_xx,tmp_yy,global.object_id_ind,irandom_range(76,87),false,-4,-4);
				}
				else if (rd_choose == 2)
				{
					instance_create_multiplayer(obj_arcade_pc,tmp_xx,tmp_yy,global.object_id_ind,12,false,-4,-4);
				}
				else if (rd_choose == 3)
				{
					instance_create_multiplayer(obj_floor_button,tmp_xx,tmp_yy,global.object_id_ind,choose(56,58,60),false,-4,-4);
				}
				else if (rd_choose == 4)
				{
					var tmp_ins = instance_create_multiplayer(obj_ineractable_fire,tmp_xx,tmp_yy,global.object_id_ind,irandom_range(0,3),false,-4,-4);
					tmp_ins.is_opened = choose(true,false);
					tmp_ins.fire_type = choose(0,1);
				}
				else if (rd_choose == 5)
				{
					var tmp_ins = instance_create_multiplayer(obj_spike_trap,tmp_xx,tmp_yy,global.object_id_ind,0,false,-4,-4);
				}
			}
		}
	}
	
	

	
	//인벤토리
	if (keyboard_check_pressed(vk_tab))
	{
		if (!instance_exists(global.showing_inv))
		{
			global.showing_inv = show_inv_ui(400,320,"인벤토리",global.my_player_ins_id[global.my_player_id],-4);
		}
		else
		{
			instance_destroy(global.showing_inv);
		}
		show_message_log("- 인벤토리 열기/닫기 ["+string(global.showing_inv)+"]");
	}
	
	
	//전체화면
	if (!instance_exists(obj_ui_parents) && keyboard_check_pressed(vk_escape))
	{
		event_user(1);
	}
}




//맵 드로우 코드 && 맵이 존재하는 경우
if (global.is_map_exists != -4)
{
	//플레이어 위치를 중심으로 좌우 총 합 5칸씩 표시
	var tmp_size = 3; //플레이어 중심으로 좌우로 몇칸까지 표시할지 (양옆으로 2칸씩 = 총 5칸)
	var ui_scale = 0.5; //지도 UI사이즈 지정용
	var real_scale = ui_scale*64; // 얘는 건들지 마셈
	if (surface_exists(global.map_ui_surf))
	{
		surface_set_target(global.map_ui_surf);
		draw_clear_alpha(c_black,0);
		
		//플레이어 현재 위치 참조용 임시 변수
		var tmp_my_p_pos_xx = global.n_player_room_xx[global.my_player_id], tmp_my_p_pos_yy = global.n_player_room_yy[global.my_player_id];
		var check_gq = (global.graphics_quality > 0);
		if (check_gq)
		{
			var outline_textrue_scale = (1/31)*tmp_size*real_scale*2;
			//뒷 배경
			draw_sprite_ext(spr_map_outline,1,real_scale,real_scale,outline_textrue_scale,outline_textrue_scale,0,c_black,0.7);
		}
		
		//선 색 지정
		draw_set_color(#333333);
		draw_set_alpha(1);
		for(var i = -tmp_size; i <= tmp_size; i++)
		{
			for(var ii = -tmp_size; ii <= tmp_size; ii++)
			{
				var dx = tmp_my_p_pos_xx + ii, dy = tmp_my_p_pos_yy + i;
				
				//배열 크기를 벗어나지 않는 경우
				if (is_inside_rectangle(dx,dy,-1,-1,global.map_width,global.map_height))
				{
					//이미 발견한 방이나 현재 방과 연결된 바로 옆방만 드로우
					var tmp_connected_xx1 = global.room_connected_to_xx[dy][dx];
					var tmp_connected_yy1 = global.room_connected_to_yy[dy][dx];
					var tmp_connected_xx2 = global.room_connected_to_xx_sec[dy][dx];
					var tmp_connected_yy2 = global.room_connected_to_yy_sec[dy][dx];
					
					var is_room_connected = (tmp_connected_xx1 == tmp_my_p_pos_xx && tmp_connected_yy1 == tmp_my_p_pos_yy) || (tmp_connected_xx2 == tmp_my_p_pos_xx && tmp_connected_yy2 == tmp_my_p_pos_yy);
					var is_drawable = (global.map_arr[dy][dx] > 1) || (global.map_arr[dy][dx] == 1 && abs(ii)+abs(i) <= 1 && is_room_connected);
					if (is_drawable)
					{
						var tmp_ui_xx = (1+tmp_size+ii)*real_scale; //서피스에 드로우 될 지도의 x좌표 위치
						var tmp_ui_yy = (1+tmp_size+i)*real_scale; //서피스에 드로우 될 지도의 y좌표 위치
						var tmp_img_ind = 0; //지도에 표기되는 spr_map_ui_room의 이미지 인덱스
						var tmp_arr_length = array_length(global.n_player_room_xx); //어레이 길이 저장용 임시 변수



						//모든 플레이어 위치를 점 ui로 표시
						for(var k = 0, tmp_index = 0; k < tmp_arr_length; k++)
						{
							//해당 칸에 플레이어가 존재하는지 체크 (나 자신 및 다른 플레이어 모두 포함)
							var tmp_player_xx_pos = global.n_player_room_xx[k], tmp_player_yy_pos = global.n_player_room_yy[k];
							if (tmp_player_xx_pos >= 0 && tmp_player_xx_pos == dx && tmp_player_yy_pos == dy)
							{
								//존재하는 경우 위치 표시
								tmp_index ++;
							}
						}
						
						if (tmp_index >= 1)
						{
							tmp_img_ind = 1+tmp_index;
						}
						else if (global.map_arr[dy][dx] == 2)
						{
							tmp_img_ind = 1;
						}
					

						if (tmp_connected_xx1 != -4)
						{
							var tmp_xx_sign = sign(global.room_connected_to_xx[dy][dx]-dx);
							var tmp_yy_sign = sign(global.room_connected_to_yy[dy][dx]-dy);
							var tmp_val1 = tmp_xx_sign*27*ui_scale;
							var tmp_val2 = tmp_yy_sign*27*ui_scale;
							var tmp_line_xx_start = tmp_ui_xx + tmp_val1;
							var tmp_line_yy_start = tmp_ui_yy + tmp_val2;
							var tmp_line_xx_end = tmp_ui_xx + tmp_xx_sign*real_scale - tmp_val1;
							var tmp_line_yy_end = tmp_ui_yy + tmp_yy_sign*real_scale - tmp_val2;
							draw_line_width(tmp_line_xx_start,tmp_line_yy_start,tmp_line_xx_end,tmp_line_yy_end,6*ui_scale);
						}
						if (tmp_connected_xx2 != -4)
						{
							var tmp_xx_sign = sign(global.room_connected_to_xx_sec[dy][dx]-dx);
							var tmp_yy_sign = sign(global.room_connected_to_yy_sec[dy][dx]-dy);
							var tmp_val1 = tmp_xx_sign*27*ui_scale;
							var tmp_val2 = tmp_yy_sign*27*ui_scale;
							var tmp_line_xx_start = tmp_ui_xx + tmp_val1;
							var tmp_line_yy_start = tmp_ui_yy + tmp_val2;
							var tmp_line_xx_end = tmp_ui_xx + tmp_xx_sign*real_scale - tmp_val1;
							var tmp_line_yy_end = tmp_ui_yy + tmp_yy_sign*real_scale - tmp_val2;
							draw_line_width(tmp_line_xx_start,tmp_line_yy_start,tmp_line_xx_end,tmp_line_yy_end,6*ui_scale);
						}
						draw_sprite_ext(spr_map_ui_room,tmp_img_ind,tmp_ui_xx,tmp_ui_yy,ui_scale,ui_scale,0,c_white,1);
					}
				}
			}
		}
		
		if (check_gq)
		{
			//테두리
			draw_sprite_ext(spr_map_outline,0,real_scale,real_scale,outline_textrue_scale,outline_textrue_scale,0,c_white,1);
		}
		surface_reset_target();
		
		var map_width = real_scale*tmp_size*2;
		draw_surface_part_ext(global.map_ui_surf,real_scale,real_scale,map_width,map_width,xx+xx_w - (1+tmp_size)*real_scale*2,yy + (1+tmp_size)*real_scale*2,1,1,c_white,1);
	}
	else
	{
		//지도용 서피스
		global.map_ui_surf = surface_create(real_scale*(1+tmp_size)*2,real_scale*(1+tmp_size)*2);
	}
}