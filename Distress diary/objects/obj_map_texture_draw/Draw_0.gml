/// @description Insert description here
// You can write your code in this editor
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);



//현재 불러와진 룸 그리기
var tmp_room_xx = room_width*0.5;
var tmp_room_yy = room_height*0.5;
var tmp_wall_scale = 2;
var tmp_wall_sprite_size = tmp_wall_scale*48;
var n_wall_type = global.n_room_tileset;

for(var i = 0; i < global.n_room_width; i++)
{
	for(var ii = 0; ii < global.n_room_height; ii++)
	{
		//바닥 타일 그리기
		draw_sprite_ext(spr_tiles,n_wall_type,tmp_room_xx+(-global.n_room_width*0.5+i)*tmp_wall_sprite_size,y+(ii+0.5)*tmp_wall_sprite_size,tmp_wall_scale,tmp_wall_scale,0,c_white,1);
		
		//타일 깨진 효과
		if (rd_tile_break_ef[i][ii] >= 0)
		{
			draw_sprite_ext(spr_tiles_breaks,rd_tile_break_ef[i][ii],tmp_room_xx+(-global.n_room_width*0.5+i)*tmp_wall_sprite_size,y+(ii+0.5)*tmp_wall_sprite_size,tmp_wall_scale,tmp_wall_scale,rd_tile_break_ef_ang[i][ii],c_white,0.35);
		}
		
		//타일 이끼 효과
		if (rd_tile_moss_ef[i][ii] >= 0)
		{
			draw_sprite_ext(spr_tiles_grass,rd_tile_moss_ef[i][ii],tmp_room_xx+(-global.n_room_width*0.5+i)*tmp_wall_sprite_size,y+(ii+0.5)*tmp_wall_sprite_size,tmp_wall_scale,tmp_wall_scale,rd_tile_moss_ef_ang[i][ii],c_white,1);
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



//혈흔 이펙트 그리기
surface_set_target(global.blood_surf);
draw_clear_alpha(c_black,0);

	with(obj_blood_effect)
	{
		if (id != other.id)
		{
			for(var i = 0; i < array_length(rd_xx); i++)
			{
				var tmp_xx = rd_xx[i];
				var tmp_yy = rd_yy[i];
				var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
		
				//10초 뒤에 알파값이 점점 작아지면서 삭제
				var tmp_scale = 0.5/(1+tmp_dis/24);
		
		
				//가장 가까운 혈흔부터 순차적으로 드로우 (= 혈흔가 바닥에 고여서 흐르는 효과)
				if (animation_timer > tmp_dis*0.7)
				{
					blood_scale[i] += (tmp_scale - blood_scale[i])*0.1;
				}
				draw_sprite_ext(spr_circle,0,tmp_xx-xx,tmp_yy-yy,blood_scale[i],blood_scale[i]*0.42,0,c_white,image_alpha);
			}
		}
	}
surface_reset_target();


var dx = [ 0, -3, 0, 3 ];
var dy = [ -3, 0, 3, 0 ];
for(var i = 0; i < 4; i++)
{
	draw_surface_ext(global.blood_surf,xx+dx[i],yy+dy[i],1,1,0,#17111A,1);
}	

draw_surface_ext(global.blood_surf,xx,yy,1,1,0,#7A213A,1);





//모든 그림자 그리기
surface_set_target(global.shadow_surf);
gpu_set_blendmode(bm_normal);
draw_clear_alpha(c_black,0);
draw_sprite_ext(spr_tiles_walls,1,tmp_room_xx-xx,y-yy,tmp_wall_scale*global.n_room_width*1.2,-tmp_wall_scale*0.85,image_angle,c_white,1);
with(obj_wall_nearby_door)
{
	draw_sprite_ext(spr_tiles_walls,1,x-xx,y-yy,tmp_wall_scale,-tmp_wall_scale*0.85,image_angle,c_white,1);
}

with(obj_parents)
{
	draw_sprite_ext(sprite_index,image_index,x-xx,y-yy,image_xscale,-image_yscale*0.85,image_angle,c_white,1);
}

with(obj_mob_parents)
{
	draw_sprite_ext(spr_shadow,0,x-xx,y-yy,image_xscale,image_yscale,0,c_white,1);
}

with(obj_dropped_item)
{
	draw_sprite_ext(sprite_index,image_index,x-xx,y-yy,image_xscale,-image_yscale*0.85,image_angle,c_white,1)
}
surface_reset_target();



draw_surface_ext(global.shadow_surf,xx,yy,1,1,0,c_black,0.3);



