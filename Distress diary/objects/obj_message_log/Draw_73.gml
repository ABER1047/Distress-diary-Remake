/// @description Insert description here
// You can write your code in this editor
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);
var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);
var c_x = global.reversed_ratio_by_camera;

var tmp_yy = yy+yy_h-(64+real_pos*24)*c_x;


draw_text_k_scale(xx+xx_w-8*c_x,tmp_yy,text,64,-1,image_alpha,c_white,0,1,font_normal,0.3,0.3,0,true);



if (tmp_yy < yy-256 || global.chat_activated)
{
	instance_destroy();
}