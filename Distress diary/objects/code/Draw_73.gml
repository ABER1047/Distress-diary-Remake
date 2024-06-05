/// @description Insert description here
// You can write your code in this editor
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);

var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);

var xx_center = xx+xx_w*0.5;
var yy_center = yy+yy_h*0.5;

var tmp_c_x = 0.5//global.n_camera_zoom;


//룸 바깥쪽 가림막 그리기
var tmp_room_xx = room_width*0.5;
var tmp_room_yy = room_height*0.5;
var tmp_wall_scale = 2;
var tmp_wall_sprite_size = tmp_wall_scale*48;
var n_wall_type = global.n_room_tileset;

if (global.enable_light_surf && global.is_map_exists != -4 && surface_exists(outter_room_surf))
{
	surface_set_target(outter_room_surf);
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

	draw_surface_ext(outter_room_surf,xx,yy,1,1,0,c_black,1);
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
	draw_set_font(font_normal);
	draw_set_alpha(1);
	
	draw_text_k_scale(xx+8,yy+32,"전체화면 [ESC]\n지도 보기 [`]\n채팅창 [U/Enter]\n닉네임 변경 [Q]\n스킨 변경 [Y]\n가방 변경 [T]\n명령어 가이드 [/help]\n\n인벤토리 열기/닫기 [Tab]\n아이템 회전 [R]\n아이템 반절 나누기 [Shift]\n랜덤 상자 생성 [P]\n플래시 라이트 [E]",64,-1,1,c_white,0,-1,font_normal,0.5,0.5,0);
	
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
	draw_text_k_scale(xx+xx_w-8,yy+32,string((code_m.server == -4) ? tmp_guide_txt1 : tmp_guide_txt2)+"\n\n닉네임 : "+string(global.nickname)+"\n\n내 플레이어 id : "+string(global.my_player_id)+"\n플레이어 위치 :\nx "+string(global.n_player_room_xx)+"\ny "+string(global.n_player_room_yy)+"\nweight : "+string(global.my_weight)+"\nhspeed : "+string(global.movement_hspeed)+" _vspeed : "+string(global.movement_vspeed)+"\n현재 룸 정보 : "+string(tmp_str)+"\n오브젝트 갯수 : "+string(instance_number(obj_parents))+" / "+string(instance_number(obj_effect_parents)),64,-1,1,c_white,0,1,font_normal,0.5,0.5,0);
	
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
		var tmp_width = 320*global.n_camera_zoom/global.w_ratio_by_window;
		var outline_weight = 3*global.n_camera_zoom/global.w_ratio_by_window;
		var tmp_player_num = ds_list_size(global.client_num);
		
		draw_text_kl_scale(xx_center,tmp_yy-tmp_player_num*64-128,"접속 인원",64,-1,1,c_white,-1,0,font_normal,0.75*global.n_camera_zoom,0.75*global.n_camera_zoom,0);
		
		
		//전체 내부 배경
		draw_set_alpha(0.9);
		draw_set_color(merge_color(#17111A,c_black,0.5));
		draw_rectangle(xx_center-tmp_width,tmp_yy-tmp_player_num*64,xx_center+tmp_width,tmp_yy+tmp_player_num*64,false);
		
		//전체 외곽선
		draw_set_alpha(1);
		draw_set_color(c_white);
		for(var i = 0; i < outline_weight; i++)
		{
			draw_rectangle(xx_center-tmp_width-i,tmp_yy-tmp_player_num*64-i,xx_center+tmp_width+i,tmp_yy+tmp_player_num*64+i,true);
		}
		
		for(var i = 0; i <= tmp_player_num; i++)
		{
			var tmp_player_id = fix_to_zero(ds_list_find_value(global.client_num,i));
			var tmp_yy2 = (tmp_yy-tmp_player_num*64) + ((i+1)*64);
			if (i != tmp_player_num)
			{
				//플레이어 칸 나누는 선
				draw_set_alpha(0.7);
				draw_line_width(xx_center-tmp_width,tmp_yy2,xx_center+tmp_width,tmp_yy2,outline_weight);
			
				//플레이어 이름
				draw_text_kl_scale(xx_center-tmp_width+outline_weight*4,tmp_yy2-64,string(global.my_player_ins_id[tmp_player_id].nickname),64,-1,1,c_white,-1,-1,font_normal,0.7*global.n_camera_zoom,0.7*global.n_camera_zoom,0);
			
				//핑
				var tmp_ping_real = (tmp_player_id < 1) ? 0 : global.users_ping_display[tmp_player_id-1];
				var tmp_img_ind = fix_num_inside(round(256-tmp_ping_real)/45,0,5);
				draw_sprite_ext(spr_ping_state,tmp_img_ind,xx_center+tmp_width-outline_weight*16,tmp_yy2-32,global.n_camera_zoom*1.25,global.n_camera_zoom*1.25,0,c_white,1);
				draw_text_kl_scale(xx_center+tmp_width-outline_weight*32,tmp_yy2-48,"["+string(tmp_ping_real)+"ms]",64,-1,1,c_white,-1,1,font_normal,0.5*global.n_camera_zoom,0.5*global.n_camera_zoom,0);
			}
			else
			{
				//플레이어 이름
				draw_text_kl_scale(xx_center,tmp_yy2-64,"...",64,-1,1,c_white,-1,0,font_normal,0.7*global.n_camera_zoom,0.7*global.n_camera_zoom,0);
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
				var rd_choose = choose(0,4,4,4);
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
					instance_create_multiplayer(obj_ineractable_fire,tmp_xx,tmp_yy,global.object_id_ind,irandom_range(0,3),false,-4,-4);
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




//맵 드로우 코드
if (global.show_map_data == 1)
{
	var room_ui_scale = 16/(global.map_height);
	var tmp_space = (52*room_ui_scale+16)*tmp_c_x;
	var tmp_xx = (xx_center-global.map_width/2*tmp_space);
	var tmp_yy = (yy_center-global.map_height/2*tmp_space);
	//맵이 존재하는 경우
	if (global.is_map_exists != -4)
	{
		draw_set_alpha(global.show_map_data*0.85);
		draw_set_color(#090708);
		draw_rectangle(tmp_xx-tmp_space,tmp_yy-tmp_space,tmp_xx+global.map_width*tmp_space,tmp_yy+global.map_height*tmp_space,false);
		
		draw_set_alpha(global.show_map_data);
		for(var i = 0; i < global.map_height; i++)
		{
			for(var ii = 0; ii < global.map_width; ii++)
			{
				var draw_xx = tmp_xx+ii*tmp_space;
				var draw_yy = tmp_yy+i*tmp_space;
				
				
				//방 연결된거 표시
				if (global.room_connected_to_xx[i][ii] != -4)
				{
					draw_set_color(#333333);
					draw_line_width(draw_xx,draw_yy,tmp_xx+global.room_connected_to_xx[i][ii]*tmp_space,tmp_yy+global.room_connected_to_yy[i][ii]*tmp_space,8*tmp_c_x*room_ui_scale);
				}
				
				//방 연결된거 표시 (sec)
				if (global.room_connected_to_xx_sec[i][ii] != -4)
				{
					draw_set_color(#333333);
					draw_line_width(draw_xx,draw_yy,tmp_xx+global.room_connected_to_xx_sec[i][ii]*tmp_space,tmp_yy+global.room_connected_to_yy_sec[i][ii]*tmp_space,8*tmp_c_x*room_ui_scale);
				}
			}
		}
		
		
		
		for(var i = 0; i < global.map_height; i++)
		{
			for(var ii = 0; ii < global.map_width; ii++)
			{
				var draw_xx = tmp_xx+ii*tmp_space;
				var draw_yy = tmp_yy+i*tmp_space;
				
				
				
				//방 표시
				if (global.map_arr[i][ii] > 0)
				{
					var img_ind = (global.map_arr[i][ii] != 2) ? 0 : 1;
					for(var k = 0; k < array_length(global.n_player_room_xx); k++)
					{
						if (global.n_player_room_xx[k] == ii && global.n_player_room_yy[k] == i)
						{
							img_ind = 2;
						}
					}
					
					draw_sprite_ext(spr_map_ui_room,img_ind,draw_xx,draw_yy,tmp_c_x*room_ui_scale,tmp_c_x*room_ui_scale,0,c_white,global.show_map_data);
					
					//방 아이콘 표시
					var img_ind_by_room_type = -4
					if (global.map_room_type[i][ii] == 1)
					{
						img_ind_by_room_type = 11;
					}
					else if (global.map_room_type[i][ii] == 2)
					{
						img_ind_by_room_type = 12;
					}
					else if (global.map_room_type[i][ii] == 3)
					{
						img_ind_by_room_type = 13;
					}
					else if (global.map_room_type[i][ii] == 4)
					{
						img_ind_by_room_type = 14;
					}
					
					if (img_ind_by_room_type != -4)
					{
						draw_sprite_ext(spr_ui,img_ind_by_room_type,draw_xx,draw_yy,tmp_c_x*room_ui_scale*0.8,tmp_c_x*room_ui_scale*0.8,0,c_white,global.show_map_data);
					}
					/*var angle = -4;
					if (global.room_connected_to_xx[i][ii] < ii && global.room_connected_to_yy[i][ii] == i)
					{
						angle = 270;
					}
					else if (global.room_connected_to_xx[i][ii] > ii && global.room_connected_to_yy[i][ii] == i)
					{
						angle = 90;
					}
					else if (global.room_connected_to_xx[i][ii] == ii && global.room_connected_to_yy[i][ii] < i)
					{
						angle = 180;
					}
					else if (global.room_connected_to_xx[i][ii] == ii && global.room_connected_to_yy[i][ii] > i)
					{
						angle = 0;
					}
					
					if (angle != -4)
					{
						var is_someone_here = 0;
						for(var k = 0; k < array_length(global.n_player_room_xx); k++)
						{
							if (global.n_player_room_xx[k] == ii && global.n_player_room_yy[k] == i)
							{
								is_someone_here = 1;
							}
						}
						
						//현재 위치 표시 + 이동 가능한 방 표시
						//draw_sprite_ext(spr_arrow_ui,0,draw_xx,draw_yy,tmp_c_x*room_ui_scale,tmp_c_x*room_ui_scale,angle,(is_someone_here == 1) ? #46376A : #3B3447,global.show_map_data);
					}*/
					

					
					//if (global.room_connected_to_xx_sec[i][ii] != -4)
					//{
						//var tmp_str_2 = "("+string(global.room_connected_to_xx_sec[i][ii])+", "+string(global.room_connected_to_yy_sec[i][ii])+")";
						//draw_text_kl_scale(draw_xx,draw_yy,tmp_str_2,64,-1,global.show_map_data,c_white,0,0,font_light,tmp_c_x*room_ui_scale*0.3,tmp_c_x*room_ui_scale*0.3,0);
					//}
					
					//show_debug_message("drawing_map ("+string(tmp_xx)+", "+string(tmp_yy)+")   /   "+string(xx))
				}
				//else
				//{
				//	draw_sprite_ext(tmp_sprite,1,draw_xx,draw_yy,tmp_c_x*room_ui_scale,tmp_c_x*room_ui_scale,0,merge_color(c_black,c_white,0.1),global.show_map_data);
				//}
			}
		}
	}
}