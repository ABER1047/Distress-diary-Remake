/// @description Insert description here
// You can write your code in this editor


//오브젝트 그리기
if (image_alpha > 0)
{
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	
	if (is_activated)
	{
		var tmp_fire_scale = fire_scale[image_index]*image_xscale;
		var fire_spr = [ spr_fire_animation, spr_ghost_fire_animation ];
		draw_sprite_ext(fire_spr[fire_type],light_timer*0.175,x,y-fire_yy[image_index],tmp_fire_scale,tmp_fire_scale,image_angle,image_blend,image_alpha);
	}
}




