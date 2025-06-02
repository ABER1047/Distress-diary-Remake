/// @description Insert description here
// You can write your code in this editor

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();


//이미지 관련 기본 세팅
image_xscale = 2.5;
image_yscale = 2.5;
image_speed = 0;

//블럭 밀기 시스템
pushing_animation = false;
pushing_timer = 0;
origin_xx = xstart;
origin_yy = ystart;
draw_xx = 0;
draw_yy = 0;
pusher = -4;


//인터렉션 가능한지 여부
is_interactable = false;
