var type = async_load[? "type"];


//누군가 연결/단절 했을 때 발생하는 이벤트 (서버쪽에서만 발생하는 이벤트)
if (type == network_type_connect) 
{
	var socket = async_load[? "socket"];
	var cli_max = ds_list_size(clients);
	network_set_timeout(socket, 3000, 3000);
	
	//obj_id 할당용 변수
	global.object_id_ind ++;
	
	buffer_seek(info_buffer, buffer_seek_start, 0);
	buffer_write(info_buffer, buffer_u8, DATA.INIT_DATA);
	buffer_write(info_buffer, buffer_u32, cli_max);
	buffer_write(info_buffer, buffer_u32, global.object_id_ind);
	buffer_write(info_buffer, buffer_u8, socket);
	
	//처음 들어왔을 때
	for(var i = 0; i < global.object_id_ind; i++) 
	{
		with(obj_player)
		{
			if (global.object_id_ind == obj_id) 
			{
				//soc는 각 플레이어 마다 부여되는 소켓임 (= 고유 id)
				buffer_write(other.info_buffer, buffer_u8, soc);
				buffer_write(other.info_buffer, buffer_string, nickname);
			}
		}
	}
	
	network_send_packet(socket, info_buffer, buffer_get_size(info_buffer));

	ds_list_add(clients, socket);
}
else if (type == network_type_disconnect) // 누군가 나갔을 때 발생하는 이벤트
{
	var socket = async_load[? "socket"];//"id"쓰지 말것 무조건 0이 나온다.

	buffer_seek(dis_buffer, buffer_seek_start, 0);
	buffer_write(dis_buffer, buffer_u8, DATA.REMOVE_CLI);
	buffer_write(dis_buffer, buffer_u8, socket);
	
	var tmp_nickname = "";
	with(obj_player) 
	{
		if (soc == socket) 
		{
			//나간 플레이어가 해당 플레이어인 경우
			tmp_nickname = nickname;
			instance_destroy();
		}
	}
	show_message_log("'"+string(tmp_nickname)+"'가 나갔습니다.");
	
	var pos = ds_list_find_index(clients, socket);
	ds_list_delete(clients, pos);
	
	send_all(dis_buffer);
}

else if (type == network_type_data) //클라이언트/서버 양쪽에서 발생하는 이벤트
{
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var data = buffer_read(buffer, buffer_u8);
	
	switch(data) 
	{
		case DATA.INIT_DATA: //클라이언트측에서만 발생하는 이벤트 
			if (is_server == false)
			{
				//총 접속 인원 (자신 제외)
				var tmp_player_num = buffer_read(buffer, buffer_u32);
				//받아온 서버의 global.object_id_ind 값
				var tmp_object_id_ind = buffer_read(buffer, buffer_u32);
			
				//받아온 서버의 소켓
				var tmp_soc = buffer_read(buffer, buffer_u8);
				network_set_timeout(tmp_soc, 3000, 3000);
				obj_player.soc = tmp_soc;
				obj_player.obj_id = tmp_object_id_ind;
			
				//code_m 오브젝트에도 obj_id 저장해둠
				global.my_player_id = tmp_object_id_ind;
				
				
				show_message_log("채팅방에 들어왔습니다.");
				for(i = 1; i <= tmp_player_num; i++)
				{
					var obj = instance_create_depth(room_width*0.5+irandom_range(-640,640), room_height*0.5+irandom_range(-640,640), 0, obj_player);
					obj.obj_id = tmp_object_id_ind-i; //고유 obj_id값 부여
					
					//각 플레이어마다 고유한 소켓을 가지고 있음 (= 고유 id)
					obj.soc = buffer_read(buffer, buffer_u8);
					obj.nickname = buffer_read(buffer, buffer_string);
				}
			
			
				//서버 한테 접속했다고 데이터 발송
				buffer_seek(info_buffer, buffer_seek_start, 0);
				buffer_write(info_buffer, buffer_u8, DATA.ADD_CLI);
				buffer_write(info_buffer, buffer_u32, tmp_object_id_ind); //내가 배정받은 고유 obj_id를 서버로 전송
				buffer_write(info_buffer, buffer_u8, soc); //내 소켓을 서버에 전송
				buffer_write(info_buffer, buffer_string, global.nickname); //내 닉네임을 서버에 전송
				send_all(info_buffer);
			}
		break;
		
		case DATA.CHAT:
			var str = buffer_read(buffer, buffer_string);
			show_message_log(str);
		break;
		
		case DATA.GL_VAR_DATA:
			var tmp_object_id_ind = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_object_id_ind)
			{
				var tmp_name = buffer_read(buffer, buffer_string);
				var tmp_val = buffer_read(buffer, buffer_string);
				variable_global_set(string(tmp_name),tmp_val);
			}
		break;
		
		//특정 obj_id와 일치하는 오브젝트의 이미지 관련 모든 값을 적용
		case DATA.IMG_DATA:
			var tmp_object_id_ind = real(buffer_read(buffer, buffer_string));
			
			//보낸 나 자신 제외
			if (global.my_player_id != tmp_object_id_ind)
			{
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
		
		case DATA.ADD_CLI: //서버쪽에서만 발생하는 이벤트
			if (is_server == true)
			{
				var tmp_object_id_ind = buffer_read(buffer, buffer_u32);
				var tmp_soc = buffer_read(buffer, buffer_u8);
				var tmp_nickname = buffer_read(buffer, buffer_string);
			
				//들어온 자기 자신도 이벤트가 작동되기 때문에 그거 방지용
				if (tmp_soc != soc)
				{
					//서버쪽에 새로 접속한 클라이언트 플레이어 생성
					var obj = instance_create_depth(room_width*0.5+irandom_range(-640,640), room_height*0.5+irandom_range(-640,640), 0, obj_player);
					obj.obj_id = tmp_object_id_ind;
					obj.soc = tmp_soc;
					obj.nickname = tmp_nickname;

					show_message_log("'"+string(tmp_nickname)+"'가 왔습니다.");	
				}
			}
		break;
		
		case DATA.REMOVE_CLI:
			var tmp_soc = buffer_read(buffer, buffer_u8);
			
			var tmp_nickname = "";
			with(obj_player) 
			{
				if (soc == socket) 
				{
					//나간 플레이어가 해당 플레이어인 경우
					tmp_nickname = nickname;
					instance_destroy();
				}
			}
			show_message_log("'"+string(tmp_nickname)+"'가 나갔습니다.");
		break;
	}
	
	//클라이언트가 보낸거를 서버에서 받고 서버에서 다른 클라이언트한테 재전달
	if (is_server) 
	{
		send_all(buffer);
	}
}