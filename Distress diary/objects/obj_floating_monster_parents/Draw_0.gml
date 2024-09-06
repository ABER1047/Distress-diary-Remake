/// @description Insert description here
// You can write your code in this editor


if (draw_alpha > 0)
{
	//몬스터 그리기
	draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);

	//버프 아이콘 그리기
	var tmp_scale = global.ratio_by_camera*0.3;
	var tmp_xx = x+48, tmp_yy = y-z-96;
	var tmp_index = 0;
	for(var i = 0; i < sprite_get_number(spr_buff_ui) && tmp_index < 3; i++)
	{
		if (buff_left_time[i] > 0)
		{
			draw_sprite_ext(spr_buff_ui_without_bg,i,tmp_xx+(tmp_index*tmp_scale*48),tmp_yy,tmp_scale,tmp_scale,image_angle,image_blend,image_alpha);
			tmp_index ++;
		}
	}
}