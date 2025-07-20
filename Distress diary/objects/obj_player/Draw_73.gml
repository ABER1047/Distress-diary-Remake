/// @description Insert description here
// You can write your code in this editor


//인터렉션 키 드로우 용
if (draw_alpha > 0)
{
	var is_this_my_player = (global.my_player_id == obj_id_player_only);
	var tmp_scale = global.reversed_ratio_by_camera;
	var tmp_yy = y-(90*tmp_scale+z);
	//인터렉션 키 드로우 용
	if (show_interaction_key > 0)
	{
		//인터렉션 이름 드로우
		var txt_scale = 0.25;
		var str_width = string_width(interaction_name_for_draw)*tmp_scale;
		draw_text_kl_scale(x-str_width*txt_scale*0.4,tmp_yy,string(interaction_name_for_draw),64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0,true);
	
		//인테렉션 원형 게이지 바 드로우
		var tmp_key_xx = x-str_width*txt_scale*0.7;
		var tmp_key_yy = tmp_yy+128*txt_scale*tmp_scale;
	
		if (global.interaction_hold_time > 0 && global.interaction_hold_time < global.interaction_hold_time_max)
		{
			draw_circular_bar(tmp_key_xx+2*txt_scale*tmp_scale,tmp_key_yy-4*tmp_scale,global.interaction_hold_time,global.interaction_hold_time_max,c_white,12*tmp_scale,1,6*tmp_scale,1,#17111A);
		}
	
		//인터렉션 키 드로우
		draw_sprite_ext(spr_key_ui,interaction_key_real_ind_for_draw,tmp_key_xx,tmp_key_yy,txt_scale*tmp_scale*1.5,txt_scale*tmp_scale*1.5,0,c_white,1);
	}
	else
	{
		//닉네임 드로우
		var tmp_nickname_color = (is_this_my_player) ? c_white : merge_color(global.chat_color_table[obj_id_player_only%5],c_white,floor(obj_id_player_only/5)*0.25);
		draw_text_k_scale(x,tmp_yy,string(nickname),64,-1,1,tmp_nickname_color,0,0,font_normal,0.275,0.275,0,true);
		if (global.show_wall_hitbox)
		{
			draw_text_k_scale(x,y+32/global.h_ratio_by_window,"obj_id : "+string(obj_id)+"\nobj_id_player_only : "+string(obj_id_player_only),64,-1,1,c_white,0,0,font_normal,0.3,0.3,0);
		}
	}
	
	//캐릭터가 본인의 캐릭터거나, 서버 자체를 열지 않은 경우
	if (((instance_exists(code_m) && code_m.server == -4) || is_this_my_player))
	{
		var tmp_ui_xx = x+32*tmp_scale, tmp_ui_yy = y-54*tmp_scale-z;
		var tmp_ui_scale = tmp_scale*0.7;
		if (gage_bar_charged > 0)
		{
			//공격 쿨타임 게이지바 드로우
			var tmp_col = merge_color(#DCFF70,#E14141,gage_bar_charged);
		
			//뒷 배경 그리기
			draw_sprite_ext(charging_gage_bar,0,tmp_ui_xx,tmp_ui_yy,tmp_ui_scale,tmp_ui_scale,0,#332439,1);
		
			//게이지 바 그리기
			draw_circular_bar(tmp_ui_xx,tmp_ui_yy,gage_bar_charged,1,tmp_col,10*tmp_scale,1,3.8*tmp_scale,2);
		
			//테두리 그리기
			draw_sprite_ext(charging_gage_bar,1,tmp_ui_xx,tmp_ui_yy,tmp_ui_scale,tmp_ui_scale,0,#332439,1);
			
			//차징 횟수 그리기
			if (global.charging_split > 1 && n_charging_num > 0)
			{
				draw_text_kl_scale(tmp_ui_xx,tmp_ui_yy-82/global.h_ratio_by_window,n_charging_num,64,-1,1,merge_color(#CB2E3A,#3898FF,n_charging_num/global.charging_split),0,0,font_normal_outline,0.25,0.25,0);
			}
		}
		
		if (global.gage_bar_shine_animation > 0)
		{
			var tmp_ui_scale_sec = tmp_ui_scale*(1.1-global.gage_bar_shine_animation*0.1);
			draw_sprite_ext(spr_explosion,(1-global.gage_bar_shine_animation)*8,tmp_ui_xx,tmp_ui_yy,tmp_ui_scale_sec,tmp_ui_scale_sec,0,c_white,global.gage_bar_shine_animation);
			global.gage_bar_shine_animation += (-0.01 - global.gage_bar_shine_animation)*0.1;
		}
	}
}





if (global.show_wall_hitbox)
{
	if (sprite_exists(mask_index))
	{
		draw_sprite_ext(mask_index,0,x,y,image_xscale,image_yscale,image_angle,c_white,0.2);
	}
}