// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param spr_ind
///@param img_ind
///@param stack_num
function find_empty_pos_quickslot(argument0,argument1,argument2)
{
	var tmp_spr_ind = argument0, tmp_img_ind = argument1;
	for(var i = 0; i < 9; i++)
	{
		if (global.quickslot_spr_ind[i] == -4)
		{
			return [ i, argument2 ];
		}
		else if (global.quickslot_spr_ind[i] == tmp_spr_ind && global.quickslot_img_ind[i] == tmp_img_ind)
		{
			var tmp_item_info = set_item_info_values(tmp_spr_ind,tmp_img_ind,true);
			if (global.quickslot_stack_num[i]+argument2 <= tmp_item_info[2])
			{
				return [ i, global.quickslot_stack_num[i]+argument2 ];
			}
		}
	}
	
	return -4;
}