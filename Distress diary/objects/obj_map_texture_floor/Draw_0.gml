/// @description Insert description here
// You can write your code in this editor
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);
var v_w = camera_get_view_width(view_camera[0]);
var v_h = camera_get_view_height(view_camera[0]);



//룸 바깥쪽 가림막 그리기
var tmp_room_xx = room_width*0.5;
var tmp_room_yy = room_height*0.5;
var tmp_wall_scale = 2;
var tmp_wall_sprite_size = tmp_wall_scale*48;
var n_wall_type = global.n_room_tileset;


//현재 불러와진 룸 그리기
for(var i = 0; i < global.n_room_width; i++)
{
	for(var ii = 0; ii < global.n_room_height; ii++)
	{
		//타일 깨진 효과
		if (global.graphics_quality > 0)
		{
			if (rd_tile_break_ef[i][ii] >= 0)
			{
				draw_sprite_ext(spr_tiles_breaks,rd_tile_break_ef[i][ii],tmp_room_xx+(-global.n_room_width*0.5+i)*tmp_wall_sprite_size,y+(ii+0.5)*tmp_wall_sprite_size,tmp_wall_scale,tmp_wall_scale,rd_tile_break_ef_ang[i][ii],c_white,0.35);
			}
		
			//타일 이끼 효과
			if (global.graphics_quality > 1 && rd_tile_other_ef[i][ii] >= 0)
			{
				draw_sprite_ext(spr_tiles_other_effects,rd_tile_other_ef[i][ii],tmp_room_xx+(-global.n_room_width*0.5+i)*tmp_wall_sprite_size,y+(ii+0.5)*tmp_wall_sprite_size,tmp_wall_scale,tmp_wall_scale,rd_tile_other_ef_ang[i][ii],c_white,1);
			}
		}
	}
	
	
	//위쪽 벽 그리기
	var tmp_spr_ind = n_wall_type*9+1;
	if (i == 0)
	{
		tmp_spr_ind -= 1;
	}
	else if (i == global.n_room_width-1)
	{
		tmp_spr_ind += 1;
	}
	var tmp_xx = tmp_room_xx+(-global.n_room_width*0.5+i)*tmp_wall_sprite_size;
	draw_sprite_ext(spr_tiles_walls,tmp_spr_ind,tmp_xx,y,tmp_wall_scale,tmp_wall_scale,0,c_white,1);
}


//폭발 자국 그리기
with(obj_explosion_effect_on_ground)
{
	if (id != other.id && global.n_player_room_xx[global.my_player_id] == my_pos_xx && global.n_player_room_yy[global.my_player_id] == my_pos_yy)
	{
		for(var i = 0; i < 11; i++)
		{
			var tmp_xx = x+rd_xx[i];
			var tmp_yy = y+rd_yy[i];
			var tmp_scale = (1-point_distance(x,y,tmp_xx,tmp_yy)/320);
			draw_sprite_ext(spr_circle,0,tmp_xx,tmp_yy,tmp_scale*image_xscale,tmp_scale*0.48*image_xscale,0,#1A171C,tmp_scale*0.08);
		}
	}
}





