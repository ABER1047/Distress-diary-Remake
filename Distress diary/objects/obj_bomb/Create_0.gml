/// @description Insert description here
// You can write your code in this editor

//기본 이미지 세팅
image_speed = 0;
image_xscale = 2;
image_yscale = 2;
image_alpha = 1;

//z축 추가
add_z_axis();

//속도 관련 변수
add_speed_valuables();

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();

//네트워크상으로 위치 전송하기 위한 용도
alarm[1] = 1;

//네트워크상으로 속도 전송하기 위한 용도
alarm[2] = 1;

//image_alpha값이랑 똑같은데 draw_sprite에서만 드로우 되지 않게 해주는 alpha값
draw_alpha = 1;

//멀티플레이 용 버퍼
command_buffer = buffer_create(1024,buffer_grow,1);



//폭탄 터지는 타이머
timer = 0;

//사운드 이펙트 타이머
timer_sfx = 0;

//폭탄 흰색 깜빡이는 효과
w_alpha = 0;
