// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param spr_ind
///@param img_ind
function get_rare_rate(argument0,argument1)
{
	var tmp_spr = argument0, tmp_img = argument1;
	var tmp_value = set_item_info_values(tmp_spr,tmp_img,true);
	if (tmp_value[7] < 10)
	{
		return 0;
	}
	else if (tmp_value[7] < 15)
	{
		return 1;
	}
	else if (tmp_value[7] < 28)
	{
		return 2;
	}
	else
	{
		return 3;
	}
}