// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param val
///@param [withoutMinus]
function valToStrWithPoint(argument0,argument1)
{
	var tmp_arg1 = (argument1 != undefined) ? argument1 : false;
	var tmp_val = (tmp_arg1) ? fix_to_zero(argument0) : argument0;
	if (tmp_val != infinity)
	{
		return (floor(tmp_val) == tmp_val) ? string(tmp_val)+".00" : tmp_val;
	}	
	else
	{
		return "--";
	}
}