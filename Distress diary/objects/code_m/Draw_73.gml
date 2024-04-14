/// @description Insert description here
// You can write your code in this editor
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);

var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);
var c_x = global.n_camera_zoom*4;
var text_size = power(1+global.n_camera_zoom,2);


if (surface_exists(global.text_surf) && chat_alpha > 0)
{
	//채팅창 뒷 배경
	draw_set_color(c_black);
	draw_set_alpha(chat_alpha*0.7);
	draw_rectangle(xx+xx_w,yy+yy_h,xx+xx_w-c_x*450,yy+yy_h-c_x*280, false);
	
	//채팅 글씨
	var tmp_text_xx = xx+xx_w-c_x*442;
	if (global.chat_activated)
	{
		draw_text_kl_scale(tmp_text_xx,yy+yy_h-c_x*64,string(chat_entering)+"|",64,9999,chat_alpha,c_white,0,-1,font_normal,text_size*0.2,text_size*0.2,0);
	}


	//채팅 한번에 몰아서 출력하기 (최적화)
	var tmp_chat_to_draw = "";
	for(var i = 0; i < 10; i++) 
	{
		tmp_chat_to_draw = string(global.chat[i+global.chating_scroll])+"\n"+string(tmp_chat_to_draw);
	}
	draw_text_kl_scale(tmp_text_xx,yy+yy_h-c_x*280,tmp_chat_to_draw,64,9999,chat_alpha,c_white,0,-1,font_normal,text_size*0.2,text_size*0.2,0);
	
	
	
	//채팅창 스크롤 바
	var tmp_scroll_ypos = yy+yy_h-((global.chating_scroll/global.max_chat_stack*270) + 48)*c_x;
	draw_set_color(c_white);
	draw_set_alpha((global.chat_scroll_alpha > 0.8) ? 0.8 : global.chat_scroll_alpha);
	draw_rectangle(xx+xx_w-c_x*8,tmp_scroll_ypos,xx+xx_w,tmp_scroll_ypos+c_x*10,false);
}