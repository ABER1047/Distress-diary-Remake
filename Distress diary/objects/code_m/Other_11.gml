/// @description Server Connection
// You can write your code in this editor


var tmp_encoded = clipboard_get_text();
var tmp_ip = (tmp_encoded == "127.0.0.1" || tmp_encoded == "") ? "127.0.0.1" : decode_invite_code(tmp_encoded);
server_ip = tmp_ip;
server = network_create_socket(network_socket_tcp);
var res = network_connect(server, server_ip, server_port);


//VC system
//voice_server_socket = server;

		
if (res < 0) 
{
	event_user(3);
	show_message_log("해당 서버에 접속할 수 없습니다 [에러 코드 "+string(res)+"]");
	
	//VC system
	//scr_voiceclient_stop();
}
else 
{
	alarm[1] = 1;
	global.is_server = false;
	show_message_log("서버 접속 완료!");
	
	connected_to_voice_server = true;
	voice_client = true;
		
		
	//VC system
	//scr_voiceclient_send_userinfo();
	//audio_debug(true);
}