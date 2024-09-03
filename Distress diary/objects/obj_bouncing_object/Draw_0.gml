/// @description Insert description here
// You can write your code in this editor



if (sprite_exists(sprite_index))
{
	//토치인 경우 불꽃 애니메이션 재생
	if (sprite_index == spr_animated_torch || sprite_index == spr_animated_soul_torch || sprite_index == spr_animated_demon_torch)
	{
		draw_sprite_ext(sprite_index,light_timer*0.125,x,y-z,image_xscale*0.75,image_yscale*0.75,image_angle-45,image_blend,image_alpha);
	}
	else
	{
		draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	}
}


