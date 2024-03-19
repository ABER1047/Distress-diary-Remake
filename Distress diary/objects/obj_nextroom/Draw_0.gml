/// @description Insert description here
// You can write your code in this editor

if (image_alpha > 0)
{
	//위로 올라가는 포탈인 경우 벽까지 그리기
	if (tp_to == 1)
	{
		var n_wall_type = 0;
		draw_sprite_ext(sprite_index,1+n_wall_type,x,y-16,image_xscale,image_yscale,0,image_blend,sign(image_alpha));
		
		if (global.show_wall_hitbox == 1)
		{
			draw_sprite_ext(spr_arrow_ui,0,x,y,image_xscale,image_yscale,90+90*tp_to,c_black,1);
		}
	}
	
	//내 자신 그리기
	draw_self();
}





