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

	draw_text_kl_scale(x,y-192,string(nickname)+"\n\n\n\n\nsoc : "+string(soc)+"\nobj_id : "+string(obj_id),64,-1,image_alpha,c_white,0,0,font_normal,0.4,0.4,0);
}