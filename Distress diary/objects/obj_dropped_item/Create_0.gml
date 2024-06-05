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


//멀티플레이 용 버퍼
command_buffer = buffer_create(1024,buffer_grow,1);

//아이템 떠다니는 애니메이션 효과
floating_animation = 0;

//아이템 획득 판정
touched = -4;