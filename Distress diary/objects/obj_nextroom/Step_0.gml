/// @description Insert description here
// You can write your code in this editor
depth = obj_map_texture_draw.depth-32;

//화살표 애니메이션
var tmp_my_p = global.my_player_ins_id[global.my_player_id];
if (point_distance(tmp_my_p.x,tmp_my_p.y,x,y) < 480)
{
	arrow_animation_yy += (0 - arrow_animation_yy)*0.1;
	arrow_animation_timer ++;
	
	if (arrow_animation_timer >= 90)
	{
		arrow_animation_yy = 128;
		arrow_animation_timer = 0;
	}
}
else
{
	arrow_animation_yy = 0;
	arrow_animation_timer = 90;
}



if (surface_exists(door_surf))
{
	var n_xx = global.n_player_room_xx[global.my_player_id];
	var n_yy = global.n_player_room_yy[global.my_player_id];
	var tmp_xx = [ 1, 0, -1, 0 ];
	var tmp_yy = [ 0, -1, 0, 1 ];
	var t_xx = n_xx+tmp_xx[tp_to];
	var t_yy = n_yy+tmp_yy[tp_to];
	if (global.map_arr[n_yy][n_xx] <= 2 && global.map_arr[t_yy][t_xx] <= 2 && global.map_arr[n_yy][n_xx] >= 1 && global.map_arr[t_yy][t_xx] >= 1)
	{
		door_yy += (116 - door_yy)*0.06;
		
		if (door_yy > 64)
		{
			can_use_tp = true;
		}
	}
	else
	{
		if (door_yy > 0)
		{
			door_yy -= 6;
		}
		else 
		{
			door_yy = 0;
		}
		
		can_use_tp = false;
	}
	
	var n_wall_type = global.n_room_tileset;
	var xx = camera_get_view_x(view_camera[0]);
	var yy = camera_get_view_y(view_camera[0]);
	surface_set_target(door_surf);
	draw_clear_alpha(c_black,0);
	draw_sprite_ext(sprite_index,3+n_wall_type*3,20,52-door_yy,1,1,0,merge_color(c_white,c_black,0.3),sign(image_alpha));
	surface_reset_target();
}
else
{
	door_surf = surface_create(128,116);
}