/// @description Insert description here
// You can write your code in this editor


//인터렉션 키 드로우 용
if (show_interaction_key > 0)
{
	var tmp_yy = y-(90*global.reversed_ratio_by_camera);
	//인터렉션 이름 드로우
	var txt_scale = 0.25;
	var str_width = string_width(interaction_name_for_draw)*global.reversed_ratio_by_camera;
	draw_text_kl_scale(x-str_width*txt_scale*0.4,tmp_yy,interaction_name_for_draw,64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0,true);
	
	//인테렉션 원형 게이지 바 드로우
	var tmp_key_xx = x-str_width*txt_scale*0.7;
	var tmp_key_yy = tmp_yy+128*txt_scale*global.reversed_ratio_by_camera;
	
	if (global.interaction_hold_time > 0 && global.interaction_hold_time < global.interaction_hold_time_max)
	{
		draw_circular_bar(tmp_key_xx+2*txt_scale*global.reversed_ratio_by_camera,tmp_key_yy-4*global.reversed_ratio_by_camera,global.interaction_hold_time,global.interaction_hold_time_max,c_white,12*global.reversed_ratio_by_camera,1,6*global.reversed_ratio_by_camera,1,#17111A);
	}
	
	//인터렉션 키 드로우
	draw_sprite_ext(spr_key_ui,interaction_key_real_ind_for_draw,tmp_key_xx,tmp_key_yy,txt_scale*global.reversed_ratio_by_camera*1.5,txt_scale*global.reversed_ratio_by_camera*1.5,0,c_white,1);
}
