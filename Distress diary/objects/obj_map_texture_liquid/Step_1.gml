/// @description Insert description here
// You can write your code in this editor
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);


//깊이 설정
depth = obj_map_texture_floor.depth-1;


//바닥 액체 그리기
if (surface_exists(global.liquid_on_floor_surf))
{
	//반사 효과 적용
	if (global.graphics_quality > 0)
	{
		surface_set_target(global.reflection_surf);
		draw_clear_alpha(c_black,0);
		// you can add water reflection effect when you add certain objects as child on object_parents
		// all of object sprite x-offset, y-offset positions all must be center bottom of mask_index
		with(obj_wall_nearby_door)
		{
			var tmp_xx = x - xx;
			var tmp_yy = y - yy;
			draw_sprite_ext(sprite_index,image_index,tmp_xx,tmp_yy,image_xscale,-image_yscale,image_angle,image_blend,image_alpha);
		}
		
		with(obj_parents)
		{
			if (!stop_cal_by_pos_statement && object_index != obj_spike_trap && object_index != obj_cliff)
			{
				var tmp_xx = x - xx;
				var tmp_yy = y - yy;
				draw_sprite_ext(sprite_index,image_index,tmp_xx,tmp_yy,image_xscale,-image_yscale,image_angle,image_blend,image_alpha);
			}
		}
		
		with(obj_mob_parents)
		{
			if (!stop_cal_by_pos_statement)
			{
				var tmp_xx = x - xx;
				var tmp_yy = y+z - yy;
				draw_sprite_ext(sprite_index,image_index,tmp_xx,tmp_yy,image_xscale,-image_yscale,image_angle,image_blend,image_alpha);
			}
		}
		
		with(obj_bouncing_object)
		{
			if (sprite_exists(sprite_index))
			{
				var tmp_xx = x - xx;
				var tmp_yy = y+z - yy;
				draw_sprite_ext(sprite_index,image_index,tmp_xx,tmp_yy,image_xscale,-image_yscale,image_angle,image_blend,image_alpha);
			}
		}
		surface_reset_target();
	}
	
	
	
	//바닥 액체 서피스에 먼저 그리기
	surface_set_target(global.liquid_on_floor_surf);
	draw_clear_alpha(c_black,0);
	with(obj_floor_effect_parents)
	{
		if ((global.graphics_quality > 0 || object_index != obj_blood_effect) && id != other.id && object_index != obj_explosion_effect_on_ground && global.n_player_room_xx[global.my_player_id] == my_pos_xx && global.n_player_room_yy[global.my_player_id] == my_pos_yy)
		{
			var tmp_color = #7A213A;
			if (object_index == obj_poison_effect)
			{
				tmp_color = #44A978;
			}
			else if (object_index == obj_mucus_effect)
			{
				if (image_blend == #BD430B)
				{
					tmp_color = image_blend;
				}
				else
				{
					tmp_color = #16A700;
				}
			}
				
				
			for(var i = 0; i < array_length(rd_xx); i++)
			{
				var tmp_xx = rd_xx[i];
				var tmp_yy = rd_yy[i];
				//가장 가까운 액체부터 순차적으로 드로우 (= 바닥에 고여서 흐르는 효과)
				if (des_timer == 0)
				{
					var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
					if (animation_timer > tmp_dis*0.7)
					{
						var tmp_scale = (image_xscale*0.5)/(1+tmp_dis/24);
						blood_scale[i] += (tmp_scale - blood_scale[i])*0.1;
					}
				}
					

				draw_sprite_ext(spr_circle,0,tmp_xx-xx,tmp_yy-yy,blood_scale[i],blood_scale[i]*0.42,0,tmp_color,1);
			}
		}
	}
	surface_reset_target();
	
	
	//물 효과 적용
	surface_set_target(global.water_effect_surf);
	draw_clear_alpha(c_black,0);
		
	draw_surface(global.liquid_on_floor_surf,0,0);
	gpu_set_colorwriteenable(1, 1, 1, 0);
	draw_set_alpha(1);
	if (global.graphics_quality > 0)
	{
		draw_surface_ext(global.reflection_surf,0,0,1,1,0,c_white,0.05);
		draw_set_alpha(1);
	}
	gpu_set_colorwriteenable(1, 1, 1, 1);
	surface_reset_target();
}
