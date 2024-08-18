/// @description Insert description here
// You can write your code in this editor

if (sprite_exists(sprite_index) && sprite_index != spr_none)
{
	var tmp_scale = image_xscale*0.5;
	var tmp_yy = y-(16*image_yscale) - z-cos(floating_animation)*16;

	if (global.graphics_quality >= 1)
	{
		var tmp_scale_outline = tmp_scale+(1/8*image_xscale);
		//흰색 테두리 그리기
		var dx = [ -4, 0, 4, 0 ];
		var dy = [ 0, -4, 0, 4 ];
		shader_set(shFlash);
		for(var i = 0; i < 4; i++)
		{
			draw_sprite_ext(sprite_index,image_index,x+dx[i],tmp_yy+dy[i],tmp_scale,tmp_scale,0,c_white,1);
		}
		shader_reset();
	}


	//내 자신 그리기
	draw_sprite_ext(sprite_index,image_index,x,tmp_yy,tmp_scale,tmp_scale,image_angle,image_blend,image_alpha);
}
