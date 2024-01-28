// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param target_x
///@param target_y
///@param x1
///@param y1
///@param x2
///@param y2
function is_inside_rectangle(argument0,argument1,argument2,argument3,argument4,argument5)
{
	if (argument0 > argument2 && argument0 < argument4 && argument1 > argument3 && argument1 < argument5)
	{
		return true;
	}
	else
	{
		return false;
	}
}