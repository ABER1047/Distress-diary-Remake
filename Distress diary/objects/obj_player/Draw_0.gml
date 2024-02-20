/// @description Insert description here
// You can write your code in this editor

if (draw_alpha > 0)
{
	draw_sprite_ext(spr_shadow,0,x,y,image_xscale,image_yscale,0,c_white,draw_alpha*0.3);
	draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,draw_alpha);
	
	if (my_n_dir != 3 && my_backpack != 0)
	{
		var tmp_bp_ind = (my_n_dir == 0 || my_n_dir == 2) ? "" : "_1";
		var tmp_spr = asset_get_index("spr_original_bp"+string(my_backpack)+string(tmp_bp_ind));
		
		draw_sprite_ext(tmp_spr,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,draw_alpha);
	}



	//인터렉션 키 드로우 용
	if (show_interaction_key > 0)
	{
		//인터렉션 이름 드로우
		var txt_scale = 0.64*global.n_camera_zoom;
		var tmp_yy = y-192;
		draw_text_kl_scale(x-string_width(interaction_name_for_draw)*txt_scale*0.5,tmp_yy,string(interaction_name_for_draw),64,-1,image_alpha,c_white,0,-1,font_normal,txt_scale,txt_scale,0);
	
		//인터렉션 키 드로우
		draw_sprite_ext(spr_key_ui,interaction_key_real_ind_for_draw,x-string_width(interaction_name_for_draw)*txt_scale,tmp_yy+64*global.n_camera_zoom,txt_scale*2.5,txt_scale*2.5,0,c_white,image_alpha);
	}
	else
	{
		draw_text_k_scale(x,y-192,string(nickname)+"\n\n\n\n\nobj_id : "+string(obj_id)+"\nobj_id_player_only : "+string(obj_id_player_only),64,-1,image_alpha,c_white,0,0,font_normal,0.4,0.4,0);
	}
}