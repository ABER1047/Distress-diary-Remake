/// @description Insert description here
// You can write your code in this editor


//인터렉션 키 드로우 용
if (draw_alpha > 0)
{
	var tmp_yy = y-(192+z)/global.h_ratio_by_window;
	if (show_interaction_key > 0)
	{
		//인터렉션 이름 드로우
		var txt_scale = 0.64*global.n_camera_zoom;
		var str_width = string_width(interaction_name_for_draw)/global.w_ratio_by_window;
		draw_text_kl_scale(x-str_width*txt_scale*0.5,tmp_yy,string(interaction_name_for_draw),64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);
	
		//인테렉션 원형 게이지 바 드로우
		var tmp_key_xx = x-str_width*txt_scale;
		var tmp_key_yy = tmp_yy+128*txt_scale/global.h_ratio_by_window;
	
		if (global.interaction_hold_time > 0 && global.interaction_hold_time < global.interaction_hold_time_max)
		{
			draw_circular_bar(tmp_key_xx,tmp_key_yy-32*txt_scale/global.h_ratio_by_window,global.interaction_hold_time,global.interaction_hold_time_max,c_white,72*txt_scale,1,24*txt_scale,#17111A);
		}
	
		//인터렉션 키 드로우
		draw_sprite_ext(spr_key_ui,interaction_key_real_ind_for_draw,tmp_key_xx,tmp_key_yy,txt_scale*2.5/global.w_ratio_by_window,txt_scale*2.5/global.h_ratio_by_window,0,c_white,1);
	}
	else
	{
		draw_text_k_scale(x,tmp_yy,string(nickname),64,-1,1,c_white,0,0,font_normal,0.4,0.4,0);
		if (global.show_wall_hitbox)
		{
			draw_text_k_scale(x,y+32/global.h_ratio_by_window,"obj_id : "+string(obj_id)+"\nobj_id_player_only : "+string(obj_id_player_only),64,-1,1,c_white,0,0,font_normal,0.4,0.4,0);
		}
	}
}