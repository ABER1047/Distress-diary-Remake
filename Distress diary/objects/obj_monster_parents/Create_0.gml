/// @description Insert description here
// You can write your code in this editor
image_speed = 0;
image_xscale = 2;
image_yscale = 2;

//z축
add_z_axis();

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();


//속도 관련 변수
_speed = 0;
_vspeed = 0;
_hspeed = 0;


//멀티플레이용 틱레이트 포지션
tickrate_x = x;
tickrate_y = y;
tickrate_z = z;

//이미지 정보 보내기 (멀티플레이)
alarm[1] = 1;


//image_alpha값이랑 똑같은데 draw_sprite에서만 드로우 되지 않게 해주는 alpha값
draw_alpha = 1;


//멀티플레이 용 버퍼
command_buffer = buffer_create(1024,buffer_grow,1);


//체력
set_monster_hp_variable(id);


//타겟팅 된 플레이어
targeted = -4;
b_targeted = -4;

//공격력
attack_dmg = 15;

//데미지 애니메이션 관련 변수
dmg_cooltime = 0;



//버프/디버프 효과 적용 (효과 순서는 이미지 순서대로)
for(var i = 0; i < sprite_get_number(spr_buff_ui); i++)
{
	buff_left_time[i] = 0; //남은 버프 시간
}
buff_applied_index = -4;


//적 트래킹
tracking_timer = 0;
tracking_dir = 0;


//임시 변수 (각 몹마다 적절하게 사용)
tmp_value1 = 0;
tmp_value2 = 0;


//공격 사이클 타이머
attack_timer = 0;


//버블 이펙트 외곽선 효과용 오브젝트
bubble_ef_ins = -4;