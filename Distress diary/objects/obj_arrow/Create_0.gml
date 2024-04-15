/// @description Insert description here
// You can write your code in this editor


image_speed = 0;
image_xscale = 2;
image_yscale = 2;




//화살 궤적 애니메이션
stop_animation = false;
animation_timer = 0;
if (global.graphics_quality > 0)
{
	for(var i = 0; i < 8; i++)
	{
		xx[i] = xstart;
		yy[i] = ystart;
	}
}


//화살 꽂힘 효과
is_on_mob = -4;
saved_xscale = -4;
angle_comp = 0;
comp_draw_yy = -4;
comp_draw_yy_check = false;


//화살을 발사한 인스턴스
//parents = -4;

//화살 데미지
//attack_dmg = 0;