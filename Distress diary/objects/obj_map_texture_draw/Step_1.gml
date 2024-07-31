/// @description Insert description here
// You can write your code in this editor
var tmp_room_xx = room_width*0.5;
var tmp_room_yy = room_height*0.5;
var tmp_wall_scale = 2;
var tmp_wall_sprite_size = tmp_wall_scale*48;
var n_wall_type = global.n_room_tileset;

y = tmp_room_yy-global.n_room_height*0.5*tmp_wall_sprite_size-8;
depth = -floor(y);


global.water_effect_timer += 0.0005;
global.water_effect_xx = cos(global.water_effect_timer)*128;
global.water_effect_yy = sin(global.water_effect_timer)*128;



//모든 그림자 그리기
if (surface_exists(global.shadow_surf))
{
	var xx = camera_get_view_x(view_camera[0]);
	var yy = camera_get_view_y(view_camera[0]);
	
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
		if (!stop_cal_by_pos_statement && object_index != obj_spike_trap && object_index != obj_cliff)
		{
			draw_sprite_ext(sprite_index,image_index,x-xx,y-72-yy,image_xscale,-image_yscale*0.85,image_angle,c_white,1);
		}
	}

	with(obj_mob_parents)
	{
		if (!stop_cal_by_pos_statement)
		{
			draw_sprite_ext(spr_shadow,0,x-xx,y-yy,2,2,0,c_white,1);
		}
	}
	
	with(obj_projectile_parents)
	{
		if (!stop_cal_by_pos_statement && ((object_index == obj_projectile && !stop_animation) || object_index != obj_projectile))
		{
			draw_sprite_ext(spr_shadow,0,x-xx,y-yy,2,2,0,c_white,1);
		}
	}

	with(obj_dropped_item_box)
	{
		if (!stop_cal_by_pos_statement)
		{
			draw_sprite_ext(sprite_index,image_index,x-xx,y-yy,image_xscale,-image_yscale*0.85,image_angle,c_white,1)
		}
	}
	surface_reset_target();
}