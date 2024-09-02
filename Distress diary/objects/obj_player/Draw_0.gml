/// @description Insert description here
// You can write your code in this editor

if (draw_alpha > 0)
{
	var tmp_chk = (my_n_dir == 0 || my_n_dir == 2);
	var tmp_chk2 = (my_n_dir != 3);
	var tmp_alpha = draw_alpha*image_alpha;
	

	//들고 있는 아이템 이미지 그리기
	if (sprite_exists(holding_item_spr_ind) && tmp_chk && tmp_chk2)
	{
		var tmp_signed_xscale = -sign(image_xscale);
		var tmp_xpos = [ 44, 52, 44, 36 ];
		var tmp_ypos = [ 36, 44, 36, 44 ];
		var tmp_cal_xx = lengthdir_x(tmp_signed_xscale*tmp_xpos[image_index],holding_item_angle);
		var tmp_cal_yy = -tmp_ypos[image_index]+lengthdir_y(tmp_signed_xscale*tmp_xpos[image_index],holding_item_angle);
		draw_sprite_ext(holding_item_spr_ind,holding_item_img_ind,x+tmp_cal_xx,y-z+tmp_cal_yy,tmp_signed_xscale*1.5,1.5,holding_item_angle,c_white,1);
	}

	//백팩 그리기
	if (my_backpack != 0 && tmp_chk && tmp_chk2)
	{
		var tmp_spr = asset_get_index("spr_original_bp"+string(my_backpack));
		
		draw_sprite_ext(tmp_spr,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha);
	}
	
	//플레이어 그리기
	draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha);
	
	

	
	
	//백팩 그리기
	if (my_backpack != 0 && !tmp_chk && tmp_chk2)
	{
		var tmp_spr = asset_get_index("spr_original_bp"+string(my_backpack)+"_1");
		
		draw_sprite_ext(tmp_spr,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha);
	}
	
	
}


