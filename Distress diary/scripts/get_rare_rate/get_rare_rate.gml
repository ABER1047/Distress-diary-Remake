// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param item_obj_ins
///@param [item_name]
function get_rare_rate(argument0,argument1)
{
	var tmp_ins = argument0;
	var tmp_item_name = (argument1 == undefined) ? set_item_info_values(tmp_ins.sprite_index,tmp_ins.image_index) : argument1;
	
	var tmp_value = global.item_value;
	if (tmp_value < 10)
	{
		return 0;
	}
	else if (tmp_value < 15)
	{
		return 1;
	}
	else if (tmp_value < 28)
	{
		return 2;
	}
	else
	{
		return 3;
	}
}