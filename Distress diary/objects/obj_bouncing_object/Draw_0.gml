/// @description Insert description here
// You can write your code in this editor



if (sprite_exists(sprite_index))
{
	draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	
	//토치인 경우 불꽃 애니메이션 재생
	if (sprite_index == spr_torch)
	{
		var tmp_spr_type = [ spr_fire_animation, spr_ghost_fire_animation, spr_demon_fire_animation ];
		var tmp_len = image_xscale*12;
		var tmp_xx = x+lengthdir_x(tmp_len,image_angle), tmp_yy = y-z+lengthdir_y(tmp_len,image_angle);
		draw_sprite_ext(tmp_spr_type[image_index],light_timer*0.175,tmp_xx,tmp_yy,image_xscale*0.7,image_xscale*0.75,image_angle-90,image_blend,image_alpha);
	}
}


