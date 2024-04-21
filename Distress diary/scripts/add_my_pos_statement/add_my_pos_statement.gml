// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_my_pos_statement()
{
	if (!variable_instance_exists(id,"my_pos_xx"))
	{
		my_pos_xx = -4;
		my_pos_yy = -4;
	}
	origin_visible_statement = visible;
	origin_hitbox = mask_index;
	origin_x_axis = -4;
	origin_y_axis = -4;
	stop_cal_by_pos_statement = false;
}