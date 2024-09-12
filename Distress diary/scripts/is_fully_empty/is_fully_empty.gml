// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param ins_id[inv_onwer]
function is_fully_empty(argument0)
{
	var chk = true;
	
	var tmp_ins = argument0;
	var tmp_inv_width = tmp_ins.inv_width, tmp_inv_height = tmp_ins.inv_height;
	for(var i = 0; i < tmp_inv_height; i++)
	{
		for(var ii = 0; ii < tmp_inv_width; ii++)
		{
			if (tmp_ins.inv_info_spr_ind[i][ii] >= 0)
			{
				chk = false;
				break;
				break;
			}
		}
	}
	
	return chk;
}