/// @description Insert description here
// You can write your code in this editor



var tmp_ip = decode_invite_code(clipboard_get_text());
server_ip = tmp_ip;
server = network_create_socket(network_socket_tcp);
var res = network_connect(server, server_ip, server_port);
		
if (res < 0) 
{
	server = -4;
	show_message_log("해당 서버에 접속할 수 없습니다 ["+string(tmp_ip)+"]");
}
else 
{
	alarm[1] = 1;
	global.is_server = false;
	show_message_log("서버 접속 완료!");
}