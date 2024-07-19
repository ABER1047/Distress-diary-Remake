/// @description Insert description here
// You can write your code in this editor

if (draw_alpha > 0)
{
	var tmp_alpha = draw_alpha*image_alpha;
	

	//백팩 그리기
	if ((my_n_dir == 0 || my_n_dir == 2) && my_n_dir != 3 && my_backpack != 0)
	{
		var tmp_spr = asset_get_index("spr_original_bp"+string(my_backpack));
		
		draw_sprite_ext(tmp_spr,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha);
	}
	
	//플레이어 그리기
	draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha);
	
	
	//백팩 그리기
	if (my_n_dir != 0 && my_n_dir != 2 && my_n_dir != 3 && my_backpack != 0)
	{
		var tmp_spr = asset_get_index("spr_original_bp"+string(my_backpack)+"_1");
		
		draw_sprite_ext(tmp_spr,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha);
	}
}


