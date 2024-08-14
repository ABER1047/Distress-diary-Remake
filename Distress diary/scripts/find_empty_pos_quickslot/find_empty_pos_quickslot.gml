// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function find_empty_pos_quickslot()
{
	for(var i = 0; i < 9; i++)
	{
		if (global.quickslot_spr_ind[i] == -4)
		{
			return i;
		}
	}
	
	return -4;
}