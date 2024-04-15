/// @description Insert description here
// You can write your code in this editor



//화살 궤적 그리기
if (global.graphics_quality > 0 && !stop_animation)
{
	var tmp_xx = lengthdir_x(3,image_angle);
	var tmp_yy = lengthdir_y(3,image_angle);


	for(var i = 0; i < 8; i++)
	{
		draw_set_color(c_white);
		draw_set_alpha(0.1);
		draw_triangle(xx[i],yy[i],x-tmp_xx,y-tmp_yy,x+tmp_xx,y+tmp_yy,false);
	}
}



//나 자신 그리기
draw_self();

