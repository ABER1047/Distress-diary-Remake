/// @description Insert description here
// You can write your code in this editor



//화살 궤적 그리기
if (global.graphics_quality > 0 && _speed > 0)
{
	var tmp_xx = lengthdir_x(3,image_angle);
	var tmp_yy = lengthdir_y(3,image_angle);


	for(var i = 0; i < 8; i++)
	{
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_triangle(xx[i],yy[i],x-tmp_xx,y-tmp_yy-z,x+tmp_xx,y+tmp_yy-z,false);
	}
}



//나 자신 그리기
draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
