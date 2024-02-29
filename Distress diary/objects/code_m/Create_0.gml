/// @description Insert description here
// You can write your code in this editor
window()
server_ip = "";
server_port = 35221; 
global.is_server = true;
index = 0;
server = -4;
soc = 0;


//내 아이피
global.my_ip = "";
global.invite_code = "";
global.invite_code_seed = -4; //랜덤 초대 코드 생성용 시드
//아이피 받아오기 용
send_request = http_ip_get("");



network_set_config(network_config_connect_timeout,4000);


//채팅 UI관련
depth = -room_width*2
chat_alpha = 0;
chat_entering = "";
global.chat_activated = -1;
global.chat = array_create(10, "");




enum DATA 
{
	INIT_DATA,
	CHAT,
	ADD_CLI,
	REMOVE_CLI,
	IMG_DATA, //image관련 모든 데이터 (spr_ind, img_ind, x, y, z...) 받아오기 용
	GL_VAR_DATA, //global_variable값 받아오기 용
	INS_VAR_DATA, //instance_variable값 받아오기 용
	SET_PLAYER_ID, //처음 접속시 플레이어 아이디 적용 용
	NEW_MAP_DATA, //새로운 맵 데이터 받아오기 용
	MY_ROOM_POS, //각 플레이어의 위치 정보 받아오기 용
	INV_DATA, //인벤토리 데이터 전송용
	OBJECTS_DATA, //오브젝트 생성/삭제용
	CHEST_DATA, //상자 생성용 (삭제는 OBJECTS_DATA로 제어)
	CHECK_PLAYING_NOW, //특정 플레이어 튕겼나 아닌가 체크용
	REPLY_STILL_PLAYING //아직 플레이 중 이라고 다시 한 번 보내주는 용
}
global.DATA_IMG_DATA = DATA.IMG_DATA;
global.DATA_GL_VAR_DATA = DATA.GL_VAR_DATA;
global.DATA_INS_VAR_DATA = DATA.INS_VAR_DATA;
global.DATA_NEW_MAP_DATA = DATA.NEW_MAP_DATA;
global.DATA_MY_ROOM_POS = DATA.MY_ROOM_POS;
global.DATA_INV_DATA = DATA.INV_DATA;
global.DATA_OBJECTS_DATA = DATA.OBJECTS_DATA;
global.DATA_CHEST_DATA = DATA.CHEST_DATA;

info_buffer = buffer_create(16384, buffer_grow, 1);
dis_buffer = buffer_create(16384, buffer_grow, 1);
one_buffer = buffer_create(16384, buffer_grow, 1);
much_buffer = buffer_create(16384, buffer_grow, 1);

//변수 전송용 버퍼
global.variable_data_buffer = buffer_create(16384,buffer_grow,1);

//맵 데이터 전송용 버퍼
global.map_data_buffer = buffer_create(16384,buffer_grow,1);

//오브젝트 데이터 전송용 버퍼
global.obj_data_buffer = buffer_create(16384,buffer_grow,1);

//인벤토리 데이터 전송용 버퍼
global.inv_data_buffer = buffer_create(16384,buffer_grow,1);

//내 플레이어 실제 id값 (게임 엔진 내에서의 id값)
my_instance_id = -4;

//클라이언트 object_id 저장용
global.client_num = ds_list_create();
ds_list_add(global.client_num, -1);
list_names = ds_list_create();
list_vals = ds_list_create();
list_types = ds_list_create();



cli_num = 0;
chat_buffer = buffer_create(2, buffer_grow, 1);


//자동으로 튕긴 사람 혹은 강제종료 한사람 감지후 내보내기
alarm[0] = global.tickrate*20;
//감지용 위치 저장 변수
global.saved_players_xx = [ -4 ];
global.saved_players_yy = [ -4 ];

//핑 계산용 변수
global.users_ping = [ -4 ];
//핑 표기용 변수
global.users_ping_display = [ -4 ];