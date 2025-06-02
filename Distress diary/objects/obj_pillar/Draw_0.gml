/// @description Insert description here
// You can write your code in this editor

//오브젝트 그리기
if (image_alpha > 0)
{
	var tmp_y = y-24;
	draw_sprite_ext(sprite_index,image_index,x,tmp_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	
	if (global.show_wall_hitbox)
	{
		if (point_distance(x,tmp_y,mouse_x,mouse_y) < 64)
		{
			draw_set_color(c_white);
			draw_set_alpha(1);
			draw_text(x,tmp_y,string(my_pos_xx)+", "+string(my_pos_yy));
		}
	}
}

