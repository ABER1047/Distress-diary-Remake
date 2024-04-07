/// @description Insert description here
// You can write your code in this editor
var s_x = camera_get_view_x(view_camera[0])
var s_y = camera_get_view_y(view_camera[0])
var s_w = camera_get_view_width(view_camera[0])
var s_h = camera_get_view_height(view_camera[0])
var c_x = global.n_camera_zoom*4;

if (chat_alpha > 0)
{
	draw_set_color(c_black);
	draw_set_alpha(chat_alpha*0.7)
	draw_rectangle(s_x, s_y+s_h, s_x+c_x*450, s_y+s_h-c_x*340, false)
	if (global.chat_activated == 1)
	{
		draw_text_kl_scale(s_x+c_x*16,s_y+s_h-c_x*64,string(chat_entering)+"|",64,9999,chat_alpha,c_white,0,-1,font_normal,c_x*0.2,c_x*0.2,0)
	}

	for(var i = 0; i < 10; i++) 
	{
		draw_text_kl_scale(s_x+c_x*16,s_y+s_h-c_x*(100+i*24),global.chat[i+global.chating_scroll],64,9999,chat_alpha,c_white,0,-1,font_normal,c_x*0.2,c_x*0.2,0)
	}
	
	
	var tmp_scroll_ypos = s_y+s_h-((global.chating_scroll/global.max_chat_stack*330) + 48)*c_x;
	draw_set_color(c_white);
	draw_set_alpha((global.chat_scroll_alpha > 0.8) ? 0.8 : global.chat_scroll_alpha);
	draw_rectangle(s_x+c_x*440,tmp_scroll_ypos,s_x+c_x*450,tmp_scroll_ypos+c_x*10,false);
}