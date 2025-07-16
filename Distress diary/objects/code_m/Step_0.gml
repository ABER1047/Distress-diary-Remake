/// @description Insert description here
// You can write your code in this editor

//초대 코드 생성
if (global.my_ip != "")
{
	var tmp_rd_invite_code_seed = floor(current_minute/15);
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
		server = network_create_server(network_socket_tcp, server_port, global.maximum_player_num-1);

		
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


if (keyboard_check_pressed(vk_f10))
{
	global.ignore_non_focused = !global.ignore_non_focused;
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
			if (global.is_server || chat_entering == "/disconnect")
			{
				var commands = [ "/kill", "/dev", "/cm", "/debug", "/hitbox", "/tickrate", "/time", "/help", "/zoom", "/shadow", "/light", "/dmg", "/hunger", "/hydro", "/ts", "/mob", "/ef", "/arr", "/gq", "/vom", "/cp", "/invite", "/disconnect", "/connect", "/ds", "/explo", "/give", "/camera", "/hp", "/buff", "/np", "/roomall", "/pk", "/healall", "/igf", "/fb", "/blt" ];
				var command_desc = [ "자살하기", "개발자 모드 활성화/비활성화", "새로운 맵 생성", "디버그 모드 활성화/비활성화", "히트박스 활성화/비활성화", "지정된 수치만큼 틱레이트 설정", "지정된 수치만큼 시간 설정 (단위 : minute)", "명령어 가이드 표기", "카메라 줌 정도를 지정된 수차만큼 설정", "그림자 활성화/비활성화", "광원 활성화/비활성화", "내 플레이어에 지정된 수차만큼 데미지 입히기", "배고픔 게이지 소모", "수분 게이지 소모", "타일셋 변경", "몬스터 생성", "이펙트 생성", "화살 생성", "그래픽 퀄리티 설정", "몹 시점 표시", "퍼즐방 생성", "초대코드 복사", "서버 연결 해제", "서버 접속", "현재 룸의 모든 문 열기/닫기", "폭발 이펙트 생성", "아이템 생성", "카메라 위치 표시", "나 자신의 hp값 설정", "나 자신에게 버프/디버프 적용", "현재 내 위치 표시", "모든 룸 전부 지도에 표시", "팀킬 허용", "모든 플레이어 100% 회복", "화면 가림막 제거", "파이어볼 생성", "쇼크볼트 생성" ];
				for(var i = 0; i < array_length(commands); i++)
				{
					if (string_pos(commands[i],chat_entering))
					{
						//파라미터 값
						var tmp_parameter = string_replace_all(chat_entering,commands[i],"");
						tmp_parameter = string_trim(tmp_parameter);
						
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
							give_damage(global.my_player_ins_id[global.my_player_id],9999,true,0,other.x,other.y,60);
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
								randomize();
								global.is_map_exists = random_get_seed();

								//맵 생성
								create_map(global.is_map_exists);
							}
						}
						else if (i == 3) //디버그 창 on-off
						{
							show_debug_log(!is_debug_overlay_open());
						}
						else if (i == 4) //hitbox on-off
						{
							global.show_wall_hitbox = !global.show_wall_hitbox;
							for(var i = 0; i < 4; i++)
							{
								if (instance_exists(global.outside_of_map_wall[i]))
								{
									global.outside_of_map_wall[i].visible = global.show_wall_hitbox;
									global.outside_of_map_wall[i].image_alpha = 0.1;
								}
							}
							show_message_log("- 벽 히트박스 표시 : "+string(global.show_wall_hitbox));
						}
						else if (i == 5) //틱레이트 설정
						{
							var tmp_tickrate = global.tickrate;
							global.tickrate = tmp_parameter;
							chat_up_multiplayer("- 틱레이트 변경 : "+string(tmp_parameter)+" [기존 : "+string(tmp_tickrate)+"]",false);
							send_GlobalVariableData("tickrate");
						}
						else if (i == 6) //시간 설정
						{
							var tmp_time = global.time;
							global.time = 60*tmp_parameter;
							chat_up_multiplayer("- 시간 변경 : "+string(global.time)+" [기존 : "+string(tmp_time)+"]",false);
							send_GlobalVariableData("time");
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
							give_damage(global.my_player_ins_id[global.my_player_id],tmp_parameter,true,0,other.x,other.y,60);
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
							chat_up_multiplayer("- 타일셋 변경 : "+string(tmp_parameter)+" [기존 : "+string(global.n_room_tileset)+"]",false);
							global.n_room_tileset = tmp_parameter;
							send_GlobalVariableData("n_room_tileset");
						}
						else if (i == 15) //몬스터 생성
						{
							var tmp_mob_obj_ind = [ obj_fireball, obj_wisp, obj_skull_head, obj_skeleton, obj_poison_slime, obj_orange_slime, obj_crimson_slime, obj_infected_skeleton ];
							var rd_select = (tmp_parameter == 0) ? irandom_range(0,array_length(tmp_mob_obj_ind)-1) : tmp_parameter-1;
							var tmp_ins = instance_create_multiplayer(tmp_mob_obj_ind[(array_length(tmp_mob_obj_ind) <= rd_select) ? array_length(tmp_mob_obj_ind)-1 : rd_select],mouse_x,mouse_y,global.object_id_ind,0,false,-4,4);
							
							give_damage(global.my_player_ins_id[global.my_player_id],0,true,0,other.x,other.y,60);
						}
						else if (i == 16) //이펙트 생성
						{
							var tmp_mob_obj_ind = [ obj_attack_effect ];
							var rd_select = (tmp_parameter == 0) ? irandom_range(0,array_length(tmp_mob_obj_ind)-1) : tmp_parameter-1;
							var tmp_ins = instance_create_multiplayer(tmp_mob_obj_ind[rd_select],global.my_player_ins_id[global.my_player_id].x,global.my_player_ins_id[global.my_player_id].y-512,global.object_id_ind,0,false,-4,-4);
							tmp_ins.max_line_width = 128;
							tmp_ins.dir = choose(-1,1);
						}
						else if (i == 17) //화살 생성
						{
							var tmp_xx = global.my_player_ins_id[global.my_player_id].x;
							var tmp_yy = global.my_player_ins_id[global.my_player_id].y;
							var tmp_ = instance_nearest(tmp_xx,tmp_yy,obj_monster_parents);
							var tmp_dir = (instance_exists(tmp_)) ? point_direction(tmp_xx,tmp_yy,tmp_.x,tmp_.y) : point_direction(tmp_xx,tmp_yy,mouse_x,mouse_y);
							var tmp_ins = create_projectile(tmp_xx,tmp_yy,0,48,1,22,64,0,tmp_dir,0);
						}
						else if (i == 18) //그래픽 퀄리티 설정
						{
							//그래픽 퀄리티 값 적용
							show_message_log("- 그래픽 퀄리티 변경 : "+string(tmp_parameter)+" [기존 : "+string(global.graphics_quality)+"]");
							global.graphics_quality = tmp_parameter;
							
							if (global.graphics_quality == 0)
							{
								instance_destroy(tmp_bubble_outline_effect);
							}
							
							//서피스 전체 리셋
							with(code)
							{
								if (id != other.id)
								{
									event_user(0);
								}
							}
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
							global.map_arr[n_yy][n_xx] = (tmp_parameter > 0) ? 3 : 1;
						}
						else if (i == 25) //폭발 이펙트 생성
						{
							var tmp_xx = global.my_player_ins_id[global.my_player_id].x;
							var tmp_yy = global.my_player_ins_id[global.my_player_id].y;
							
							create_explosion_effect(tmp_xx,tmp_yy,28,4,-4,-4,true);
						}
						else if (i == 26) //아이템 생성
						{
							var tmp_spr_ind = [ spr_backpack, spr_comp, spr_foods, spr_healings, spr_stackables, spr_drink, spr_weapon, spr_equipments, spr_pickaxe, spr_others ];
							var tmp_xx = global.my_player_ins_id[global.my_player_id].x;
							var tmp_yy = global.my_player_ins_id[global.my_player_id].y;
							tmp_parameter = (tmp_parameter < array_length(tmp_spr_ind)) ? tmp_parameter : array_length(tmp_spr_ind)-1;
							var tmp_img_ind = irandom_range(0,sprite_get_number(tmp_spr_ind[tmp_parameter])-1);
							
							drop_item(tmp_parameter,tmp_img_ind,1,1,1,1,true,tmp_xx,tmp_yy);
						}
						else if (i == 27) //카메라 위치 표시
						{
							obj_camera.image_index ++;
						}
						else if (i == 28) //hp값 설정
						{
							global.my_player_ins_id[global.my_player_id].hp = tmp_parameter;
							send_InstanceVariableData(global.my_player_ins_id[global.my_player_id],"hp");
						}
						else if (i == 29) //버프 적용
						{
							var tmp_arr_length = array_length(global.buff_left_time)-1;
							tmp_parameter = (tmp_arr_length < tmp_parameter) ? tmp_arr_length : tmp_parameter;
							
							if (tmp_parameter < 0)
							{
								for(var k = 0; k <= tmp_arr_length; k++)
								{
									apply_buff(global.my_player_ins_id[global.my_player_id],k,3600);
								}
							}
							else
							{
								if (global.buff_left_time[tmp_parameter] <= 0)
								{
									apply_buff(global.my_player_ins_id[global.my_player_id],tmp_parameter,3600);
								}
								else
								{
									apply_buff(global.my_player_ins_id[global.my_player_id],tmp_parameter,0);
								}
							}
						}
						else if (i == 30) //내 위치 표시
						{
							show_message_log("내 위치 : "+string(global.n_player_room_xx[global.my_player_id])+", "+string(global.n_player_room_yy[global.my_player_id]));
						}
						else if (i == 31) //모든 룸 전부 지도에 표시
						{
							for(var k = 0; k < global.map_height; k++;)
							{
								for(var kk = 0; kk < global.map_width; kk++;)
								{
									if (global.map_arr[k][kk] == 1)
									{
										global.map_arr[k][kk] = 2;
									}
								}
							}
						}
						else if (i == 32) //팀킬 허용
						{
							var tmp_boolean = (tmp_parameter > 0) ? true : false;
							chat_up_multiplayer("- pvp 허용 여부 : "+string(tmp_boolean)+" [기존 : "+string(global.pvpable)+"]",false);
							global.pvpable = tmp_boolean;
							send_GlobalVariableData("pvpable");
						}
						else if (i == 33) //모든 플레이어 힐
						{
							for(var k = 0; k < array_length(global.my_player_ins_id); k++)
							{
								var tmp_ins = global.my_player_ins_id[k];
								if (instance_exists(tmp_ins))
								{
									tmp_ins.hp = 100;
									send_InstanceVariableData(tmp_ins,"hp",100);
								}
							}
							chat_up_multiplayer("- 모든 플레이어 100% 회복",false);
						}
						else if (i == 34) //화면 가림막
						{
							var tmp_boolean = (tmp_parameter > 0) ? true : false;
							chat_up_multiplayer("- 화면 가림막 여부 : "+string(tmp_boolean)+" [기존 : "+string(global.ignore_non_focused)+"]",false);
							global.ignore_non_focused = tmp_boolean;
						}
						else if (i == 35) //파이어볼 생성
						{
							var tmp_xx = global.my_player_ins_id[global.my_player_id].x;
							var tmp_yy = global.my_player_ins_id[global.my_player_id].y;
							var tmp_ = instance_nearest(tmp_xx,tmp_yy,obj_monster_parents);
							var tmp_dir = (instance_exists(tmp_)) ? point_direction(tmp_xx,tmp_yy,tmp_.x,tmp_.y) : point_direction(tmp_xx,tmp_yy,mouse_x,mouse_y);
							var tmp_ins = create_projectile(tmp_xx,tmp_yy,0,17,2,43,64,0,tmp_dir,1,spr_projectile_fireball,25,2.25);
							chat_up_multiplayer("- 파이어볼 생성됨",false);
						}
						else if (i == 36) //쇼크볼트 생성
						{
							var tmp_xx = global.my_player_ins_id[global.my_player_id].x;
							var tmp_yy = global.my_player_ins_id[global.my_player_id].y;
							var tmp_ = instance_nearest(tmp_xx,tmp_yy,obj_monster_parents);
							var tmp_dir = (instance_exists(tmp_)) ? point_direction(tmp_xx,tmp_yy,tmp_.x,tmp_.y) : point_direction(tmp_xx,tmp_yy,mouse_x,mouse_y);
							var tmp_var_name = "length,image_yscale,image_angle,max_reflection_num,rd_snap_rad,image_blend,count_reflection";
							var tmp_val = "320,8,"+string(tmp_dir)+","+string(tmp_parameter)+","+string(irandom_range(0,5)*10)+","+string(#3898FF)+",0";
							var tmp_ins = instance_create_multiplayer_ext(obj_lightning_shock,tmp_xx,tmp_yy,global.object_id_ind,0,false,-4,-4,tmp_var_name,tmp_val);
							chat_up_multiplayer("- 쇼크볼트 생성됨",false);
						}
						
						
						
						is_command = true;
						global.chat_activated = false;
						global.prohibit_movement_input = b_prohibit_movement_input;
					}
				}
			}

			
			
			if (!is_command) 
			{
				if (string_pos("/",chat_entering))
				{
					show_message_log("- '"+string(chat_entering)+"'는 잘못된 명령어 입니다!");
				}
				else
				{
					//채팅 전송
					chat_up_multiplayer(chat_entering,true);
				
				
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
			global.prohibit_movement_input = b_prohibit_movement_input;
		}
	}
}
else
{
	if (keyboard_check_pressed(ord("U")) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("/")))
	{
		global.chat_activated = !global.chat_activated;
		keyboard_string = "";
		
		b_prohibit_movement_input = global.prohibit_movement_input;
		global.prohibit_movement_input = true;
	}
	chat_alpha += (-0.01 - chat_alpha)*0.3;
}