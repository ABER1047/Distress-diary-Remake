/// @description Insert description here
// You can write your code in this editor
if (!hide_cursor && !tmp_check)
{
	var tmp_ins = interacion_ins_exists;
	if (instance_exists(tmp_ins))
	{
		x = tmp_ins.x;
		y = tmp_ins.y;
		
		var dx = [ -4, 0, 4, 0 ];
		var dy = [ 0, -4, 0, 4 ];
		shader_set(shFlash);
		var tmp_yy = (tmp_ins.object_index != obj_dropped_item_box && tmp_ins.object_index != obj_player) ? tmp_ins.y-24 : tmp_ins.y;
		for(var i = 0; i < 4; i++)
		{
			draw_sprite_ext(tmp_ins.sprite_index,tmp_ins.image_index,tmp_ins.x+dx[i],tmp_yy+dy[i],tmp_ins.image_xscale,tmp_ins.image_yscale,0,c_white,1);
		}
		shader_reset();
	}
	else
	{
		draw_self();
	}
}

//조준점 그리기
if (global.attack_type == 4)
{
	var tmp_my_p = global.my_player_ins_id[global.my_player_id];
	if (instance_exists(tmp_my_p))
	{
		var tmp_charging_gage = tmp_my_p.gage_bar_charged;
		if (tmp_charging_gage > 0)
		{
			var aim_dir = point_direction(tmp_my_p.x,tmp_my_p.y,mouse_x,mouse_y);
			var tmp_cal_accurate = (2-tmp_charging_gage)*(150-global.accurate)*0.15;
			var line_lenght = 320;
			var tmp_angles = [ aim_dir+tmp_cal_accurate, aim_dir-tmp_cal_accurate ];
			//var tmp_dir_xx = [ lengthdir_x(line_lenght,tmp_angles[0]), lengthdir_x(line_lenght,tmp_angles[1]) ];
			//var tmp_dir_yy = [ lengthdir_y(line_lenght,tmp_angles[0]), lengthdir_y(line_lenght,tmp_angles[1]) ];
			//draw_set_alpha(tmp_charging_gage*0.5);
			var tmp_draw_yy = tmp_my_p.y-tmp_my_p.z-32;
			for(var i = 0; i < 2; i++)
			{
				draw_sprite_ext(spr_crosshair,0,tmp_my_p.x,tmp_draw_yy,5,0.5,tmp_angles[i],c_white,tmp_charging_gage*0.5);
				//draw_line_width(tmp_my_p.x,tmp_draw_yy,tmp_my_p.x+tmp_dir_xx[i],tmp_draw_yy+tmp_dir_yy[i],2);
			}
		}
	}
}