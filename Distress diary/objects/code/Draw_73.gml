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
var n_wall_type = 0;

if (global.is_map_exists != -4 && surface_exists(outter_room_surf))
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
	var tmp_spr_ind = n_wall_type*3+4;
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
	var tmp_spr_ind = n_wall_type*3+6;
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
	global.fixed_dir = 1;
	surface_set_target(global.light_surf);
	draw_clear(0);
	draw_sprite_ext(spr_wall_mask_bottom,1,0,0,84,84,0,c_black,1);
	
	var tmp_my_p = global.my_player_ins_id[global.my_player_id];
	gpu_set_blendmode(bm_subtract);
	//draw_set_alpha(0.2);
	
	//거리에 따른 라이트 크기 조절
	var light_col = #FFE651;
	var tmp_player_xx = tmp_my_p.x;
	var tmp_player_yy = tmp_my_p.y-24;
	var tmp_light_xx_surf = tmp_player_xx-xx;
	var tmp_light_yy_surf = tmp_player_yy-tmp_my_p.z-yy;
	var light_scale = 0.25;
	var max_light_dis = 1278*light_scale;
	var light_dis = fix_num_inside(point_distance(tmp_player_xx,tmp_player_yy,mouse_x,mouse_y),0,max_light_dis);
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
	
	
	var i = 0;
	//플레이어가 바라보는 방향에 대해 플레이어부터 벽까지의 거리값
	for(; i < light_dis; i += light_scale)
	{
		if (position_meeting(tmp_player_xx+lengthdir_x(i,light_ang),tmp_player_yy+lengthdir_y(i,light_ang),obj_wall_parents))
		{
			break;
		}
	}
	
	
	
	//플레이어 주변 광원
	var tmp_radius = 4/1191*128;
	draw_sprite_ext(spr_grad_circle,0,tmp_light_xx_surf,tmp_light_yy_surf,tmp_radius,tmp_radius,0,light_col,0.5);
	//draw_circle(tmp_light_xx_surf,tmp_light_yy_surf,128,false);
	
	//라이트 이미지 바디 부분
	var light_alpha = 1; //라이트 밝기
	var light_inner_deg = radtodeg(arctan(360/1278))*(1+(max_light_dis-i)/110); //삼각형 내부 끼인 각의 절반값 (라이트)
	show_debug_message("dis : "+string(i)+" / deg : "+string(light_inner_deg)+" / ang : "+string(global.n_dir)+" ("+string(light_ang)+")");
	var tmp_light_xx1_body = tmp_light_xx_surf+lengthdir_x(i,light_ang-light_inner_deg);
	var tmp_light_yy1_body = tmp_light_yy_surf+lengthdir_y(i,light_ang-light_inner_deg);
	var tmp_light_xx2_body = tmp_light_xx_surf+lengthdir_x(i,light_ang+light_inner_deg);
	var tmp_light_yy2_body = tmp_light_yy_surf+lengthdir_y(i,light_ang+light_inner_deg);
	draw_set_alpha(light_alpha*0.75);
	draw_set_color(light_col);
	draw_triangle(tmp_light_xx_surf,tmp_light_yy_surf,tmp_light_xx1_body,tmp_light_yy1_body,tmp_light_xx2_body,tmp_light_yy2_body,false)
	
	//라이트 이미지 헤드 부분
	var tmp_light_xx_head = tmp_light_xx_surf+lengthdir_x(i,light_ang);
	var tmp_light_yy_head = tmp_light_yy_surf+lengthdir_y(i,light_ang);
	var radius_pixel = 360*light_scale-(i-max_light_dis)*light_scale;
	draw_set_alpha(light_alpha);
	draw_circle(tmp_light_xx_head,tmp_light_yy_head,radius_pixel,false);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();

	draw_surface_ext(global.light_surf,xx,yy,1,1,0,c_white,1);
}
else
{
	global.fixed_dir = 0;
}










//개발자 모드 디버그 용
if (global.dev_mode == 1)
{
	draw_text_k_scale(xx+8,yy+32,"전체화면 [ESC]\n맵 생성 [F1]\n맵 보기 [`]\n맵 확대/축소 [상/하 방향키]\n벽 히트박스 표시 [F2]\n채팅창 [U/Enter]\n닉네임 변경 [Q]\n스킨 변경 [Y]\n가방 변경 [T]\n틱레이트 변경 [좌/우 방향키]",64,-1,1,c_white,0,-1,font_normal,0.5,0.5,0);
	draw_text_k_scale(xx+xx_w-8,yy+yy_h-256,"인벤토리 열기/닫기 [Tab]\n아이템 회전 [R]\n아이템 반절 나누기 [Shift]\n랜덤 상자 생성 [P]\n플래시 라이트 [1]",64,-1,1,c_white,0,1,font_normal,0.5,0.5,0);
	
	var tmp_guide_txt1 = "초당 평균 프레임 : "+string(global.average_fps_for_draw)+"\n온라인 서버 생성 [F12]\n온라인 서버 접속 [F11]\n디버그 창 열기/닫기 [F10]\n접속 인원 보기 [Capslock]";
	var tmp_guide_txt2 = "초당 평균 프레임 : "+string(global.average_fps_for_draw)+"\n초대 코드 : "+string(global.invite_code)+"\n"+string(keyboard_check(ord("I")) ? "내 아이피 : "+string(global.my_ip) : "아이피 보기[I]")+"\nglobal.is_server : "+string(global.is_server)+"\nTickRate : "+string(global.tickrate)+"\n최대 허용 핑 : "+string(global.maximum_ping_acception);
	draw_text_k_scale(xx+xx_w-8,yy+32,string((code_m.server == -4) ? tmp_guide_txt1 : tmp_guide_txt2)+"\n\n닉네임 : "+string(global.nickname)+"\n\n내 플레이어 id : "+string(global.my_player_id)+"\n플레이어 위치 :\nx "+string(global.n_player_room_xx)+"\ny "+string(global.n_player_room_yy)+"\nweight : "+string(global.my_weight)+"\nhspeed : "+string(global.movement_hspeed)+" vspeed : "+string(global.movement_vspeed),64,-1,1,c_white,0,1,font_normal,0.5,0.5,0);
	
	//맵 드로우
	global.show_map_data = keyboard_check(222) || keyboard_check(192) || keyboard_check(ord("`"));
	
	//랜덤 닉네임
	if (keyboard_check_pressed(ord("Q")))
	{
		global.nickname = randomized_nickname();
		show_message_log("- 변경된 닉네임 : "+string(global.nickname));
		with(obj_player)
		{
			if (global.my_player_id == obj_id_player_only)
			{
				nickname = global.nickname;
				send_InstanceVariableData(id,"nickname");
			}
		}
	}
	
	
	//플래시 라이트
	if (keyboard_check_pressed(ord("1")))
	{
		global.enable_light_surf = !global.enable_light_surf;
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
	
	
	
	//모든 상자에 아이템 생성
	if (keyboard_check_pressed(ord("B")))
	{
		with(obj_loots)
		{
			if (object_index == obj_loots)
			{
				set_inv_variable(id,0,0,spr_comp,7,"Wire",-4,-4,2,1,0,6);
			}
		}
	}
	
	
	//디버그 창
	if (keyboard_check_pressed(vk_f10))
	{
		show_debug_log(!is_debug_overlay_open());
	}
	
	
	//인벤토리
	if (keyboard_check_pressed(vk_tab))
	{
		if (!instance_exists(global.showing_inv))
		{
			global.showing_inv = show_inv_ui(400,320,"Inventory",global.my_player_ins_id[global.my_player_id],-4);
		}
		else
		{
			instance_destroy(global.showing_inv);
		}
		show_message_log("- 인벤토리 열기/닫기 ["+string(global.showing_inv)+"]");
	}
	
	
	//전체화면
	if (keyboard_check_pressed(vk_escape))
	{
		var tmp_val = !window_get_fullscreen();
		var w = 1280, h = 720;
		if (tmp_val)
		{
			w = 1920;
			h = 1080;
		}
		
		
		window_set_size(w,h);
		window_set_fullscreen(tmp_val);
	}
	
	
	if (keyboard_check(vk_control))
	{
		global.n_camera_zoom += (mouse_wheel_down()-mouse_wheel_up())*0.05;
		
		if (keyboard_check_pressed(vk_alt))
		{
			var tmp_val = window_get_width();
			var w = 1280, h = 720;
			if (tmp_val == w)
			{
				w = 1920;
				h = 1080;
			}
			
			window_set_fullscreen(tmp_val);
		}
	}
	
	
	//카메라 줌
	if (keyboard_check_pressed(vk_down))
	{
		global.n_camera_zoom += 0.1;
		show_message_log("- 현재 카메라 줌 : "+string(global.n_camera_zoom));
	}
	else if (keyboard_check_pressed(vk_up))
	{
		global.n_camera_zoom -= 0.1;
		show_message_log("- 현재 카메라 줌 : "+string(global.n_camera_zoom));
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
	if (keyboard_check_pressed(ord("P")))
	{
		var tmp_ins = instance_nearest(mouse_x,mouse_y,obj_loots)
		if (instance_exists(tmp_ins) && point_distance(tmp_ins.x,tmp_ins.y,mouse_x,mouse_y) < 128)
		{
			instance_destroy_multiplayer(tmp_ins);
			show_message_log("- 오브젝트 삭제 [obj_id : "+string(tmp_ins)+"]");
		}
		else
		{
			var tmp_ins = create_loots(mouse_x,mouse_y,2*irandom_range(0,floor((sprite_get_number(spr_loots)-1)/2)),9,9,"Random chest - "+string(global.object_id_ind),global.object_id_ind,0);
			show_message_log("- 랜덤 상자 생성 [obj_id : "+string(tmp_ins.obj_id)+"]");
		}
	}

	
	
	//틱레이트 조정
	if (global.is_server && (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_left)))
	{
		if (keyboard_check_pressed(vk_right))
		{
			global.tickrate += 1;
		}
		else if (keyboard_check_pressed(vk_left))
		{
			global.tickrate -= 1;
		}
		
		if (global.tickrate < 1)
		{
			global.tickrate = 1;
		}
		send_GlobalVariableData("tickrate");
		show_message_log("- 현재 틱 레이트 : "+string(global.tickrate));
	}
	
	
	//카메라 줌
	if (keyboard_check_pressed(vk_f2))
	{
		global.show_wall_hitbox *= -1;
		show_message_log("- 벽 히트박스 표시 : "+string(global.show_wall_hitbox));
	}
	
	
	//맵 생성
	if (global.is_server && keyboard_check_pressed(vk_f1))
	{
		clean_message_log();
		//맵 생성 실패시 자동 재시도
		while(true)
		{
			var tmp_width = floor(9*(0.5+instance_number(obj_player)*0.5));
			var tmp_height = floor(9*(0.5+instance_number(obj_player)*0.5));
			var tmp_start_xx = irandom_range(0,tmp_width-1);
			var tmp_start_yy = irandom_range(0,tmp_height-1);
			var tmp_max_root = irandom_range(16,max(tmp_width,tmp_height)*choose(4,5,6))*instance_number(obj_player);
			var tmp_room_max_width = 24;
			var tmp_room_max_height = 24;
			var tmp_additional_room_cre_percentage = irandom_range(0,100);
			var tmp_total_room_num = irandom_range(25,floor(tmp_room_max_width*tmp_room_max_height/4))*instance_number(obj_player);
			var tmp_min_room_width = 7;
			var tmp_min_room_height = 7;
		
		

			//맵 생성
			create_map(tmp_start_xx,tmp_start_yy,tmp_width,tmp_height,tmp_max_root,tmp_room_max_width,tmp_room_max_height,tmp_additional_room_cre_percentage,tmp_total_room_num,tmp_min_room_width,tmp_min_room_height);
		

		
		
		
			//맵 생성 - 디버그용 메세지
			if (global.map_creation_falied == 0)
			{
				global.is_map_exists = random_get_seed();
			
				show_message_log("- 맵 생성 정보");
				show_message_log("맵 시드 : "+string(global.is_map_exists));
				show_message_log("맵 크기 (width x height) : "+string(tmp_width)+" x "+string(tmp_height));
				show_message_log("루트 최대 길이 : "+string(tmp_max_root));
				show_message_log("룸 최대 크기 (width x height) : "+string(tmp_room_max_width)+" x "+string(tmp_room_max_height));
				show_message_log("룸 최소 크기 (width x height) : "+string(tmp_min_room_width)+" x "+string(tmp_min_room_height));
				show_message_log("추가 방 연결 확률 : "+string(tmp_additional_room_cre_percentage)+"%");
				show_message_log("방 갯수 : "+string(global.n_room_num)+"/"+string(tmp_total_room_num));
			
			
				//현재 위치 (= 스타트 지점)에 대한 룸 정보 불러오기
				load_room(global.n_player_room_xx[global.my_player_id],global.n_player_room_yy[global.my_player_id]);
			
				show_message_log("- 맵 로드/전송 완료");
				obj_player.x = room_width*0.5;
				obj_player.y = room_height*0.5;
				send_NewMapData();
			
				//카메라 줌 설정
				global.n_camera_zoom = 0.5;
				break; //while문 빠져나오기
			}
			else
			{
				show_message_log("- 맵 생성 실패! (재시도 중...)");
				failed_map_creation();
				global.n_camera_zoom = 0.7;
			}
		
		
			//맵 생성 - 디버그용 메세지
			for(var i = 0; i < global.map_height; i++)
			{
				var tmp_str = "";
				for(var ii = 0; ii < global.map_width; ii++)
				{
					tmp_str = string(tmp_str)+string(global.map_arr[i][ii])+" ";
				}
				show_debug_message(tmp_str);
			}
		}
	}
}




//맵 드로우 코드
if (global.show_map_data == 1)
{
	var room_ui_scale = 24/(global.map_height);
	var tmp_space = (64*room_ui_scale+16)*tmp_c_x;
	var tmp_xx = (xx_center-global.map_width/2*tmp_space);
	var tmp_yy = (yy_center-global.map_height/2*tmp_space);
	//맵이 존재하는 경우
	if (global.is_map_exists != -4)
	{
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
					draw_set_color(#5cc4cd);
					draw_line_width(draw_xx,draw_yy,tmp_xx+global.room_connected_to_xx[i][ii]*tmp_space,tmp_yy+global.room_connected_to_yy[i][ii]*tmp_space,8*tmp_c_x*room_ui_scale);
				}
				
				//방 연결된거 표시 (sec)
				if (global.room_connected_to_xx_sec[i][ii] != -4)
				{
					draw_set_color(#d892a6);
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
					draw_sprite_ext(Sprite12,(ii != global.map_start_pos_xx || i != global.map_start_pos_yy) ? 1 : 2,draw_xx,draw_yy,tmp_c_x*room_ui_scale,tmp_c_x*room_ui_scale,0,merge_color(c_white,c_orange,global.map_arr[i][ii]/global.max_root_length),global.show_map_data);
					
					var angle = -4;
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
						draw_sprite_ext(spr_arrow_ui,0,draw_xx,draw_yy,tmp_c_x*room_ui_scale,tmp_c_x*room_ui_scale,angle,(is_someone_here == 1) ? c_red : c_gray,global.show_map_data);
					}
					

					
					if (global.room_connected_to_xx_sec[i][ii] != -4)
					{
						var tmp_str_2 = "("+string(global.room_connected_to_xx_sec[i][ii])+", "+string(global.room_connected_to_yy_sec[i][ii])+")";
						draw_text_kl_scale(draw_xx,draw_yy,tmp_str_2,64,-1,global.show_map_data,c_white,0,0,font_light,tmp_c_x*room_ui_scale*0.3,tmp_c_x*room_ui_scale*0.3,0);
					}
					
					//show_debug_message("drawing_map ("+string(tmp_xx)+", "+string(tmp_yy)+")   /   "+string(xx))
				}
				else
				{
					draw_sprite_ext(Sprite12,1,draw_xx,draw_yy,tmp_c_x*room_ui_scale,tmp_c_x*room_ui_scale,0,merge_color(c_black,c_white,0.1),global.show_map_data);
				}
			}
		}
	}
}