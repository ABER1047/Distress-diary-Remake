/// @description Insert description here
// You can write your code in this editor


//애니메이션
animation ++;
text_yy += (1 - text_yy)*0.07;
if (animation > 90)
{
	image_alpha += (-0.01 - image_alpha)*0.1;
	if (image_alpha <= 0)
	{
		instance_destroy();
	}
}


draw_text_kl_scale(x,y-text_yy*64*global.reversed_ratio_by_camera,string(text),64,-1,image_alpha,image_blend,0,0,font_normal,0.3,0.3,0,true);