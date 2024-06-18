// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function convert_to_time(argument0)
{
	if (argument0 <= 0)
	{
		return "00:00";
	}
	else
	{
		var tmp_min = floor(argument0/60);
		if (tmp_min < 10)
		{
			tmp_min = "0"+string(tmp_min);
		}
		var tmp_sec = (argument0%60);
		if (tmp_sec < 10)
		{
			tmp_sec = "0"+string(tmp_sec);
		}
		return string(tmp_min)+":"+string(tmp_sec);
	}
}