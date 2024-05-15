/// @description Insert description here
// You can write your code in this editor

//이미지 점점 축소
image_xscale += (-0.01 - image_xscale)*des_speed;
image_yscale += (-0.01 - image_yscale)*des_speed;

if (image_xscale <= 0 || image_index > 6)
{
	instance_destroy();
}


//색 변화
color_shift += des_speed*(image_speed+1);
image_blend = merge_color(col1,col2,(color_shift > 1) ? 1 : color_shift);


//이동 속도 감소
hspeed += (0 - hspeed)*speed_to_zero;
vspeed += (0 - vspeed)*speed_to_zero;

