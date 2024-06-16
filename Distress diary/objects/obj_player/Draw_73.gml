/// @description Insert description here
// You can write your code in this editor


//인터렉션 키 드로우 용
if (draw_alpha > 0)
{
	var tmp_yy = y-(90*global.reversed_ratio_by_camera+z);
	//인터렉션 키 드로우 용
	if (show_interaction_key > 0)
	{
		//인터렉션 이름 드로우
		var txt_scale = 0.25;
		var str_width = string_width(interaction_name_for_draw)*global.reversed_ratio_by_camera;
		draw_text_kl_scale(x-str_width*txt_scale*0.5,tmp_yy,string(interaction_name_for_draw),64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0,true);
	
		//인테렉션 원형 게이지 바 드로우
		var tmp_key_xx = x-str_width*txt_scale;
		var tmp_key_yy = tmp_yy+128*txt_scale*global.reversed_ratio_by_camera;
	
		if (global.interaction_hold_time > 0 && global.interaction_hold_time < global.interaction_hold_time_max)
		{
			draw_circular_bar(tmp_key_xx+2*txt_scale*global.reversed_ratio_by_camera,tmp_key_yy-4*global.reversed_ratio_by_camera,global.interaction_hold_time,global.interaction_hold_time_max,c_white,12*global.reversed_ratio_by_camera,1,6*global.reversed_ratio_by_camera,#17111A);
		}
	
		//인터렉션 키 드로우
		draw_sprite_ext(spr_key_ui,interaction_key_real_ind_for_draw,tmp_key_xx,tmp_key_yy,txt_scale*global.reversed_ratio_by_camera*1.5,txt_scale*global.reversed_ratio_by_camera*1.5,0,c_white,1);
	}
	else
	{
		draw_text_k_scale(x,tmp_yy,string(nickname),64,-1,1,c_white,0,0,font_normal,0.275,0.275,0,true);
		if (global.show_wall_hitbox)
		{
			draw_text_k_scale(x,y+32/global.h_ratio_by_window,"obj_id : "+string(obj_id)+"\nobj_id_player_only : "+string(obj_id_player_only),64,-1,1,c_white,0,0,font_normal,0.3,0.3,0);
		}
	}
}