/// @description Insert description here
// You can write your code in this editor
randomize();
depth = -102;


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



//디버그 용
global.show_map_data = -1;
global.dev_mode = 1;
global.show_wall_hitbox = -1;
show_debug_log(global.dev_mode);
