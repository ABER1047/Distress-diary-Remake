// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function surf_free_all()
{
	while(ds_list_size(global.surf_queue) > 0)
	{
		var tmp_surf = ds_list_find_value(global.surf_queue, 0);
		if (surface_exists(tmp_surf))
		{
			ds_list_delete(global.surf_queue, 0);
			surf_free(tmp_surf);
		}
		
	}
	
	return global.surf_queue;
}