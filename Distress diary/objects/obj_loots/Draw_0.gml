/// @description Insert description here
// You can write your code in this editor



//오브젝트 그리기
var tmp_alpha = image_alpha-opening_animation;
var tmp_y = y-24+draw_yy;
if (tmp_alpha > 0)
{
	draw_sprite_ext(sprite_index,image_index,x+draw_xx,tmp_y,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha)
}

if (opening_animation > 0)
{
	draw_sprite_ext(sprite_index,image_index+1,x,tmp_y,image_xscale,image_yscale,image_angle,image_blend,opening_animation)
}










