/// @description Insert description here
// You can write your code in this editor



//게이지 바 드로우
if (!stop_cal_by_pos_statement && skip_puzzle_timer > 0)
{
	//이름 드로우
	var interaction_name_for_draw = "포기하기";
	var tmp_yy = y-(128/global.h_ratio_by_window);
	var txt_scale = 0.64*global.n_camera_zoom;
	var str_width = string_width(interaction_name_for_draw)/global.w_ratio_by_window;
	draw_text_kl_scale(x-str_width*txt_scale*0.5,tmp_yy,string(interaction_name_for_draw),64,-1,image_alpha,c_white,0,-1,font_normal,txt_scale,txt_scale,0);
	
	//원형 게이지 바 드로우
	var tmp_key_xx = x-str_width*txt_scale;
	var tmp_key_yy = tmp_yy+128*txt_scale/global.h_ratio_by_window;
	
	if (skip_puzzle_timer > 0 && skip_puzzle_timer < 600)
	{
		draw_circular_bar(tmp_key_xx,tmp_key_yy-32*txt_scale/global.h_ratio_by_window,skip_puzzle_timer,600,c_white,72*txt_scale,1,24*txt_scale);
	}
	
	//아이콘 드로우
	draw_sprite_ext(spr_key_ui,6,tmp_key_xx,tmp_key_yy,txt_scale*2.5/global.w_ratio_by_window,txt_scale*2.5/global.h_ratio_by_window,0,c_white,image_alpha);
}
