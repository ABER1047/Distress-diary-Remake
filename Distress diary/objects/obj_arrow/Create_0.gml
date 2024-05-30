/// @description Insert description here
// You can write your code in this editor


image_speed = 0;
image_xscale = 2;
image_yscale = 2;

//z축 적용
add_z_axis();


//화살 궤적 애니메이션
stop_animation = false;
animation_timer = 0;
if (global.graphics_quality > 0)
{
	event_user(0);
}
alarm[1] = 1;





//화살 꽂힘 효과
is_on_mob = -4;
saved_xscale = -4;
angle_comp = 0;
stop_flying = -4;


//화살을 발사한 인스턴스
//parents = -4;

//화살 데미지
//attack_dmg = 0;


//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();




