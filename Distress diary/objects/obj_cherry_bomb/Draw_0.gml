/// @description Insert description here
// You can write your code in this editor


//폭탄 그리기
draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,draw_alpha*image_alpha);

//폭탄 흰색 깜빡이는 효과
if (w_alpha > 0)
{
	shader_set(shFlash);
	draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,c_white,w_alpha*draw_alpha*image_alpha);
	shader_reset();
}