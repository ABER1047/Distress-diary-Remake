
if (global.show_wall_hitbox)
{
	draw_self();
	image_blend = merge_color(c_red,c_blue,count_connection/(max_reflection_num+1)*32);
}
else
{
	var tmp_dis = 4;
	var tmp_xdir = lengthdir_x(tmp_dis,image_angle);
	var tmp_ydir = lengthdir_y(tmp_dis,image_angle);
	var tmp_xx = x-tmp_xdir;
	var tmp_yy = y-tmp_ydir-z;
	var tmp_tx = tx+tmp_xdir;
	var tmp_ty = ty+tmp_ydir-z;

	//바깥쪽
	for(var i = 0; i < 16; i++)
	{
		draw_set_color(image_blend);
		draw_set_alpha(image_alpha/16);
		draw_line_width(tmp_xx,tmp_yy,tmp_tx,tmp_ty,image_yscale*(1+i*0.1));
	}



	//안쪽 
	draw_set_color(c_white);
	draw_set_alpha(image_alpha);
	draw_line_width(tmp_xx,tmp_yy,tmp_tx,tmp_ty,image_yscale*0.9);
}
