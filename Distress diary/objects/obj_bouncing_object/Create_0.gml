/// @description Insert description here
// You can write your code in this editor

//이미지 애니메이션 제거
image_speed = 0;
image_angle = irandom_range(0,359);



//z축
//z = 0;
//zspeed = 0;
zgravity = 0;
zspeed_timer = 0;


//최대 바운스 횟수 제한용
bounce_stack = 0.8;


//삭제 시간
des_timer = 0;
//t_des_time = 0;

//토치 애니메이션 전용
light_scale = 0.3;
light_alpha = 0.3;
light_timer = 0;


//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();
