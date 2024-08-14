/// @description Insert description here
// You can write your code in this editor


//바닥 타일 그리기
if (global.n_room_width > 0)
{
	var lay_id = layer_get_id("Background");
	var back_id = layer_background_get_id(lay_id);
	var tmp_spr = asset_get_index("spr_tileset_"+string(global.n_room_tileset));
	var tmp_choose = choose(0,24);
	layer_background_change(back_id, tmp_spr);
	layer_background_xscale(back_id,2);
	layer_background_yscale(back_id,2);
	layer_x(lay_id,(global.n_room_width%2 != 0) ? 30 : 0);
	layer_y(lay_id,(global.n_room_height%2 == 0) ? 24 : 32);
}




//랜덤한 바닥 타일 디자인
for(var i = 0; i < global.n_room_width; i++)
{
	for(var ii = 0; ii < global.n_room_height; ii++)
	{
		var tmp_other_ef_max_ind = 9, tmp_other_ef_min_ind = 0, tmp_other_ef_draw_chance = percentage_k(7);
		if (global.n_room_tileset == 1)
		{
			tmp_other_ef_min_ind = 6;
			tmp_other_ef_max_ind = 13;
			tmp_other_ef_draw_chance = percentage_k(3);
		}
		else if (global.n_room_tileset == 2)
		{
			tmp_other_ef_min_ind = 6;
			tmp_other_ef_draw_chance = percentage_k(6);
		}
		else if (global.n_room_tileset == 3)
		{
			tmp_other_ef_min_ind = 14;
			tmp_other_ef_max_ind = 17;
		}
		rd_tile_break_ef[i][ii] = irandom_range(-8,4); //타일 바닥 깨진 효과
		rd_tile_break_ef_ang[i][ii] = irandom_range(0,3)*90; //타일 바닥 깨진 효과 각도
		rd_tile_other_ef[i][ii] = (tmp_other_ef_draw_chance) ? irandom_range(tmp_other_ef_min_ind,tmp_other_ef_max_ind) : -4; //타일 바닥 잡다한 이미지 효과
		rd_tile_other_ef_ang[i][ii] = (rd_tile_other_ef[i][ii] != 6) ? irandom_range(0,3)*90 : 0; //타일 바닥 잡다한 이미지 효과 각도
	}
}

