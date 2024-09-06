// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param x
///@param y
///@param ins_id
function instance_nearest_by_pos(argument0,argument1,argument2)
{
	var tmp_nearest_dis = 9999, tmp_nearest_ins = -4;
	with(argument2)
	{
		if (!stop_cal_by_pos_statement)
		{
			var tmp_cal_dis = point_distance(argument0,argument1,x,y);
			if (tmp_nearest_dis > tmp_cal_dis)
			{
				tmp_nearest_dis = tmp_cal_dis;
				tmp_nearest_ins = id;
			}
		}
	}
	
	return tmp_nearest_ins;
}