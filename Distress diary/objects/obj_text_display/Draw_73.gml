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

var tmp_yy = y-text_yy*64*global.reversed_ratio_by_camera;
if (sprite_exists(sprite_index))
{
	draw_sprite_ext(sprite_index,image_index,x,tmp_yy,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}
else
{
	draw_text_kl_scale(x,tmp_yy,text,64,-1,image_alpha,image_blend,0,0,font_normal,0.3,0.3,0,true);
}