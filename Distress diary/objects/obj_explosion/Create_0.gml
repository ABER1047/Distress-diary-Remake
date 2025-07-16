/// @description Insert description here
// You can write your code in this editor
image_angle = 0;
direction = 0;

//멀티플레이 용 버퍼
command_buffer = buffer_create(1024,buffer_grow,1);


z = 0;
//my_pos_xx = -4;
//my_pos_yy = -4;


//폭발 범위
//image_xscale = 0;

//폭발 데미지 
//explo_dmg = 0;

//폭발 이펙트 생성 
create_explo_effect_timer = 0;

//효과 적용 
effect_applied = false;
alarm[1] = 1;

//이펙트 인스턴스 id 저장용 배열 
effect_ins_arr = -4;
effect_ins_arr_ind = 0;


//불 이펙트 생성 지속시간
fire_ef_timer = 0;


//버블 이펙트 외곽선 효과용 오브젝트
bubble_ef_ins = -4;