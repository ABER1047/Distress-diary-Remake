// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param surf
function surf_free(argument0)
{
	if (surface_exists(argument0))
	{
		var tmp_ind = ds_list_find_index(global.surf_queue,argument0);
		surface_free(argument0);
		if (tmp_ind != -1)
		{
			ds_list_delete(global.surf_queue,tmp_ind);
		}
	}
}