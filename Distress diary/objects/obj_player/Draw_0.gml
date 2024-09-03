/// @description Insert description here
// You can write your code in this editor

if (draw_alpha > 0)
{
	var tmp_chk = (my_n_dir == 0 || my_n_dir == 2);
	var tmp_chk2 = (my_n_dir != 3);
	var tmp_alpha = draw_alpha*image_alpha;
	

	//들고 있는 아이템 이미지 그리기
	var tmp_item_spr_ind = holding_item_spr_ind;
	//show_debug_message(tmp_item_spr_ind);
	var tmp_item_img_ind = (tmp_item_spr_ind != spr_animated_torch && tmp_item_spr_ind != spr_animated_soul_torch && tmp_item_spr_ind != spr_animated_demon_torch) ? holding_item_img_ind : light_timer*0.125;
	if (sprite_exists(tmp_item_spr_ind))
	{
		var tmp_signed_xscale = -sign(image_xscale);
		var tmp_yscale = 1.5;
		if (tmp_chk2)
		{
			if (tmp_chk)
			{
				//좌-우
				var tmp_angle = holding_item_angle;
				var tmp_xpos = [ 44, 52, 44, 36 ];
				var tmp_ypos = [ 36, 52, 36, 48 ];
				var tmp_cal_xx = x+lengthdir_x(tmp_signed_xscale*tmp_xpos[image_index],tmp_angle);
				var tmp_cal_yy = y-z+lengthdir_y(tmp_signed_xscale*tmp_xpos[image_index],tmp_angle)-tmp_ypos[image_index];
			}
			else
			{
				//상
				tmp_signed_xscale = 1;
				var tmp_angle = -holding_item_angle+45;
				var tmp_xpos = [ 24, 22, 24, 28 ];
				var tmp_ypos = [ 42, 50, 42, 54 ];
				var tmp_cal_xx = x+lengthdir_x(tmp_xpos[image_index],tmp_angle);
				var tmp_cal_yy = y-z+lengthdir_y(20,tmp_angle)-tmp_ypos[image_index];
			}
			
			draw_sprite_ext(tmp_item_spr_ind,tmp_item_img_ind,tmp_cal_xx,tmp_cal_yy,tmp_signed_xscale*1.5,tmp_yscale,tmp_angle,c_white,1);
		}
	}

	//백팩 그리기
	if (my_backpack != 0 && tmp_chk && tmp_chk2)
	{
		var tmp_spr = asset_get_index("spr_original_bp"+string(my_backpack));
		
		draw_sprite_ext(tmp_spr,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha);
	}
	
	//플레이어 그리기
	draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha);
	
	
	if (sprite_exists(tmp_item_spr_ind))
	{
		if (!tmp_chk2)
		{
			//하
			tmp_signed_xscale = -1;
			var tmp_xpos = [ 32, 26, 32, 34 ];
			var tmp_ypos = [ 46, 62, 46, 58 ];
			var chk_is_attacking = (abs(holding_item_angle) < 5);
			var tmp_angle = (chk_is_attacking) ? holding_item_angle-30 : holding_item_angle+90;
			var tmp_cal_xx = x-lengthdir_x(tmp_xpos[image_index],tmp_angle) - (chk_is_attacking ? 0 : 32);
			var tmp_cal_yy = y-z+lengthdir_y(20,tmp_angle)-tmp_ypos[image_index] + (chk_is_attacking ? 0 : 68);
			draw_sprite_ext(tmp_item_spr_ind,tmp_item_img_ind,tmp_cal_xx,tmp_cal_yy,-1.5,1.5,tmp_angle,c_white,1);
		}
	}

	
	
	//백팩 그리기
	if (my_backpack != 0 && !tmp_chk && tmp_chk2)
	{
		var tmp_spr = asset_get_index("spr_original_bp"+string(my_backpack)+"_1");
		
		draw_sprite_ext(tmp_spr,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha);
	}
}


