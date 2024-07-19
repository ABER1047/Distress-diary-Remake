/// @description Insert description here
// You can write your code in this editor
randomize();
event_user(1);
depth = -102;

//디버그 용
global.show_map_data = -1;
global.dev_mode = 1;
global.show_wall_hitbox = false;
show_debug_overlay(global.dev_mode,true);


//랜덤 이름 생성
global.nickname = randomized_nickname(irandom_range(3,6));

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
global.player_skin_num = 6;
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

//add_my_pos_statement용 변수 (add_my_pos_statement를 사용하는 모든 오브젝트 인덱스 저장용)
global.add_my_pos_statement_obj_ind_list = [ "obj_mob_parents", "obj_parents", "obj_floor_button" ];
global.load_map_repeater = 0;


//새로운 방 방문 (= 플레이어가 적정 선 이상 이동시 방 문 닫기)
global.visited_new_room = false;
global.can_check_room_cleared = false;
global.f_pos_xx = -4; //처음 룸 방문시의 플레이어 x위치정보
global.f_pos_yy = -4; //처음 룸 방문시의 플레이어 y위치정보


//벽 외부 서피스 생성
global.outter_room_surf = surface_create(3840,2160);

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


//총 플레이 가능 인원수 (서버 포함)
global.maximum_player_num = 7;


//현재 모든 플레이어 위치 (룸) [인덱스는 플레이어 obj_id 값을 의미함]
for(var i = 0; i < global.maximum_player_num; i++)
{
	global.n_player_room_xx[i] = -4;
	global.n_player_room_yy[i] = -4;
}


//현재 불러온 룸 정보
global.n_room_width = -4;
global.n_room_height = -4;

//현재 룸 타일 셋 정보
global.n_room_tileset = 0;




//인벤토리 시스템
global.showing_inv = -4;

//인벤토리 ui중 가장 낮은 depth를 가진 값을 저장하는 변수
global.min_depth = -99999-64;


//인벤토리 빈칸 찾기용 변수
global.inv_empty_xpos = -4;
global.inv_empty_ypos = -4;
global.inv_empty_rotated = -4;

//아이템 이름 지정용 변수 (set_item_info_values 함수 리턴용)
global.short_name = -4;

//아이템 최대 스택 갯수 저장용 변수(set_item_info_values 함수 리턴용)
global.item_max_stack_num = -4;

//아이템 무게 저장용 변수(set_item_info_values 함수 리턴용)
global.item_weight = -4;

//아이템 가로 저장용 변수(set_item_info_values 함수 리턴용)
global.item_width = 1;

//아이템 세로 저장용 변수(set_item_info_values 함수 리턴용)
global.item_height = 1;


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


//사운드 볼륨
global.master_volume = 2;
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

//불꽃-스파크용 서피스
global.fire_line_surf = surface_create(3840,2160);


//그래픽 퀄리티
global.graphics_quality = 2; // 2 == 최고품질 / 1 == 보통 / 0 == 최고 성능


//몹 시점 표시
global.display_view_of_mob = false;


//맵 바깥 구역 막는 투명 벽
global.outside_of_map_wall = array_create(4,-4);


//지도용 서피스
global.map_ui_surf = -4;


//버프/디버프 효과 적용 (효과 순서는 이미지 순서대로)
for(var i = 0; i < sprite_get_number(spr_buff_ui); i++)
{
	global.buff_timer[i] = 0; //버프 주기 (출혈, 독데미지 등등...)
	global.buff_left_time[i] = 0; //남은 버프 시간
	global.buff_max_left_time[i] = 0; //남은 버프 시간
}


//플레이어 스테이터스
global.attack_damage = 3; //공격력
global.attack_speed = 20; //n프레임마다 공격 가능
global.defence_power = 0; //방어력 (n%데미지 감소)
global.knockback_power = 0; //넉백 파워
global.over_weight = 10; //과적 판정 kg수
global.max_hp = 100; //최대 체력
global.max_stamina = 100; //최대 스태미나
global.my_gold = 0; //내 보유 골드
global.hunger = 100; //배고픔
global.hydration = 100; //목마름
global.my_weight = 0; //내 무게
global.max_movement_speed = 0; //최대 이속
global.critical_chance = 0; //크리티컬 데미지 확률
global.critical_dmg_magnification = 0.5; //크리티컬 데미지 배율
global.luck = 0;
global.searching_speed = 100; //아이템 서칭 속도 (몇 프레임 후 아이템 하나가 서칭 완료되는지)


//퀵슬롯
global.quickslot_index = 0; //선택된 퀵 슬롯
for(var i = 0; i < 9; i++)
{
	global.quickslot_spr_ind[i] = -4;//spr_ind값 보유
	global.quickslot_img_ind[i] = -4;//img_ind값 보유
	global.quickslot_stack_num[i] = -4;//아이템 갯수
	global.quickslot_rare[i] = -4;//아이템의 가격에 따른 뒷 배경 색
	global.quickslot_startag[i] = -4;//아이템 스타태그
	global.quickslot_weight[i] = -4;//아이템 무게
}


//플레이어가 바라보는 방향을 마우스 방향으로 고정
global.fixed_dir = false;
global.b_fixed_dir = false;

//이동 관련 변수
global.movement_hspeed = 0;
global.movement_vspeed = 0;

//달리기 체크
global.n_running = false;

//이동키 안먹히도록 설정 (UI같은거 열려있을때)
global.prohibit_movement_input = false;

//방향 관련 변수
global.n_dir = 2; //*90하면 바라보는 각도 값 나옴

//공격 쿨타임
global.attack_cooldown_timer = 0;
global.gage_bar_shine_animation = 0; //쿨타임 게이지 바 번쩍거림 효과 애니메이션
global.automatic_attack_enable = false; //자동 공격

//카메라 타깃 설정
global.camera_target = -4;