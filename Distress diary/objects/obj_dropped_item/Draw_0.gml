/// @description Insert description here
// You can write your code in this editor


var tmp_scale = image_xscale*0.5;
var tmp_yy = y-(16*image_yscale);

if (global.graphics_quality >= 1)
{
	var tmp_scale_outline = tmp_scale+(1/8*image_xscale);
	//흰색 테두리 그리기
	shader_set(shFlash);
	draw_sprite_ext(sprite_index,image_index,x,tmp_yy-z-cos(floating_animation)*16,tmp_scale_outline,tmp_scale_outline,image_angle,image_blend,image_alpha);
	shader_reset();
}


//내 자신 그리기
draw_sprite_ext(sprite_index,image_index,x,tmp_yy-z-cos(floating_animation)*16,tmp_scale,tmp_scale,image_angle,image_blend,image_alpha);

