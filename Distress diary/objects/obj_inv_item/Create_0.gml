/// @description Insert description here
// You can write your code in this editor

image_alpha = 0;
image_speed = 0;


//부모 인벤토리 인스턴스 아이디
//parents_id = -4;

//아이템 위치 (n칸)
//x_pos = 0;
//y_pos = 0;

origin_img = -4;
origin_stack_num = -4;
origin_item_width = -4;
origin_item_height = -4;
origin_item_rorated = -4;
origin_item_searched = -4;
origin_startag = -4;

if (!variable_instance_exists(id,"moving_now"))
{
	//아이템 위에 마우스 올려둠
	mouse_on = 0;
	//아이템 위치 옮기는 중
	moving_now = 0;
}
moving_item_x_pos = 0;
moving_item_y_pos = 0;
is_moving_item_outside = 0;
moving_item_rotation = 0;


tmp_n_camera_zoom = 0;

//옮기려는 위치가 옮기기 가능한 자리인지 체크
is_moveable_pos = -4;


//아이템 가로 길이
//item_width = 1;

//아이템 세로 길이
//item_height = 1;

//아이템 회전 유무
//item_rotated = 0;

//아이템 무게
//item_weight = 0;

//아이템 서치됨
//item_searched = 0;

//아이템 갯수
//stack_num = -4;

//아이템 이름 (번역명)
//item_name_translated = "";

//아이템 설명
//item_desc = "";

//아이템 효과
//item_effect_desc = "";

//아이템 스프라이트 인덱스
//sprite_index = -4;

//아이템 레어도
//rare_rate = 0;

//스타 태그
//startag = 0;

//아이템 정보창 표기 시간
item_info_window_timer = 0;

//아이템 정보창 표기
show_item_info = false;

