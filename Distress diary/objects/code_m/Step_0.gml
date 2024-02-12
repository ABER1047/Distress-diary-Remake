/// @description Insert description here
// You can write your code in this editor

//초대 코드 생성
if (global.my_ip != "")
{
	var tmp_rd_invite_code_seed = floor(current_minute/5)
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
			server = -4;
			show_message_log("서버 생성 오류 발생!");
		}
		else 
		{
			alarm[1] = 1;
			global.is_server = true;
			show_message_log("서버 생성 완료!");
		}
	}
	else if (keyboard_check_pressed(vk_f11)) //서버 접속
	{
		var tmp_ip = decode_invite_code(clipboard_get_text());
		server_ip = (tmp_ip == global.my_ip) ? "127.0.0.1" : tmp_ip;
		server = network_create_socket(network_socket_tcp);
		var res = network_connect(server, server_ip, server_port);
		
		if (res < 0) 
		{
			server = -4;
			show_message_log("해당 서버에 접속할 수 없습니다");
		}
		else 
		{
			alarm[1] = 1;
			global.is_server = false;
			show_message_log("서버 접속 완료!");
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////

if (global.chat_activated == 1)
{
	chat_alpha += (1 - chat_alpha)*0.3;
	if string_length(keyboard_string) > 64
	{
		keyboard_string = chat_entering;
	}
	else
	{
		chat_entering = keyboard_string;
	}
	
	if (keyboard_check_pressed(vk_enter))
	{
		if (chat_entering != "")
		{
			var tmp_chat = string(global.nickname)+" : "+string(chat_entering);
			buffer_seek(chat_buffer, buffer_seek_start, 0);
			buffer_write(chat_buffer, buffer_u8, DATA.CHAT);
			buffer_write(chat_buffer, buffer_string, tmp_chat);
			send_all(chat_buffer);
			
			
			//명령어 감지
			var is_command = false;
			if (global.dev_mode == 1)
			{
				if (string_pos("/kill",chat_entering))
				{
					(global.my_player_ins_id[global.my_player_id]).hp = 0;
				}
			}
			
			
			if (is_command && global.is_server) 
			{
				chat_up(tmp_chat);
				if (!global.chat_activated)
				{
					show_message_log(tmp_chat);
				}
			}
			chat_entering = "";
			keyboard_string = "";
		}
		else
		{
			clean_message_log();
			global.chat_activated *= -1;
		}
	}
}
else
{
	if (keyboard_check_pressed(ord("U")) || keyboard_check_pressed(vk_enter))
	{
		global.chat_activated *= -1;
		keyboard_string = "";
	}
	chat_alpha += (-0.01 - chat_alpha)*0.3;
}