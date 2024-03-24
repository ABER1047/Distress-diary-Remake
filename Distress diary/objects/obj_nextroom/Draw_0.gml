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
	
	//화살표 그리기
	var tmp_dir = image_angle+270;
	var tmp_dis = (arrow_animation_yy/96);
	var tmp_scale = 0.6+tmp_dis*0.1;
	draw_sprite_ext(spr_arrow_ui,0,x+lengthdir_x(arrow_animation_yy,tmp_dir),y+lengthdir_y(arrow_animation_yy,tmp_dir),image_xscale*tmp_scale,image_yscale*tmp_scale,tmp_dir-90,c_white,image_alpha*tmp_dis);
}





