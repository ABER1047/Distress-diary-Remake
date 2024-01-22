/// @description Insert description here
// You can write your code in this editor

if (server == -4)
{
	//서버 생성
	if (keyboard_check_pressed(vk_f12)) 
	{
		server = network_create_server(network_socket_tcp, server_port, 5);
		
		if (server < 0) 
		{
			show_message_log("서버 생성 오류 발생!");
		}
		else 
		{
			alarm[1] = 1;
			is_server = true;
			show_message_log("서버 생성 완료!");
		}
	}
	else if (keyboard_check_pressed(vk_f11)) //서버 접속
	{
		server = network_create_socket(network_socket_tcp);
		var res = network_connect(server, server_ip, server_port);
		
		if (res < 0) 
		{
			show_message_log("서버 연결 오류 발생!");
		}
		else 
		{
			alarm[1] = 1;
			show_message_log("서버 접속 완료!");
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////

if (activity == 1)
{
	chat_alpha += (1.2 - chat_alpha)*0.1;
	if string_length(keyboard_string) > 30
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
			buffer_seek(chat_buffer, buffer_seek_start, 0);
	
			buffer_write(chat_buffer, buffer_u8, DATA.CHAT);
			buffer_write(chat_buffer, buffer_string, chat_entering);
	
			send_all(chat_buffer);
			if (is_server) 
			{
				chat_up(chat_entering);
			}
			chat_entering = "";
			keyboard_string = "";
		}
		else
		{
			activity *= -1;
		}
	}
}
else
{
	if (keyboard_check_pressed(ord("U")) || keyboard_check_pressed(vk_enter))
	{
		activity *= -1;
		keyboard_string = "";
	}
	chat_alpha += (-0.2 - chat_alpha)*0.1
}