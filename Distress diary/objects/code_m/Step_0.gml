/// @description Insert description here
// You can write your code in this editor

//초대 코드 생성
if (global.my_ip != "")
{
	var tmp_rd_invite_code_seed = floor(current_minute/15)
	if (global.invite_code_seed != tmp_rd_invite_code_seed)
	{
		global.invite_code = create_invite_code(global.my_ip);
		global.invite_code_seed = tmp_rd_invite_code_seed;
	}
}


if (server == -4)
{
	//서버 생성
	if (keyboard_check_pressed(vk_f12)) 
	{
		server = network_create_server(network_socket_tcp, server_port, 3);

		
		if (server < 0) 
		{
			event_user(3);
			show_message_log("서버 생성 오류 발생!");
		}
		else 
		{
			event_user(4);
			show_message_log("서버 생성 완료!");
			
			//VC system
			//voice_server_started = server;
			//scr_voiceserver_start();
		}
	}
	else if (keyboard_check_pressed(vk_f11)) //서버 접속
	{
		event_user(1);
	}
}

////////////////////////////////////////////////////////////////////////////////////////////

if (global.chat_activated)
{
	chat_alpha += (1 - chat_alpha)*0.3;
	
	if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V")))
	{
		chat_entering = string(chat_entering)+string(clipboard_get_text());
		keyboard_string = chat_entering;
	}
	
	if (string_width(string(global.nickname)+string(keyboard_string)) > 1280)
	{
		keyboard_string = chat_entering;
	}
	else
	{
		chat_entering = keyboard_string;
	}
	
	//마우스 휠로 이전 채팅 보기
	if (mouse_wheel_up() || mouse_wheel_down())
	{
		global.chating_scroll += (mouse_wheel_up()-mouse_wheel_down());
		global.chating_scroll = fix_num_inside(global.chating_scroll,0,global.max_chat_stack-10);
		global.chat_scroll_alpha = 10;
	}
	else
	{
		global.chat_scroll_alpha += (0 - global.chat_scroll_alpha)*0.1;
	}
	
	
	if (keyboard_check_pressed(vk_enter))
	{
		if (chat_entering != "")
		{
			//명령어 감지
			var is_command = false;
			if (global.dev_mode == 1)
			{
				var commands = [ "/kill", "/dev", "/cm", "/debug", "/hitbox", "/tickrate", "/time", "/help", "/zoom", "/shadow", "/light", "/dmg", "/hunger", "/hydro", "/ts", "/mob", "/ef", "/arr", "/gq", "/vom", "/cp", "/invite", "/disconnect", "/connect", "/ds" ];
				var command_desc = [ "자살하기", "개발자 모드 활성화/비활성화", "새로운 맵 생성", "디버그 모드 활성화/비활성화", "히트박스 활성화/비활성화", "지정된 수치만큼 틱레이트 설정", "지정된 수치만큼 시간 설정 (단위 : minute)", "명령어 가이드 표기", "카메라 줌 정도를 지정된 수차만큼 설정", "그림자 활성화/비활성화", "광원 활성화/비활성화", "내 플레이어에 지정된 수차만큼 데미지 입히기", "배고픔 게이지 소모", "수분 게이지 소모", "타일셋 변경", "몬스터 생성", "이펙트 생성", "화살 생성", "그래픽 퀄리티 설정", "몹 시점 표시", "퍼즐방 생성", "초대코드 복사", "서버 연결 해제", "서버 접속", "현재 룸의 모든 문 열기/닫기" ];
				for(var i = 0; i < array_length(commands); i++)
				{
					if (string_pos(commands[i],chat_entering))
					{
						//파라미터 값
						var tmp_parameter = string_replace_all(chat_entering,commands[i],"");
						tmp_parameter = string_replace_all(tmp_parameter," ","");
						
						var tmp_parameter_str = tmp_parameter;
						try
						{
							tmp_parameter = (tmp_parameter == "") ? 0 : real(tmp_parameter);
							is_command = true;
						}
						catch(e)
						{
							is_command = true;
							show_message_log("- '"+string(chat_entering)+"'는 잘못된 명령어 입니다!");
							break;
						}
						
						
						
						if (i == 0) //suicide
						{
							give_damage(global.my_player_ins_id[global.my_player_id],9999,true);
						}
						else if (i == 1) //개발자 모드 on-off
						{
							global.dev_mode *= -1;
							show_message_log("- 디버그 모드 : "+string(global.dev_mode));
						}
						else if (i == 2) //create_map
						{
							if (global.is_server)
							{
								clean_message_log();
								//맵 생성 실패시 자동 재시도
								while(true)
								{
									var tmp_width = floor(9*(0.5+instance_number(obj_player)*0.5));
									var tmp_height = floor(9*(0.5+instance_number(obj_player)*0.5));
									var tmp_start_xx = floor(tmp_width/2);
									var tmp_start_yy = floor(tmp_height/2);
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
			
			
										//맵 내의 구조물 생성
										create_map_monuments();
			
			
										//현재 위치 (= 스타트 지점)에 대한 룸 정보 불러오기
										load_room(global.n_player_room_xx[global.my_player_id],global.n_player_room_yy[global.my_player_id]);
			
										show_message_log("- 맵 로드 완료");
										obj_player.x = room_width*0.5;
										obj_player.y = room_height*0.5;
										
										alarm[4] = 30;
			
										//카메라 줌 설정
										global.n_camera_zoom = 0.53;
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
						else if (i == 3) //디버그 창 on-off
						{
							show_debug_log(!is_debug_overlay_open());
						}
						else if (i == 4) //hitbox on-off
						{
							global.show_wall_hitbox = !global.show_wall_hitbox;
							show_message_log("- 벽 히트박스 표시 : "+string(global.show_wall_hitbox));
						}
						else if (i == 5) //틱레이트 설정
						{
							var tmp_tickrate = global.tickrate;
							global.tickrate = tmp_parameter;
							show_message_log("- 틱레이트 변경 : "+string(tmp_parameter)+" [기존 : "+string(tmp_tickrate)+"]");
						}
						else if (i == 6) //시간 설정
						{
							var tmp_time = global.time;
							global.time = 60*tmp_parameter;
							show_message_log("- 시간 변경 : "+string(global.time)+" [기존 : "+string(tmp_time)+"]");
						}
						else if (i == 7) //명령어 가이드 표시
						{
							for(var i = 0; i < array_length(commands); i++)
							{
								chat_up(string(commands[i])+" - "+string(command_desc[i]));
							}
						}
						else if (i == 8) //카메라 줌 정도 설정
						{
							var tmp_camera_zoom = global.n_camera_zoom;
							global.n_camera_zoom = tmp_parameter;
							show_message_log("- 카메라 줌 정도 : "+string(tmp_parameter)+" [기존 : "+string(tmp_camera_zoom)+"]");
						}
						else if (i == 9) //그림자 on-off
						{
							global.enable_shadow_surf = !global.enable_shadow_surf;
							show_message_log("- 그림자 : "+string(global.enable_shadow_surf));
						}
						else if (i == 10) //광원 on-off
						{
							global.enable_light_surf = !global.enable_light_surf;
							show_message_log("- 광원 : "+string(global.enable_light_surf));
						}
						else if (i == 11) //데미지 입히기
						{
							give_damage(global.my_player_ins_id[global.my_player_id],tmp_parameter,true);
						}
						else if (i == 12) //배고픔 값 줄이기
						{
							global.hunger -= tmp_parameter;
						}
						else if (i == 13) //목마름 값 줄이기
						{
							global.hydration -= tmp_parameter;
						}
						else if (i == 14) //타일셋 변경
						{
							global.n_room_tileset = tmp_parameter;
						}
						else if (i == 15) //몬스터 생성
						{
							var tmp_mob_obj_ind = [ obj_fireball, obj_wisp, obj_skull_head, obj_skeleton ];
							var rd_select = (tmp_parameter == 0) ? irandom_range(0,array_length(tmp_mob_obj_ind)-1) : tmp_parameter-1;
							var tmp_ins = instance_create_multiplayer(tmp_mob_obj_ind[rd_select],global.my_player_ins_id[global.my_player_id].x,global.my_player_ins_id[global.my_player_id].y,global.object_id_ind,0,false,-4,4);
							
							give_damage(global.my_player_ins_id[global.my_player_id],0,true);
						}
						else if (i == 16) //이펙트 생성
						{
							var tmp_mob_obj_ind = [ obj_explosion ];
							var rd_select = (tmp_parameter == 0) ? irandom_range(0,array_length(tmp_mob_obj_ind)-1) : tmp_parameter-1;
							var tmp_ins = instance_create_multiplayer(tmp_mob_obj_ind[rd_select],global.my_player_ins_id[global.my_player_id].x,global.my_player_ins_id[global.my_player_id].y,global.object_id_ind,0,false,-4,4);
							tmp_ins.xpos = global.n_player_room_xx[global.my_player_id];
							tmp_ins.ypos = global.n_player_room_yy[global.my_player_id];
							tmp_ins.explo_dmg = 10;
						}
						else if (i == 17) //화살 생성
						{
							var tmp_xx = global.my_player_ins_id[global.my_player_id].x;
							var tmp_yy = global.my_player_ins_id[global.my_player_id].y;
							
							var tmp_ = instance_nearest(tmp_xx,tmp_yy,obj_monster_parents);
							
							var tmp_ins = instance_create_multiplayer(obj_arrow,tmp_xx,tmp_yy,global.object_id_ind,0,false,-4,-4);
							tmp_ins.direction = (instance_exists(tmp_)) ? point_direction(tmp_xx,tmp_yy,tmp_.x,tmp_.y) : point_direction(tmp_xx,tmp_yy,mouse_x,mouse_y);
							tmp_ins._speed = 48;
							tmp_ins.parents = global.my_player_ins_id[global.my_player_id];
							tmp_ins.attack_dmg = 22;
						}
						else if (i == 18) //그래픽 퀄리티 설정
						{
							global.graphics_quality = tmp_parameter;
						}
						else if (i == 19) //몹 시점 표시
						{
							global.display_view_of_mob = !global.display_view_of_mob;
						}
						else if (i == 20) //퍼즐방 생성
						{
							instance_destroy(obj_generation_puzzle);
							var tmp_ins = instance_create_depth(x,y,0,obj_generation_puzzle,{xpos : global.n_player_room_xx[global.my_player_id], ypos : global.n_player_room_yy[global.my_player_id]});
						}
						else if (i == 21) //초대 코드 복사
						{
							show_message_log("초대 코드 생성 및 복사 완료!");
							global.invite_code = create_invite_code(global.my_ip);
						}
						else if (i == 22) //연결 해제
						{
							event_user(0);
						}
						else if (i == 23) //서버 접속
						{
							clipboard_set_text(tmp_parameter_str);
							event_user(1);
						}
						else if (i == 24) //방 문 잠그기
						{
							var n_xx = global.n_player_room_xx[global.my_player_id];
							var n_yy = global.n_player_room_yy[global.my_player_id];
							global.map_arr[n_yy][n_xx] = (tmp_parameter_str > 0) ? 3 : 1;
						}
						
						
						is_command = true;
						global.chat_activated = false;
					}
				}
			}

			
			
			if (!is_command && global.is_server) 
			{
				if (string_pos("/",chat_entering))
				{
					show_message_log("- '"+string(chat_entering)+"'는 잘못된 명령어 입니다!");
				}
				else
				{
					//채팅 전송
					var tmp_chat = string(global.nickname)+" : "+string(chat_entering);
					buffer_seek(chat_buffer, buffer_seek_start, 0);
					buffer_write(chat_buffer, buffer_u8, DATA.CHAT);
					buffer_write(chat_buffer, buffer_string, tmp_chat);
					send_all(chat_buffer);
				
				
					//내 화면에도 채팅 표기
					show_message_log(tmp_chat);
				
				
					//스크롤 위치 초기화
					global.chating_scroll = 0;
				
					if (global.chat[10] != "")
					{
						global.chat_scroll_alpha = 10;
					}
				}
			}
			
			chat_entering = "";
			keyboard_string = "";
		}
		else
		{
			clean_message_log();
			global.chat_activated = !global.chat_activated;
		}
	}
}
else
{
	if (keyboard_check_pressed(ord("U")) || keyboard_check_pressed(vk_enter))
	{
		global.chat_activated = !global.chat_activated;
		keyboard_string = "";
	}
	chat_alpha += (-0.01 - chat_alpha)*0.3;
}