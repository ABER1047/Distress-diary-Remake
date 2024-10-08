var type = async_load[? "type"];


//누군가 연결/단절 했을 때 발생하는 이벤트 (서버쪽에서만 발생하는 이벤트)
if (type == network_type_connect) 
{
	var socket = async_load[? "socket"];
	var cli_max = instance_number(obj_player);
	network_set_timeout(socket, 3000, 3000);
	

	//object_id_player_only 할당용 변수
	var found_empty_slot = false, tmp_arr_length = array_length(global.my_player_ins_id);
	for(var i = 0; i < tmp_arr_length; i++)
	{
		if (!instance_exists(global.my_player_ins_id[i]))
		{
			global.object_id_player_only = i;
			found_empty_slot = true;
			break;
		}
	}
	
	if (!found_empty_slot)
	{
		global.object_id_player_only = tmp_arr_length;
	}
	
	
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
	event_user(2);
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
						
						//오브젝트 인스턴스 아이디 저장
						global.my_player_ins_id[obj_id_player_only] = id;
					}
				}
				
				//내 플레이어 아이디 값 세팅
				global.my_player_id = global.object_id_player_only;
				
				
				
				//뭔가 문제가 생겨서 제대로 연결이 되지 못한 경우 체크
				alarm[3] = 180;
				
				var all_player_id = -4, tmp_obj_id = -4, i = 0, loop = true;
				//나 이외의 모든 플레이어 기본 정보 값 세팅
				while(loop)
				{
					try
					{
						tmp_obj_id = real(buffer_read(buffer, buffer_string)); //고유 obj_id값 부여
						all_player_id[i] = real(buffer_read(buffer, buffer_string)); //고유 obj_id_player_only값 부여
						var obj = instance_create_depth(-4,-4,0,obj_player);
						obj.obj_id = tmp_obj_id; //고유 obj_id값 부여
						obj.obj_id_player_only = all_player_id[i]; //고유 obj_id_player_only값 부여
						obj.soc = buffer_read(buffer, buffer_u8); //소켓
						obj.nickname = buffer_read(buffer, buffer_string); //닉네임
					
						//오브젝트 인스턴스 아이디 저장
						global.my_player_ins_id[all_player_id[i]] = obj;
						
						i ++;
					}
					catch(e)
					{
						loop = false;
						break;
					}
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
				show_message_log("서버에 참가했습니다. ["+string(global.my_player_id)+" / "+string(all_player_id)+"]");
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
				var obj = instance_create_depth(-4,-4,0,obj_player);
				obj.obj_id = tmp_object_id_ind;
				obj.obj_id_player_only = tmp_object_id_ind_player_only;
				obj.soc = buffer_read(buffer, buffer_u8);
				obj.nickname = tmp_nickname;
				
				//오브젝트 인스턴스 아이디 저장
				global.my_player_ins_id[tmp_object_id_ind_player_only] = obj;

				show_message_log("'"+string(tmp_nickname)+"'가 왔습니다. ["+string(tmp_object_id_ind_player_only)+"]");
				
				
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
			if (tmp_obj_id_player_only != 0)
			{
				if (global.my_player_id == tmp_obj_id_player_only)
				{
					//핑차이가 너무 심하거나, 연결 상태가 좋지 못한 경우라서 그냥 내보내버림
					event_user(0);
				}
				else //진짜로 튕겨서 수신이 안 된 경우 그냥 내보내버리기
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
			}
		break;
		
		case DATA.CHECK_PLAYING_NOW:
			show_debug_message("- 서버측에서 연결 상태 체크하는 중...");
			//서버측에서 튕겼나 아닌가 체크하는거에 수신하는 코드
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
			//서버 측 에서만 튕겼다고 판단한 플레이어가 수신함
			if (global.is_server)
			{
				var tmp_obj_id_player_only = real(buffer_read(buffer, buffer_string));
				
				show_debug_message("- 접속한 플레이어 연결 상태 재확인 중... ["+string(tmp_obj_id_player_only)+"]");
				with(obj_player)
				{
					if (obj_id_player_only == tmp_obj_id_player_only)
					{
						var tmp_p_id = tmp_obj_id_player_only-1;
						
						
						//핑 계산
						var cal_ping = global.users_ping[tmp_p_id]-(tmp_obj_id_player_only*5 + 1);
						cal_ping = ((cal_ping/60)*1000)/2/global.tickrate; //fps to ms
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
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				var str = buffer_read(buffer, buffer_string);
				show_message_log(str);
			}
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
				
				
				//디버그 메세지로 받아온 값 출력
				show_debug_message("data received [obj : "+string(tmp_obj_id)+" / var : "+string(tmp_name)+"] : "+string(tmp_val));
				
				//값이 적용될 인스턴스 찾기
				var tmp_id_real = -4;
				with(tmp_obj_name)
				{
					if (obj_id == tmp_obj_id)
					{
						tmp_id_real = id;
					}
				}
				
				//한 번에 값이 여러개 온 경우
				if (string_pos(",",tmp_val) != 0)
				{
					var tmp_splited_val = string_split(tmp_val,",");
					var tmp_splited_varname = string_split(tmp_name,",");
					for(var i = 0; i < array_length(tmp_splited_val); i++)
					{
						//색깔 값은 따로 적용
						if (string_pos("#",tmp_splited_val[i]) != 0)
						{
							tmp_splited_val[i] = hex_to_color(tmp_splited_val[i]);
						}
						else
						{
							try
							{
								//string화 된 실수를 진짜 실수로
								tmp_splited_val[i] = real(tmp_splited_val[i]);
							}
							catch(e) 
							{
								//string구조로 되어 있는 sprite_index를 sprite_index형으로 변환
								var tmp_converted = asset_get_index(tmp_splited_val[i]);
								tmp_splited_val[i] = (tmp_converted == -1) ? tmp_splited_val[i] : tmp_converted;
							}
						}
						
						
						//만약 받아온 변수가 is_opened인경우 (= 상자 및 플레이어 루팅 관련 변수)
						if (tmp_splited_varname[i] == "is_opened")
						{
							tmp_splited_val[i] = (tmp_splited_val[i] != -4) ? -3 : tmp_splited_val[i]; //그냥 -3값으로 적용 (= 다른사람이 열고 있는 상태 라는 뜻)
							variable_instance_set(tmp_id_real,"b_is_opened",tmp_splited_val[i]);
						}
						else if (tmp_splited_varname[i] == "is_activated") //만약 받아온 변수가 is_activated인경우
						{
							variable_instance_set(tmp_id_real,"b_is_activated",tmp_splited_val[i]);
						}
				
				
						var tmp_string_pos = string_pos("[",tmp_splited_varname[i]);
						if (tmp_string_pos != 0) //변수가 배열인 경우
						{
							var tmp_string_pos_end = string_pos("]",tmp_splited_varname[i]);
							var tmp_str_length = tmp_string_pos_end-tmp_string_pos+1;
							var tmp_arr_ind = real(string_copy(tmp_splited_varname[i],tmp_string_pos+1,tmp_str_length));
							tmp_splited_varname[i] = string_delete(tmp_splited_varname[i],tmp_string_pos,tmp_str_length);
							
							var tmp_arr = variable_instance_get(tmp_id_real,tmp_splited_varname[i]);
							tmp_arr[tmp_arr_ind] = tmp_splited_val[i];
							//show_debug_message("data applied chk ind : "+string(tmp_arr_ind)+" / var : "+string(tmp_id_real.buff_left_time[tmp_arr_ind])+" / "+string(tmp_arr[tmp_arr_ind]));
						}
						else //배열이 아닌 경우 
						{
							variable_instance_set(tmp_id_real,tmp_splited_varname[i],tmp_splited_val[i]);
							//show_debug_message("data applied [obj : "+string(tmp_obj_id)+" / var : "+string(tmp_splited_varname[i])+"] : "+string(tmp_splited_val[i]));
						}
					}
				}
				else
				{
					//값이 한 개만 온 경우
					if (string_trim(tmp_val) != "")
					{
						//색깔 값은 따로 적용
						if (string_pos("#",tmp_val) != 0)
						{
							tmp_val = hex_to_color(tmp_val);
						}
						else
						{
							try
							{
								//string화 된 실수를 진짜 실수로
								tmp_val = real(tmp_val);
							} 
							catch(e) 
							{
								//string구조로 되어 있는 sprite_index를 sprite_index형으로 변환
								var tmp_converted = asset_get_index(tmp_val);
								tmp_val = (tmp_converted == -1) ? tmp_val : tmp_converted;
							}
						}
						
						
						//만약 받아온 변수가 is_opened인경우 (= 상자 및 플레이어 루팅 관련 변수)
						if (tmp_name == "is_opened")
						{
							tmp_val = (tmp_val != -4) ? -3 : tmp_val; //그냥 -3값으로 적용 (= 다른사람이 열고 있는 상태 라는 뜻)
							variable_instance_set(tmp_id_real,"b_is_opened",tmp_val);
						}
						else if (tmp_name == "is_activated")
						{
							variable_instance_set(tmp_id_real,"b_is_activated",tmp_val);
						}
						
						var tmp_string_pos = string_pos("[",tmp_name);
						if (tmp_string_pos != 0) //변수가 배열인 경우
						{
							var tmp_string_pos_end = string_pos("]",tmp_name);
							var tmp_str_length = tmp_string_pos_end-tmp_string_pos+1;
							var tmp_arr_ind = real(string_copy(tmp_name,tmp_string_pos+1,tmp_str_length));
							tmp_name = string_delete(tmp_name,tmp_string_pos,tmp_str_length);
							
							var tmp_arr = variable_instance_get(tmp_id_real,tmp_name);
							tmp_arr[tmp_arr_ind] = tmp_val;
							show_debug_message("data applied chk "+string(tmp_arr[tmp_arr_ind]));
						}
						else //배열이 아닌 경우 
						{
							variable_instance_set(tmp_id_real,tmp_name,tmp_val);
						}
					}
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
				} 
				catch(e) 
				{
					//string구조로 되어 있는 sprite_index를 sprite_index형으로 변환
					var tmp_converted = asset_get_index(tmp_val);
					tmp_val = (tmp_converted == -1) ? tmp_val : tmp_converted;
				}
				
				
				show_debug_message("data received [var : "+string(tmp_name)+"] : "+string(tmp_val));
				var tmp_string_pos = string_pos("[",tmp_name);
				if (tmp_string_pos != 0) //변수가 배열인 경우
				{
					var tmp_string_pos_end = string_pos("]",tmp_name);
					var tmp_str_length = tmp_string_pos_end-tmp_string_pos+1;
					var tmp_arr_ind = real(string_copy(tmp_name,tmp_string_pos+1,tmp_str_length));
					tmp_name = string_delete(tmp_name,tmp_string_pos,tmp_str_length);

					var tmp_arr = variable_global_get(tmp_name);
					array_set(tmp_arr,tmp_arr_ind,tmp_val);
				}
				else //배열이 아닌 경우 
				{
					variable_global_set(tmp_name,tmp_val);
				}
			}
		break;
		
		//특정 obj_id와 일치하는 오브젝트의 이미지 관련 모든 값을 적용
		case DATA.IMG_DATA:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				var tmp_str_data = buffer_read(buffer, buffer_string);
				var tmp_str = string_split(tmp_str_data,"#");
				var tmp_object_id_ind = real(tmp_str[0]);
				var tmp_obj_ind = asset_get_index(tmp_str[1]);
				var tmp_spr_ind = asset_get_index(tmp_str[2]);
				var tmp_img_ind = tmp_str[3];
				var tmp_xx = tmp_str[4];
				var tmp_yy = tmp_str[5];
				var tmp_zz = tmp_str[6];
				var tmp_xscale = tmp_str[7];
				var tmp_yscale = tmp_str[8];
				var tmp_angle = tmp_str[9];
				var tmp_blend = tmp_str[10];
				var tmp_alpha = tmp_str[11];
				


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
				

				//맵 생성
				create_map(global.is_map_exists);
			}
		break;
		
		case DATA.MY_ROOM_POS:
			var tmp_my_player_id = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_my_player_id)
			{
				global.my_player_ins_id[tmp_my_player_id].x = -4;
				global.my_player_ins_id[tmp_my_player_id].y = -4;
				global.n_player_room_xx[tmp_my_player_id] = real(buffer_read(buffer, buffer_string));
				global.n_player_room_yy[tmp_my_player_id] = real(buffer_read(buffer, buffer_string));
				global.my_player_ins_id[tmp_my_player_id].my_pos_xx = global.n_player_room_xx[tmp_my_player_id];
				global.my_player_ins_id[tmp_my_player_id].my_pos_yy = global.n_player_room_yy[tmp_my_player_id];
				load_object_by_pos(10);
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
				var tmp_str = buffer_read(buffer, buffer_string);
				var tmp_args = string_split(tmp_str,"#");

				
				if (tmp_real_ins_id == -4)
				{
					tmp_real_ins_id = create_loots(real(tmp_args[0]),real(tmp_args[1]),real(tmp_args[2]),real(tmp_args[3]),real(tmp_args[4]),tmp_args[5],tmp_obj_id,true,real(tmp_args[6]),real(tmp_args[7]));
				}
				
				
				//위에서 찾은 상자류 오브젝트 정보값 받아오기
				with(tmp_real_ins_id)
				{
					for(var i = 0; i < real(tmp_args[4]); i++)
					{
						for(var ii = 0; ii < real(tmp_args[3]); ii++)
						{
							if (buffer_get_size(buffer) > 0)
							{
								//문자열로 압축된 데이터 값
								var tmp_str_data = buffer_read(buffer, buffer_string);
								var tmp_str = string_split(tmp_str_data,"#");

								var tmp_spr_name_real = tmp_str[0];
								var tmp_spr_name = asset_get_index(tmp_spr_name_real);
								inv_info_spr_ind[i][ii] = (tmp_spr_name == -1) ? real(tmp_spr_name_real) : tmp_spr_name;//spr_ind값 보유
								inv_info_img_ind[i][ii] = real(tmp_str[1]);//img_ind값 보유
								inv_info_name[i][ii] = tmp_str[2];//아이템의 이름 값 보유
								inv_info_name_compressed[i][ii] = tmp_str[3];//아이템의 이름 값 보유
								inv_info_stack_num[i][ii] = real(tmp_str[4]);//아이템의 갯수 값 보유
								inv_info_max_stack_num[i][ii] = real(tmp_str[5]);//아이템의 최대 스택 갯수 값 보유
								inv_info_width[i][ii] = real(tmp_str[6]);//아이템 가로 길이
								inv_info_height[i][ii] = real(tmp_str[7]);//아이템 세로 길이
								inv_info_rotated[i][ii] = real(tmp_str[8]);//아이템 회전 유무
								inv_info_weight[i][ii] = real(tmp_str[9]);//아이템 무게
								inv_info_searched[i][ii] = 0;//아이템 서치됨
								inv_info_startag[i][ii] = real(tmp_str[10]);//아이템 스타 태그
							}
						}
					}
				
					
					//모든 인벤토리 UI들 리로드
					//show_debug_message("인벤토리 리로드 - "+string(object_get_name(tmp_obj_ind))+" / "+string(obj_id));
					//show_debug_message(tmp_str); //인벤토리 정보 디버그 콘솔창에 표기
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
					if (obj_id == tmp_obj_id)
					{
						if (buffer_get_size(buffer) > 0)
						{
							var tmp_str_data = buffer_read(buffer, buffer_string);
							var tmp_str = string_split(tmp_str_data,"#");
							var i = real(tmp_str[0]);
							var ii = real(tmp_str[1]);
							var tmp_spr_name_real = tmp_str[2];
							var tmp_spr_name = asset_get_index(tmp_spr_name_real);
							inv_info_spr_ind[i][ii] = (tmp_spr_name == -1) ? real(tmp_spr_name_real) : tmp_spr_name;//spr_ind값 보유
							inv_info_img_ind[i][ii] = real(tmp_str[3]);//img_ind값 보유
							inv_info_name[i][ii] = tmp_str[4];//아이템의 이름 값 보유
							inv_info_name_compressed[i][ii] = tmp_str[5];//아이템의 이름 값 보유
							inv_info_stack_num[i][ii] = real(tmp_str[6]);//아이템의 갯수 값 보유
							inv_info_max_stack_num[i][ii] = real(tmp_str[7]);//아이템의 최대 스택 갯수 값 보유
							inv_info_width[i][ii] = real(tmp_str[8]);//아이템 가로 길이
							inv_info_height[i][ii] = real(tmp_str[9]);//아이템 세로 길이
							inv_info_rotated[i][ii] = real(tmp_str[10]);//아이템 회전 유무
							inv_info_weight[i][ii] = real(tmp_str[11]);//아이템 무게
							inv_info_searched[i][ii] = 0;//아이템 서치됨
							inv_info_startag[i][ii] = real(tmp_str[12]);//아이템 스타 태그
						}
					}
					
					//모든 인벤토리 UI들 리로드
					//show_debug_message("인벤토리 리로드(Specific) - "+string(object_get_name(tmp_obj_ind))+" / "+string(obj_id));
					//show_debug_message(tmp_str); //인벤토리 정보 디버그 콘솔창에 표기
						
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
				//어차피 모든 오브젝트 데이터 받아올거니까 지금 존재하는 모든 오브젝트 삭제
				var ins_ = [ obj_loots, obj_vending_machine, obj_arcade_pc, obj_only_breakable, obj_only_breakable_pushable, obj_floor_button, obj_floor_button ];
				for(var i = 0; i < array_length(ins_); i++)
				{
					instance_destroy(ins_[i]);
				}
				
				
				var tmp_force_break = 0;
				while(true)
				{
					tmp_force_break ++;
					var tmp_str_data = buffer_read(buffer, buffer_string);
					var tmp_str = string_split(tmp_str_data,"#");
					show_debug_message("tmp_str : "+string(tmp_str)+" / "+string(array_length(tmp_str)));
					if (tmp_str[0] == "") //수신할 데이터가 더 이상 없는 경우
					{
						break;
					}
					else //아직 데이터가 남아있는 경우
					{
						//상자류-일반 오브젝트 모두 공통적으로 수신받는 값
						var tmp_obj_ind = asset_get_index(tmp_str[0]);
						var tmp_obj_id = real(tmp_str[1]);
						var tmp_xx = real(tmp_str[2]);
						var tmp_yy = real(tmp_str[3]);
						var tmp_img_ind = real(tmp_str[4]);
						var tmp_xpos = real(tmp_str[5]);
						var tmp_ypos = real(tmp_str[6]);
						
				
						if (object_exists(tmp_obj_ind))
						{
							show_debug_message("- ["+string(tmp_obj_id)+"] 오브젝트 데이터 수신 완료");
					
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
								//루팅 가능한 오브젝트(= 상자류)인지 일반 오브젝트인지 체크
								if (tmp_obj_ind == obj_loots)
								{	
									var tmp_inv_width = real(tmp_str[7]);
									var tmp_inv_height = real(tmp_str[8]);
									var tmp_loot_name = tmp_str[9];
								
									var tmp_ins = create_loots(tmp_xx,tmp_yy,tmp_img_ind,tmp_inv_width,tmp_inv_height,tmp_loot_name,tmp_obj_id,true,tmp_xpos,tmp_ypos);
								
									with(tmp_ins)
									{
										for(var i = 0; i < tmp_inv_height; i++)
										{
											for(var ii = 0; ii < tmp_inv_width; ii++)
											{
												if (buffer_get_size(buffer) > 0)
												{
													//문자열로 압축된 데이터 값
													var tmp_str_data = buffer_read(buffer, buffer_string);
													var tmp_str = string_split(tmp_str_data,"#");
													show_debug_message("tmp_str : "+string(tmp_str)+" / "+string(array_length(tmp_str)));

													var tmp_spr_name_real = tmp_str[0];
													var tmp_spr_name = asset_get_index(tmp_spr_name_real);
													inv_info_spr_ind[i][ii] = (tmp_spr_name == -1) ? real(tmp_spr_name_real) : tmp_spr_name;//spr_ind값 보유
													inv_info_img_ind[i][ii] = real(tmp_str[1]);//img_ind값 보유
													inv_info_name[i][ii] = tmp_str[2];//아이템의 이름 값 보유
													inv_info_name_compressed[i][ii] = tmp_str[3];//아이템의 이름 값 보유
													inv_info_stack_num[i][ii] = real(tmp_str[4]);//아이템의 갯수 값 보유
													inv_info_max_stack_num[i][ii] = real(tmp_str[5]);//아이템의 최대 스택 갯수 값 보유
													inv_info_width[i][ii] = real(tmp_str[6]);//아이템 가로 길이
													inv_info_height[i][ii] = real(tmp_str[7]);//아이템 세로 길이
													inv_info_rotated[i][ii] = real(tmp_str[8]);//아이템 회전 유무
													inv_info_weight[i][ii] = real(tmp_str[9]);//아이템 회전 유무
													inv_info_searched[i][ii] = 0;//아이템 서치됨
													inv_info_startag[i][ii] = real(tmp_str[10]);//아이템 서치됨
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
				var tmp_audio_name = buffer_read(buffer, buffer_string);
				var tmp_soundid = asset_get_index(tmp_audio_name);
				
				var tmp_volume = real(buffer_read(buffer, buffer_string));
				var tmp_xx = real(buffer_read(buffer, buffer_string));
				var tmp_yy = real(buffer_read(buffer, buffer_string));
				var tmp_max_dis = real(buffer_read(buffer, buffer_string));
				var tmp_xpos = real(buffer_read(buffer, buffer_string));
				var tmp_ypos = real(buffer_read(buffer, buffer_string));
				
				play_sound_pos(tmp_soundid,false,tmp_volume,tmp_xx,tmp_yy,tmp_max_dis,true,tmp_xpos,tmp_ypos);
			}
		break;
	}
	
	//클라이언트가 보낸거를 서버에서 받고 서버에서 다른 클라이언트한테 재전달
	if (global.is_server) 
	{
		send_all(buffer);
	}
}




//VC system
//asyncNetworkingEvent();