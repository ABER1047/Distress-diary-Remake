/// @description Insert description here
// You can write your code in this editor
window()
server_ip = "61.82.143.119";
server_port = 33136; 
is_server = false;
index = 0;
server = -4;


//랜덤 이름 생성기
var _random_alphabet_fir = [ "a","e","i","o","u" ];
var _random_alphabet_sec = [ "b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z" ];
var tmp_str = choose(_random_alphabet_fir[irandom_range(0,array_length(_random_alphabet_fir)-1)],_random_alphabet_sec[irandom_range(0,array_length(_random_alphabet_sec)-1)]);

var random_length = irandom_range(3,6);
repeat(random_length)
{
	tmp_str = tmp_str+_random_alphabet_fir[irandom_range(0,array_length(_random_alphabet_fir)-1)]+_random_alphabet_sec[irandom_range(0,array_length(_random_alphabet_sec)-1)];
}

global.nickname = tmp_str;


//채팅 UI관련
depth = -room_width*2
chat_alpha = 0;
chat_entering = "";
activity = -1;
global.chat = array_create(10, "");




enum DATA 
{
	INIT_DATA,
	CHAT,
	ONE_DATA,
	MUCH_DATA,
	ADD_CLI,
	REMOVE_CLI,
	COMMAND
}

enum COMM 
{
	INFO,
	DMGED_INFO
}


info_buffer = buffer_create(2, buffer_grow, 1);
dis_buffer = buffer_create(2, buffer_grow, 1);
one_buffer = buffer_create(2, buffer_grow, 1);
much_buffer = buffer_create(2, buffer_grow, 1);
my_ID = 0;
my_instance_id = 0;
clients = ds_list_create();
list_names = ds_list_create();
list_vals = ds_list_create();
list_types = ds_list_create();


cli_num = 0;
chat_buffer = buffer_create(2, buffer_grow, 1);