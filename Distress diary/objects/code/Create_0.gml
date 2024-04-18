/// @description Insert description here
// You can write your code in this editor
randomize();
event_user(1);
depth = -102;

//디버그 용
global.show_map_data = -1;
global.dev_mode = 1;
global.show_wall_hitbox = false;
show_debug_log(global.dev_mode);


//랜덤 이름 생성
global.nickname = randomized_nickname();

//내 플레이어 아이디
global.my_player_id = 0;

//플레이어 실제 인스턴스 아이디
global.my_player_ins_id = array_create(1,-4);

//obj_id 배정용 변수
global.object_id_ind = 1; //0번은 플레이어 나 자신

//플레이어 전용 obj_id_player_only 배정용 변수
global.object_id_player_only = 0;

//틱레이트
global.tickrate = 6;

//최대 핑 허용치 (허용치를 벗어난 핑은 그냥 내보내버림)
global.maximum_ping_acception = 256;



//플레이어 스킨
global.player_skin_num = 5;
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
global.create_only_one_enterance = false;


//벽 외부 서피스 생성
outter_room_surf = surface_create(3840,2160);

//라이트 서피스 생성
global.light_surf = surface_create(3840,2160);
global.flashlight_surf = surface_create(3840,2160);
global.enable_light_surf = false;
global.time_response_light = 1;

//쉐도우 서피스 생성
global.shadow_surf = surface_create(3840,2160);
global.enable_shadow_surf = true;


//플레시라이트 켜짐/꺼짐
global.enable_flashlight = false;


//현재 모든 플레이어 위치 (룸) [인덱스는 플레이어 obj_id 값을 의미함]
global.n_player_room_xx = [ -4, -4, -4, -4, -4, -4 ];
global.n_player_room_yy = [ -4, -4, -4, -4, -4, -4 ];


//현재 불러온 룸 정보
global.n_room_width = -4;
global.n_room_height = -4;

//현재 룸 타일 셋 정보
global.n_room_tileset = 0;




//인벤토리 시스템
global.showing_inv = -4;

//인벤토리 ui중 가장 낮은 depth를 가진 값을 저장하는 변수
global.min_depth = -999;


//인벤토리 빈칸 찾기용 변수
global.inv_empty_xpos = -4;
global.inv_empty_ypos = -4;
global.inv_empty_rotated = -4;


//인벤토리 아이템 옮기는 중
global.is_moving_item_now = -4;


//5초당 평균 프레임
fps_timer = 0;
global.average_fps_per_sec = 0;
global.average_fps_for_draw = 0;



//화면 사이즈에 따른 비율
global.w_ratio_by_window = 1;
global.h_ratio_by_window = 1;


//인터렉트 타이머 (몇 초 동안 홀드해야하는지)
global.interaction_hold_time = 0;
global.interaction_hold_time_max = 0;


//아이템 서칭 속도 (몇 프레임 후 아이템 하나가 서칭 완료되는지)
global.searching_time = 100;


//사운드 볼륨
global.master_volume = 1;
global.sfx_volume = 1;
global.bgm_volume = 1;


//낮-밤 시간대 (단위 : 분)
global.time = 60*8;
global.time_display = "";
global.time_increment = 100; //몇 프레임이 지나야 게임 시간의 1분이 흐르는지
global.time_increment_timer = 0;
global.time_is_day = true;


//바닥 액체 그리기용 서피스
global.liquid_on_floor_surf = surface_create(3840,2160);


//그래픽 퀄리티
global.graphics_quality = 2; // 2 == 최고품질 / 1 == 보통 / 0 == 최고 성능


//몹 시점 표시
global.display_view_of_mob = false;