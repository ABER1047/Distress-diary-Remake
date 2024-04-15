/// @description Insert description here
// You can write your code in this editor
image_speed = 0;
image_xscale = 2;
image_yscale = 2;

//z축
add_z_axis();


//멀티플레이용 틱레이트 포지션
tickrate_x = x;
tickrate_y = y;
tickrate_z = z;

//이미지 정보 보내기 (멀티플레이)
alarm[1] = 1;


//애니메이션
floating_yy = -32;
idle_animation = 0;


//image_alpha값이랑 똑같은데 draw_sprite에서만 드로우 되지 않게 해주는 alpha값
draw_alpha = 1;


//멀티플레이 용 버퍼
command_buffer = buffer_create(1024,buffer_grow,1);


//체력
hp = 100;
max_hp = 100;


//버블 이펙트 외곽선 효과용 오브젝트
bubble_ef_ins = instance_create_depth(x,y,0,tmp_bubble_outline_effect);
bubble_ef_ins.parent_id = id;


//타겟팅 된 플레이어
targeted = -4;


//공격력
attack_dmg = 15;

//데미지 애니메이션 관련 변수
dmg_cooltime = 0;