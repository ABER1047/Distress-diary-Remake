// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param val
///@param [fixToZero]
///@param [absoluteValue]
///@param [doNotShouZero]
function valToStrWithPoint(argument0,argument1,argument2,argument3)
{
	var tmp_arg1 = (argument1 != undefined) ? argument1 : false;
	var tmp_arg2 = (argument2 != undefined) ? argument2 : false;
	var tmp_arg3 = (argument3 != undefined) ? argument3 : false;
	var tmp_val = (tmp_arg1) ? fix_to_zero(argument0) : ((tmp_arg2) ? abs(argument0) : argument0);
	if (tmp_val != infinity && (!tmp_arg3 || tmp_val != 0))
	{
		return (floor(tmp_val) == tmp_val) ? string(tmp_val)+".00" : tmp_val;
	}	
	else
	{
		return "--";
	}
}