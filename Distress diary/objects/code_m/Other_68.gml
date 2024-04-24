var type = async_load[? "type"];


//누군가 연결/단절 했을 때 발생하는 이벤트 (서버쪽에서만 발생하는 이벤트)
if (type == network_type_connect) 
{
	var socket = async_load[? "socket"];
	var cli_max = instance_number(obj_player);
	network_set_timeout(socket, 3000, 3000);
	

	//object_id_player_only 할당용 변수
	global.object_id_player_only ++;
	
	
	//핑 저장용 변수
	array_resize(global.users_ping,global.object_id_player_only);
	array_resize(global.users_ping_display,global.object_id_player_only);

	
	//새로 들어온 플레이어한테 기본 정보 전송
	buffer_seek(info_buffer, buffer_seek_start, 0);
	buffer_write(info_buffer, buffer_u8, DATA.INIT_DATA);
	buffer_write(info_buffer, buffer_string, cli_max);
	buffer_write(info_buffer, buffer_string, global.object_id_ind);
	buffer_write(info_buffer, buffer_string, global.object_id_player_only);
	buffer_write(info_buffer, buffer_u8, socket);
	with(obj_player)
	{
		buffer_write(other.info_buffer, buffer_string, obj_id); //오브젝트 아이디
		buffer_write(other.info_buffer, buffer_string, obj_id_player_only); //플레이어 전용 오브젝트 아이디
		buffer_write(other.info_buffer, buffer_u8, soc); //소켓
		buffer_write(other.info_buffer, buffer_string, nickname); //닉네임
	}
	
	network_send_packet(socket, info_buffer, buffer_get_size(info_buffer));

	

	//플레이어 인원수 측정용 리스트
	ds_list_add(global.client_num, global.object_id_player_only);
	
	//obj_id 할당용 변수 (얘는 모든 작업이 끝난 후 플러스 해줌)
	global.object_id_ind ++;
	
	
	
	//제대로 접속이 되어있나 체크
	buffer_seek(dis_buffer, buffer_seek_start, 0);
	buffer_write(dis_buffer, buffer_u8, DATA.CHECK_PLAYING_NOW);
	buffer_write(dis_buffer, buffer_string, 0);
	//클라이언트에게 계산된 각 플레이어 핑 보내기
	var tmp_arr_length = array_length(global.users_ping);
	buffer_write(dis_buffer, buffer_string, tmp_arr_length);
	for(var i = 0; i < tmp_arr_length; i++)
	{
		buffer_write(dis_buffer, buffer_string, global.users_ping[i]);
	}
	send_all(dis_buffer);
}
else if (type == network_type_disconnect) // 누군가 나갔을 때 발생하는 이벤트
{
	//게임종료 이벤트에 다 들어있음
}

else if (type == network_type_data) //클라이언트/서버 양쪽에서 발생하는 이벤트
{
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var data = buffer_read(buffer, buffer_u8);
	
	switch(data) 
	{
		case DATA.INIT_DATA: //이제 막 접속한 클라이언트측에서만 발생하는 이벤트 
			if (global.is_server == false)
			{
				//총 접속 인원 (자신 제외)
				var tmp_player_num = real(buffer_read(buffer, buffer_string));
				
				//받아온 서버의 global.object_id_ind 값
				global.object_id_ind = real(buffer_read(buffer, buffer_string));
				
				//받아온 서버의 global.object_id_ind_player_only 값
				global.object_id_player_only = real(buffer_read(buffer, buffer_string));
				
				//받아온 서버의 소켓
				var tmp_soc = buffer_read(buffer, buffer_u8);
				
				
				//내 플레이어 기본 정보 값 세팅
				network_set_timeout(tmp_soc, 3000, 3000);
				with(obj_player)
				{
					if (object_index != code_m)
					{
						soc = tmp_soc;
						obj_id = global.object_id_ind;
						obj_id_player_only = global.object_id_player_only;
					}
				}
				
				//내 플레이어 아이디 값 세팅
				global.my_player_id = global.object_id_player_only;
				
				
				
				//뭔가 문제가 생겨서 제대로 연결이 되지 못한 경우 체크
				alarm[3] = 180;
				

				//나 이외의 모든 플레이어 기본 정보 값 세팅
				for(i = 0; i < tmp_player_num; i++)
				{
					var obj = instance_create_depth(room_width*0.5+irandom_range(-640,640), room_height*0.5+irandom_range(-640,640), 0, obj_player);
					obj.obj_id = real(buffer_read(buffer, buffer_string)); //고유 obj_id값 부여
					obj.obj_id_player_only = real(buffer_read(buffer, buffer_string)); //고유 obj_id값 부여
					obj.soc = buffer_read(buffer, buffer_u8); //소켓
					obj.nickname = buffer_read(buffer, buffer_string); //닉네임
				}
			

				//핑 저장용 변수
				array_resize(global.users_ping,global.object_id_player_only);
				array_resize(global.users_ping_display,global.object_id_player_only);
				
			
			
				//서버 및 다른 클라이언트 한테 접속했다고 데이터 발송
				buffer_seek(info_buffer, buffer_seek_start, 0);
				buffer_write(info_buffer, buffer_u8, DATA.ADD_CLI);
				buffer_write(info_buffer, buffer_string, global.object_id_ind); //내가 배정받은 고유 obj_id를 서버로 전송
				buffer_write(info_buffer, buffer_string, global.object_id_player_only); //내가 배정받은 고유 obj_id_player_only를 서버로 전송
				buffer_write(info_buffer, buffer_string, global.nickname); //내 닉네임을 서버에 전송
				buffer_write(info_buffer, buffer_u8, tmp_soc); //내 소켓 전송
				send_all(info_buffer);
				
				
				//접속 메세지 표기
				show_message_log("채팅방에 들어왔습니다.");
			}
		break;
		
		case DATA.ADD_CLI: //누군가가 중간에 접속했을때 서버, 클라이언트 모두 발생하는 이벤트 (이제 막 접속한 클라이언트 제외)
			var tmp_object_id_ind = real(buffer_read(buffer, buffer_string));
			var tmp_object_id_ind_player_only = real(buffer_read(buffer, buffer_string));
			var tmp_nickname = buffer_read(buffer, buffer_string);
			//들어온 자기 자신도 이벤트가 작동되기 때문에 그거 방지용
			if (global.my_player_id != tmp_object_id_ind_player_only)
			{
				//서버쪽에 새로 접속한 클라이언트 플레이어 생성
				var obj = instance_create_depth(room_width*0.5+irandom_range(-640,640), room_height*0.5+irandom_range(-640,640), 0, obj_player);
				obj.obj_id = tmp_object_id_ind;
				obj.obj_id_player_only = tmp_object_id_ind_player_only;
				obj.soc = buffer_read(buffer, buffer_u8);
				obj.nickname = tmp_nickname;

				show_message_log("'"+string(tmp_nickname)+"'가 왔습니다.");
				
				
				//플레이어 인스턴스 아이디 저장해두기 (최적화 용도로 사용)
				get_all_players_ins_id();

				
				//새로 접속한 사람한테 내 닉네임 전송해주기
				send_InstanceVariableData(global.my_player_ins_id[global.my_player_id],"nickname");
			}
			
			
			//서버한테만 새로운 플레이어 왔다고 해당 변수 1만큼 증가시켜줌
			if (global.is_server)
			{
				global.new_player_joined++;
			}
				
			//새로운 클라이언트가 왔으니, 각 플레이어들은 자신의 obj_id값을 새로운 클라이언트에게 보내줌
			//일단 보류
		break;

		case DATA.REMOVE_CLI:
			var tmp_obj_id_player_only = real(buffer_read(buffer, buffer_string));
			show_message_log("tmp_obj_id_player_only : "+string(tmp_obj_id_player_only));
			
			//만약 대답이 늦어서 튕겼다고 판단되어 내보내진 경우
			if (global.my_player_id == tmp_obj_id_player_only)
			{
				//핑차이가 너무 심하거나, 연결 상태가 좋지 못한 경우라서 그냥 내보내버림
				event_user(0);
			}
			else //진짜로 튕겨서 대답이 안 간 경우 그냥 내보내버리기
			{
				with(obj_player) 
				{
					if (obj_id_player_only == tmp_obj_id_player_only) 
					{
						//나간 플레이어가 해당 플레이어인 경우
						show_message_log("'"+string(nickname)+"'가 나갔습니다.");
						instance_destroy();
					}
				}
			}
		break;
		
		case DATA.CHECK_PLAYING_NOW:
			show_message_log("- 서버측에서 연결 상태 체크하는 중...");
			//서버측에서 튕겼나 아닌가 체크하는거에 대답하는 코드
			if (!global.is_server)
			{
				var tmp_obj_id_player_only = real(buffer_read(buffer, buffer_string));
				
				//서버로 부터 받은 각 플레이어에 대한 핑 정보 값 적용하기
				var tmp_arr_length = real(buffer_read(buffer, buffer_string));
				for(var i = 0; i < tmp_arr_length; i++)
				{
					global.users_ping_display[i] = real(buffer_read(buffer, buffer_string));
				}
				
				
				if (global.my_player_id == tmp_obj_id_player_only)
				{
					//서버에 플레이어가 여러명일때 동시 다발적으로 보내면 인식을 못해서 사이에 텀을 주기 위해
					alarm[2] = global.my_player_id*5;
				}
				global.is_check_me = true;
			}
		break;
		
		case DATA.REPLY_STILL_PLAYING:
			//서버 측 에서만 튕겼다고 판단한 플레이어가 대답이 온거를 받음
			if (global.is_server)
			{
				var tmp_obj_id_player_only = real(buffer_read(buffer, buffer_string));
				
				show_message_log("- 접속한 플레이어 연결 상태 재확인 중... ["+string(tmp_obj_id_player_only)+"]");
				with(obj_player)
				{
					if (obj_id_player_only == tmp_obj_id_player_only)
					{
						var tmp_p_id = tmp_obj_id_player_only-1;
						
						
						//핑 계산
						var cal_ping = global.users_ping[tmp_p_id]-(tmp_obj_id_player_only*5 + 1);
						cal_ping = ((cal_ping/60)*1000)/2; //fps to ms
						//(나누기 2하는거는 왔다->가는 시간이기 때문)
						show_debug_message("player id - "+string(tmp_obj_id_player_only)+"의 ping : "+string(cal_ping)+"ms / "+string(global.users_ping[tmp_p_id]))
						global.users_ping_display[tmp_p_id] = cal_ping;
						global.users_ping[tmp_p_id] = 0;
						
						//대답이 왔으니 -5로 설정된 값이 기존 x좌표 값으로 다시 바뀜
						global.saved_players_xx[tmp_p_id] = x;
					}
				}
			}
		break;
		
		case DATA.CHAT:
			var str = buffer_read(buffer, buffer_string);
			show_message_log(str);
		break;
		
		case DATA.INS_VAR_DATA:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				var tmp_obj_id = real(buffer_read(buffer, buffer_string));
				var tmp_obj_name = asset_get_index(buffer_read(buffer, buffer_string));
				var tmp_name = buffer_read(buffer, buffer_string);
				var tmp_val = buffer_read(buffer, buffer_string);
				try
				{
					tmp_val = real(tmp_val);
				} catch(e) {}
				
				
				//디버그 메세지로 받아온 값 출력
				show_debug_message("INS_VAR_DATA ["+string(tmp_name)+" : "+string(tmp_val)+"]");
				
				
				
				
				if (tmp_val != "")
				{
					var tmp_id_real = -4;
					with(tmp_obj_name)
					{
						if (obj_id == tmp_obj_id)
						{
							tmp_id_real = id;
						}
					}
					
					//만약 받아온 변수가 is_opened인경우 (= 상자 및 플레이어 루팅 관련 변수)
					if (tmp_name == "is_opened")
					{
						tmp_val = (tmp_val != -4) ? -3 : tmp_val; //그냥 -3값으로 적용 (= 다른사람이 열고 있는 상태 라는 뜻)
						variable_instance_set(tmp_id_real,"b_is_opened",tmp_val);
					}
				
					variable_instance_set(tmp_id_real,string(tmp_name),tmp_val);
				}
			}
		break;
		
		case DATA.GL_VAR_DATA:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				var tmp_name = buffer_read(buffer, buffer_string);
				var tmp_val = buffer_read(buffer, buffer_string);
				try
				{
					tmp_val = real(tmp_val);
				} catch(e) {}
				
				variable_global_set(string(tmp_name),tmp_val);
			}
		break;
		
		//특정 obj_id와 일치하는 오브젝트의 이미지 관련 모든 값을 적용
		case DATA.IMG_DATA:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				var tmp_object_id_ind = real(buffer_read(buffer, buffer_string));
				var tmp_obj_ind = asset_get_index(buffer_read(buffer, buffer_string));
				var tmp_spr_ind = asset_get_index(buffer_read(buffer, buffer_string));
				var tmp_img_ind = buffer_read(buffer, buffer_string);
				var tmp_xx = buffer_read(buffer, buffer_string);
				var tmp_yy = buffer_read(buffer, buffer_string);
				var tmp_zz = buffer_read(buffer, buffer_string);
				var tmp_xscale = buffer_read(buffer, buffer_string);
				var tmp_yscale = buffer_read(buffer, buffer_string);
				var tmp_angle = buffer_read(buffer, buffer_string);
				var tmp_blend = buffer_read(buffer, buffer_string);
				var tmp_alpha = buffer_read(buffer, buffer_string);
				


				with(tmp_obj_ind)
				{
					if (tmp_object_id_ind == obj_id)
					{
						sprite_index = (sprite_exists(tmp_spr_ind)) ? tmp_spr_ind : sprite_index;
						image_index = (tmp_img_ind != "") ? floor(real(tmp_img_ind)/100) : image_index;
						
						//최적화용 플레이어 오브젝트만 틱레이트 적용
						if (object_index == obj_player)
						{
							tickrate_x = (tmp_xx != "") ? floor(real(tmp_xx)/100) : tickrate_x;
							tickrate_y = (tmp_yy != "") ? floor(real(tmp_yy)/100) : tickrate_y;
							tickrate_z = (tmp_zz != "") ? floor(real(tmp_zz)/100) : tickrate_z;
						}
						else //나머지 일반 오브젝트들은 적용 안해도 문제 안됨 (계속 정보 보내는게 아니니까)
						{
							x = (tmp_xx != "") ? floor(real(tmp_xx)/100) : x;
							y = (tmp_yy != "") ? floor(real(tmp_yy)/100) : y;
							z = (tmp_zz != "") ? floor(real(tmp_zz)/100) : z;
						}
						image_xscale = (tmp_xscale != "") ? floor(real(tmp_xscale)/100) : image_xscale;
						image_yscale = (tmp_yscale != "") ? floor(real(tmp_yscale)/100) : image_yscale;
						image_angle = (tmp_angle != "") ? floor(real(tmp_angle)/100) : image_angle;
						image_blend = (tmp_blend != "") ? floor(real(tmp_blend)/100) : image_blend;
						image_alpha = (tmp_alpha != "") ? floor(real(tmp_alpha)/100) : image_alpha;
					}
				}
			}
		break;
		
		case DATA.NEW_MAP_DATA:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			var tmp_map_seed = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id && global.is_map_exists != tmp_map_seed)
			{
				show_message_log("맵 시드 : "+string(global.is_map_exists));
				global.map_creation_falied = 0;
				
				//여기에는 시드 값이 적용됨
				global.is_map_exists = tmp_map_seed;
				
				//최대 루트 길이
				global.max_root_length = real(buffer_read(buffer, buffer_string));
				
				//행 = height, 열 = width
				global.map_width = real(buffer_read(buffer, buffer_string));
				global.map_height = real(buffer_read(buffer, buffer_string));
				
				//스타트 지점
				global.map_start_pos_xx = real(buffer_read(buffer, buffer_string));
				global.map_start_pos_yy = real(buffer_read(buffer, buffer_string));
				
				//전체 룸 갯수
				global.n_room_num = real(buffer_read(buffer, buffer_string));
				
				//모든 플레이어의 위치정보를 스타트 지점으로 초기화
				for(var i = 0; i < array_length(global.n_player_room_xx); i++)
				{
					global.n_player_room_xx[i] = global.map_start_pos_xx;
					global.n_player_room_yy[i] = global.map_start_pos_yy;
				}
				
				
				
				for(var i = 0; i < global.map_height; i++;)
				{
					for(var ii = 0; ii < global.map_width; ii++;)
					{
						//map_arr = 0 일때 방이 없음 / 1일때 방 존재
						global.map_arr[i][ii] = real(buffer_read(buffer, buffer_string));
						
						//map_arr = 0 일때 방이 없음 / 1일때 방 존재
						global.map_room_type[i][ii] = real(buffer_read(buffer, buffer_string));
						
						//각 방에 대한 방 넓이
						global.map_room_width[i][ii] = real(buffer_read(buffer, buffer_string));
						global.map_room_height[i][ii] = real(buffer_read(buffer, buffer_string));
						
						//방 A와 연결되있는 방 B의 위치 인덱스
						global.room_connected_to_xx[i][ii] = real(buffer_read(buffer, buffer_string));
						global.room_connected_to_yy[i][ii] = real(buffer_read(buffer, buffer_string));
						
						//방 A와 연결되있는 방 B의 위치 인덱스 (2번째 연결)
						global.room_connected_to_xx_sec[i][ii] = real(buffer_read(buffer, buffer_string));
						global.room_connected_to_yy_sec[i][ii] = real(buffer_read(buffer, buffer_string));
					}
				}
				
				
				
				//현재 내 플레이어 위치 (룸)
				global.n_player_room_xx[global.my_player_id] = global.map_start_pos_xx;
				global.n_player_room_yy[global.my_player_id] = global.map_start_pos_yy;
				
				
				//현재 위치 (= 스타트 지점)에 대한 룸 정보 불러오기
				load_room(global.n_player_room_xx[global.my_player_id],global.n_player_room_yy[global.my_player_id]);
		
		
		
				
				show_message_log("- 맵 로드 완료");
				obj_player.x = room_width*0.5;
				obj_player.y = room_height*0.5;
				
				//카메라 줌 설정
				global.n_camera_zoom = 0.53;
				
				//라이트 서피스 설정
				global.enable_light_surf = true;
			}
		break;
		
		case DATA.MY_ROOM_POS:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				global.n_player_room_xx[tmp_my_player_id] = real(buffer_read(buffer, buffer_string));
				global.n_player_room_yy[tmp_my_player_id] = real(buffer_read(buffer, buffer_string));
			}
		break;
		
		case DATA.ROOM_DATA_SPECIFIC:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				var tmp_xx = real(buffer_read(buffer, buffer_string));
				var tmp_yy = real(buffer_read(buffer, buffer_string));
				global.map_arr[tmp_yy][tmp_xx] = real(buffer_read(buffer, buffer_string));
			}
		break;
		
		case DATA.INV_DATA:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				var tmp_obj_id = real(buffer_read(buffer, buffer_string));
				var tmp_obj_ind = asset_get_index(buffer_read(buffer, buffer_string));
				var tmp_real_ins_id = -4;
				var tmp_str = "";
				
				//상자류 오브젝트 중 obj_id가 일치하는 오브젝트 찾기 
				with(tmp_obj_ind)
				{
					if (obj_id == tmp_obj_id)
					{
						tmp_real_ins_id = id;
						break;
					}
				}
				
				//obj_id가 일치하는 오브젝트가 아에 없는 경우 새로 생성
				var tmp_args = [ -4, -4, -4, -4, -4, -4 ];
				var tmp_num = array_length(tmp_args)-1;
				for(var i = 0; i < tmp_num; i++)
				{
					tmp_args[i] = real(buffer_read(buffer, buffer_string));
				}
				tmp_args[tmp_num] = buffer_read(buffer, buffer_string); //loots_name
				var tmp_xpos = real(buffer_read(buffer, buffer_string)); //xpos
				var tmp_ypos = real(buffer_read(buffer, buffer_string)); //ypos
				
				if (tmp_real_ins_id == -4)
				{
					tmp_real_ins_id = create_loots(tmp_args[0],tmp_args[1],tmp_args[2],tmp_args[3],tmp_args[4],tmp_args[5],tmp_obj_id,true,tmp_xpos,tmp_ypos);
				}
				
				
				//위에서 찾은 상자류 오브젝트 정보값 받아오기
				with(tmp_real_ins_id)
				{
					for(var i = 0; i < inv_height; i++)
					{
						for(var ii = 0; ii < inv_width; ii++)
						{
							if (buffer_get_size(buffer) > 0)
							{
								var tmp_spr_name_real = buffer_read(buffer, buffer_string);
								var tmp_spr_name = asset_get_index(tmp_spr_name_real);
								inv_info_spr_ind[i][ii] = (tmp_spr_name == -1) ? real(tmp_spr_name_real) : tmp_spr_name;//spr_ind값 보유
								inv_info_img_ind[i][ii] = real(buffer_read(buffer, buffer_string));//img_ind값 보유
								inv_info_name[i][ii] = buffer_read(buffer, buffer_string);//아이템의 이름 값 보유
								inv_info_name_compressed[i][ii] = buffer_read(buffer, buffer_string);//아이템의 이름 값 보유
								inv_info_stack_num[i][ii] = real(buffer_read(buffer, buffer_string));//아이템의 갯수 값 보유
								inv_info_max_stack_num[i][ii] = real(buffer_read(buffer, buffer_string));//아이템의 최대 스택 갯수 값 보유
								inv_info_width[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 가로 길이
								inv_info_height[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 세로 길이
								inv_info_rotated[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 회전 유무
								inv_info_weight[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 회전 유무
								inv_info_searched[i][ii] = 0;//아이템 서치됨
								tmp_str = string(tmp_str)+string(inv_info_spr_ind[i][ii])+" ";
							}
						}
						tmp_str = string(tmp_str)+"\n";
					}
				
					
					//모든 인벤토리 UI들 리로드
					show_debug_message("인벤토리 리로드 - "+string(object_get_name(tmp_obj_ind))+" / "+string(obj_id));
					show_debug_message(tmp_str); //인벤토리 정보 디버그 콘솔창에 표기
				}
						
				//인벤토리 ui정보 리로드
				with(obj_inv_ui)
				{
					if (object_index == obj_inv_ui)
					{
						reload_inv = 1;
					}
				}
			}
		break;
		
		case DATA.INV_DATA_SPECIFIC:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				var tmp_obj_id = real(buffer_read(buffer, buffer_string));
				var tmp_obj_ind = asset_get_index(buffer_read(buffer, buffer_string));
				
				with(tmp_obj_ind)
				{
					var tmp_str = "";
					if (obj_id == tmp_obj_id)
					{
						if (buffer_get_size(buffer) > 0)
						{
							var i = real(buffer_read(buffer, buffer_string));
							var ii = real(buffer_read(buffer, buffer_string));
							var tmp_spr_name_real = buffer_read(buffer, buffer_string);
							var tmp_spr_name = asset_get_index(tmp_spr_name_real);
							inv_info_spr_ind[i][ii] = (tmp_spr_name == -1) ? real(tmp_spr_name_real) : tmp_spr_name;//spr_ind값 보유
							inv_info_img_ind[i][ii] = real(buffer_read(buffer, buffer_string));//img_ind값 보유
							inv_info_name[i][ii] = buffer_read(buffer, buffer_string);//아이템의 이름 값 보유
							inv_info_name_compressed[i][ii] = buffer_read(buffer, buffer_string);//아이템의 이름 값 보유
							inv_info_stack_num[i][ii] = real(buffer_read(buffer, buffer_string));//아이템의 갯수 값 보유
							inv_info_max_stack_num[i][ii] = real(buffer_read(buffer, buffer_string));//아이템의 최대 스택 갯수 값 보유
							inv_info_width[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 가로 길이
							inv_info_height[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 세로 길이
							inv_info_rotated[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 회전 유무
							inv_info_weight[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 회전 유무
							inv_info_searched[i][ii] = 0;//아이템 서치됨
						}
					}
					
					//모든 인벤토리 UI들 리로드
					show_debug_message("인벤토리 리로드(Specific) - "+string(object_get_name(tmp_obj_ind))+" / "+string(obj_id));
					show_debug_message(tmp_str); //인벤토리 정보 디버그 콘솔창에 표기
						
					//인벤토리 ui정보 리로드
					with(obj_inv_ui)
					{
						if (object_index == obj_inv_ui)
						{
							reload_inv = 1;
						}
					}
				}
			}
		break;
		
		case DATA.OBJECTS_DATA:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				instance_create_or_delete(buffer);
			}
		break;
		
		case DATA.OBJECTS_DATA_WHOLESCALE:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				while(true)
				{
					var tmp_obj_ind_name = buffer_read(buffer, buffer_string);
					if (tmp_obj_ind_name == "") //수신할 데이터가 더 이상 없는 경우
					{
						break;
					}
					else //아직 데이터가 남아있는 경우
					{
						var tmp_obj_ind = asset_get_index(tmp_obj_ind_name);
						var tmp_obj_id = real(buffer_read(buffer, buffer_string));
				

						show_message_log("- ["+string(tmp_obj_id)+"] 오브젝트 데이터 수신 완료");
					
						//이미 해당 obj_id를 가진 오브젝트가 존재하는지 체크
						/*새로운 플레이어가 중도 참여시 기존에 있던 유저들한테도 전부 다 오브젝트 생성하라고
						명령을 보내는데, 이 때문에 오브젝트가 중복되서 생성되는 것을 방지하기 위함*/
						var can_create_object = true;
						with(tmp_obj_ind)
						{
							if (obj_id == tmp_obj_id)
							{
								can_create_object = false;
							}
						}
					
					
						//존재하지 않으면 생성해주기
						if (can_create_object)
						{
							//상자류-일반 오브젝트 모두 공통적으로 수신받는 값
							var tmp_xx = real(buffer_read(buffer, buffer_string));
							var tmp_yy = real(buffer_read(buffer, buffer_string));
							var tmp_img_ind = real(buffer_read(buffer, buffer_string));
							var tmp_xpos = real(buffer_read(buffer, buffer_string));
							var tmp_ypos = real(buffer_read(buffer, buffer_string));
							
							
							//루팅 가능한 오브젝트(= 상자류)인지 일반 오브젝트인지 체크
							if (tmp_obj_ind == obj_loots)
							{
								var tmp_inv_width = real(buffer_read(buffer, buffer_string));
								var tmp_inv_height = real(buffer_read(buffer, buffer_string));
								var tmp_loot_name = buffer_read(buffer, buffer_string);
								
								var tmp_ins = create_loots(tmp_xx,tmp_yy,tmp_img_ind,tmp_inv_width,tmp_inv_height,tmp_loot_name,tmp_obj_id,true,tmp_xpos,tmp_ypos);
								
								with(tmp_ins)
								{
									for(var i = 0; i < tmp_inv_height; i++)
									{
										for(var ii = 0; ii < tmp_inv_width; ii++)
										{
											if (buffer_get_size(buffer) > 0)
											{
												var tmp_spr_name_real = buffer_read(buffer, buffer_string);
												var tmp_spr_name = asset_get_index(tmp_spr_name_real);
												inv_info_spr_ind[i][ii] = (tmp_spr_name == -1) ? real(tmp_spr_name_real) : tmp_spr_name;//spr_ind값 보유
												inv_info_img_ind[i][ii] = real(buffer_read(buffer, buffer_string));//img_ind값 보유
												inv_info_name[i][ii] = buffer_read(buffer, buffer_string);//아이템의 이름 값 보유
												inv_info_name_compressed[i][ii] = buffer_read(buffer, buffer_string);//아이템의 이름 값 보유
												inv_info_stack_num[i][ii] = real(buffer_read(buffer, buffer_string));//아이템의 갯수 값 보유
												inv_info_max_stack_num[i][ii] = real(buffer_read(buffer, buffer_string));//아이템의 최대 스택 갯수 값 보유
												inv_info_width[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 가로 길이
												inv_info_height[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 세로 길이
												inv_info_rotated[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 회전 유무
												inv_info_weight[i][ii] = real(buffer_read(buffer, buffer_string));//아이템 회전 유무
												inv_info_searched[i][ii] = 0;//아이템 서치됨
											}
										}
									}
								}
							}
							else
							{
								instance_create_multiplayer(tmp_obj_ind,tmp_xx,tmp_yy,tmp_obj_id,tmp_img_ind,true,tmp_xpos,tmp_ypos);
							}
						}
					}
				}
			}
		break;
		
		case DATA.CHEST_DATA:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				var tmp_xx = real(buffer_read(buffer, buffer_string));
				var tmp_yy = real(buffer_read(buffer, buffer_string));
				var tmp_img_ind = real(buffer_read(buffer, buffer_string));
				var tmp_inv_width = real(buffer_read(buffer, buffer_string));
				var tmp_inv_height = real(buffer_read(buffer, buffer_string));
				var tmp_inv_name = buffer_read(buffer, buffer_string);
				var tmp_obj_id = real(buffer_read(buffer, buffer_string));
				var tmp_xpos = real(buffer_read(buffer, buffer_string));
				var tmp_ypos = real(buffer_read(buffer, buffer_string));
				
				//상자 생성
				var tmp_ins = create_loots(tmp_xx,tmp_yy,tmp_img_ind,tmp_inv_width,tmp_inv_height,tmp_inv_name,tmp_obj_id,1,tmp_xpos,tmp_ypos);
				//네트워크상으로 위치 전송하기 위한 용도
				tmp_ins.b_vspeed = 0;
				tmp_ins.b_hspeed = 0;
				tmp_ins.b_zspeed = 0;
			}
		break;
		
		case DATA.SFX_DATA:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				if (global.n_player_room_xx[tmp_my_player_id] == global.n_player_room_xx[global.my_player_id] && global.n_player_room_yy[tmp_my_player_id] == global.n_player_room_yy[global.my_player_id])
				{
					var tmp_audio_name = buffer_read(buffer, buffer_string);
					var tmp_soundid = asset_get_index(tmp_audio_name);
				
					var tmp_volume = real(buffer_read(buffer, buffer_string));
					var tmp_xx = real(buffer_read(buffer, buffer_string));
					var tmp_yy = real(buffer_read(buffer, buffer_string));
					var tmp_max_dis = real(buffer_read(buffer, buffer_string));
				
					play_sound_pos(tmp_soundid,false,tmp_volume,tmp_xx,tmp_yy,tmp_max_dis,true);
				}
			}
		break;
	}
	
	//클라이언트가 보낸거를 서버에서 받고 서버에서 다른 클라이언트한테 재전달
	if (global.is_server) 
	{
		send_all(buffer);
	}
}