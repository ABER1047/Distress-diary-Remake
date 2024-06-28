// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function valToStrWithPoint(argument0)
{
	var tmp_val = argument0;
	if (tmp_val != infinity)
	{
		return (floor(tmp_val) == tmp_val) ? string(tmp_val)+".00" : tmp_val;
	}	
	else
	{
		return "--";
	}
}