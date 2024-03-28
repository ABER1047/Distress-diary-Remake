/// @description Insert description here
// You can write your code in this editor

//그림자 그리기
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,-image_yscale*0.85,image_angle,c_black,0.3)


//오브젝트 그리기
var tmp_alpha = image_alpha-opening_animation;
if (tmp_alpha > 0)
{
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha)
}

if (opening_animation > 0)
{
	draw_sprite_ext(sprite_index,image_index+1,x,y,image_xscale,image_yscale,image_angle,image_blend,opening_animation)
}



//인터렉션 키 드로우 용
if (show_interaction_key > 0)
{
	//인터렉션 이름 드로우
	var tmp_yy = y-192/global.h_ratio_by_window;
	var txt_scale = 0.64*global.n_camera_zoom;
	var str_width = string_width(interaction_name_for_draw)/global.w_ratio_by_window;
	draw_text_kl_scale(x-str_width*txt_scale*0.5,tmp_yy,string(interaction_name_for_draw),64,-1,image_alpha,c_white,0,-1,font_normal,txt_scale,txt_scale,0);
	

	//인테렉션 원형 게이지 바 드로우
	var tmp_key_xx = x-str_width*txt_scale;
	var tmp_key_yy = tmp_yy+128*txt_scale/global.h_ratio_by_window;
	
	if (global.interaction_hold_time > 0 && global.interaction_hold_time < global.interaction_hold_time_max)
	{
		draw_circular_bar(tmp_key_xx,tmp_key_yy-32*txt_scale/global.h_ratio_by_window,global.interaction_hold_time,global.interaction_hold_time_max,c_white,72*txt_scale,1,24*txt_scale);
	}
	
	//인터렉션 키 드로우
	draw_sprite_ext(spr_key_ui,interaction_key_real_ind_for_draw,tmp_key_xx,tmp_key_yy,txt_scale*2.5/global.w_ratio_by_window,txt_scale*2.5/global.h_ratio_by_window,0,c_white,image_alpha);
}








