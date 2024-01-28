/// @description Insert description here
// You can write your code in this editor
randomize();
depth = -102;

//디버그 용
global.show_map_data = -1;
global.dev_mode = 1;
global.show_wall_hitbox = -1;
show_debug_log(global.dev_mode);


//랜덤 이름 생성
global.nickname = randomized_nickname();

//내 플레이어 아이디
global.my_player_id = 0;

//obj_id 배정용 변수
global.object_id_ind = 0;

//플레이어 전용 obj_id_player_only 배정용 변수
global.object_id_player_only = 0;

//틱레이트
global.tickrate = 5;



//플레이어 스킨
global.player_skin_num = 3;
global.player_skin = irandom_range(0,global.player_skin_num-1);

//플레이어 착용중인 백팩
global.backpack_num = 8; //백팩 장착 없음까지 포함해서 8종
global.n_backpack = 0;

//새로운 플레이어 오면 1로 변함
global.new_player_joined = 0;



//맵 정보 선언 (초기화)
global.is_map_exists = -4;//맵이 생성되었는지 아닌지 체크 = 얘가 -4면 생성 안된거임
global.map_arr = -4;
global.map_width = 0;
global.map_height = 0;
global.map_start_pos_xx = 0;
global.map_start_pos_yy = 0;
global.max_room_width = 0;
global.max_room_height = 0;
global.min_room_width = 0;
global.min_room_height = 0;
global.map_room_width = -4;
global.map_room_height = -4;
global.room_connected_to_xx = -4;
global.room_connected_to_yy = -4;
global.room_connected_to_xx_sec = -4;
global.room_connected_to_yy_sec = -4;
global.room_connection_percentage = 0;
global.max_root_length = 0;
global.max_room_num = 0;
global.n_room_num = 0;
global.map_creation_falied = 0;
outter_room_surf = surface_create(4000,3000);



//현재 모든 플레이어 위치 (룸) [인덱스는 플레이어 obj_id 값을 의미함]
global.n_player_room_xx = [ -4, -4, -4, -4, -4, -4 ];
global.n_player_room_yy = [ -4, -4, -4, -4, -4, -4 ];


//현재 불러온 룸 정보
global.n_room_width = 0;
global.n_room_height = 0;




//인벤토리 시스템
inv_width = 4;
inv_height = 6;
global.showing_inv = -4;
for(var i = 0; i < inv_height; i++)
{
	for(var ii = 0; ii < inv_width; ii++)
	{
		//inv_info_spr_ind가
		//-4일때 = 비어있음
		//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
		inv_info_spr_ind[i][ii] = -4;//spr_ind값 보유
		
		
		inv_info_img_ind[i][ii] = -4;//img_ind값 보유
		inv_info_name[i][ii] = -4;//아이템의 이름 값 보유
		inv_info_stack_num[i][ii] = -4;//아이템의 갯수 값 보유
	}
}

inv_info_spr_ind[3][3] = spr_stackables;
inv_info_img_ind[3][3] = 0;
inv_info_name[3][3] = "Coin";
inv_info_stack_num[3][3] = 1;