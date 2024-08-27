// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param x
///@param y
function comp_pos_grid(argument0,argument1)
{
	var tmp_xx = room_width*0.5+48+floor((argument0-room_width*0.5)/96)*96;
	var tmp_yy = room_height*0.5+floor((argument1-room_height*0.5)/96)*96;
	
	x = tmp_xx;
	y = tmp_yy;
}