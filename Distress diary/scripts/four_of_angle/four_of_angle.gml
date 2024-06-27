// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function four_of_angle(argument0)
{
	var tmp_angle = argument0;
	if (tmp_angle < 45 || tmp_angle >= 315)
	{
		return 0;
	}
	else if (tmp_angle >= 45 && tmp_angle < 135)
	{
		return 1;
	}
	else if (tmp_angle >= 135 && tmp_angle < 225)
	{
		return 2;
	}
	else
	{
		return 3;
	}
}