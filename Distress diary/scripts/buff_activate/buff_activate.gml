// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param index
///@param duration
function buff_activate(argument0,argument1)
{
	var tmp_ind = argument0, tmp_duration = argument1;
	if (global.buff_left_time[tmp_ind] < tmp_duration)
	{
		global.buff_left_time[tmp_ind] = tmp_duration;
		global.buff_max_left_time[tmp_ind] = max(global.buff_left_time[tmp_ind],global.buff_max_left_time[tmp_ind]);
	}
	else if (tmp_duration == 0)
	{
		global.buff_left_time[tmp_ind] = 0;
		global.buff_max_left_time[tmp_ind] = 1;
	}
	
	
	return true;
}