/// @description Insert description here
// You can write your code in this editor


if (global.display_view_of_mob)
{
	draw_set_alpha(0.7);
	draw_set_color(c_white);
	draw_line_width(x,y,x+lengthdir_x(128,direction),y+lengthdir_y(128,direction),3);
	
	draw_text(x,y+128,"_speed : "+string(_speed)+" / _vspeed : "+string(_vspeed)+" / _hspeed : "+string(_hspeed))
}