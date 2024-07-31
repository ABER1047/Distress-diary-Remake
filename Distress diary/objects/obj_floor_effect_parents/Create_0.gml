/// @description Insert description here
// You can write your code in this editor

//액체가 점점 생기는 애니메이션 재생
image_speed = 0;
animation_timer = 0;
alarm[0] = 1;

for(var i = 0; i < 3*image_xscale; i++)
{
	rd_xx[i] = -4;
	rd_yy[i] = -4;
	blood_scale[i] = 0;
}


//삭제 타이머
des_timer = 0;

