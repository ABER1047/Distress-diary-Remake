/// @description Insert description here
// You can write your code in this editor

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();


//이미지 관련 기본 세팅
image_xscale = 2;
image_yscale = 2;
image_speed = 0;



//인터렉션 키 드로우 용
interaction_name_for_draw = "";
interaction_key_real_ind_for_draw = 0;
show_interaction_key = 0; // 0일때 드로우 안함



//인터렉션 가능한지 여부
is_interactable = true;



//오브젝트 애니메이션
obj_animation_timer = 0;
obj_animation = 0;


//상자 열린상태인지 체크
is_opened = -4; //-4 = 안 열림, -3 = 다른사람이 열고 있음, ins ref (숫자) = 내 자신이 열고 있으며 열려있는 인벤토리 id값을 반환
b_is_opened = -4;


//인터렉트 메세지
interaction_message = "상호작용";


//벤딩머신 사운드 이펙트
sfx = -4;
sfx_timer = 0;


//블럭 밀기 시스템
pushing_animation = false;
pushing_timer = 0;
origin_xx = xstart;
origin_yy = ystart;
draw_xx = 0;
draw_yy = 0;
pusher = -4;