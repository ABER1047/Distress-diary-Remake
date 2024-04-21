// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_my_pos_statement()
{
	my_pos_xx = global.n_player_room_xx[global.my_player_id];
	my_pos_yy = global.n_player_room_yy[global.my_player_id];
	origin_visible_statement = visible;
	origin_hitbox = mask_index;
	origin_x_axis = -4;
	origin_y_axis = -4;
	stop_cal_by_pos_statement = false;
}