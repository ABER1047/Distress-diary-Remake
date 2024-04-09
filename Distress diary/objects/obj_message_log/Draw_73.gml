/// @description Insert description here
// You can write your code in this editor
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);
var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);
var c_x = global.n_camera_zoom*4;

var tmp_yy = yy+yy_h-100-real_pos*48;


draw_text_k_scale(xx+xx_w-8*c_x,tmp_yy,string(text),64,-1,image_alpha,c_white,0,1,font_normal,0.5,0.5,0);



if (tmp_yy < yy-256 || global.chat_activated)
{
	instance_destroy();
}