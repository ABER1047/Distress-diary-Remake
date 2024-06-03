// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param w
///@param h
function surf_cre(argument0,argument1)
{
	if (variable_global_exists("surf_queue"))
	{
		var tmp_surf = surface_create(argument0,argument1);
		ds_list_add(global.surf_queue,tmp_surf);
		return tmp_surf;
	}
	else
	{
		//서피스 저장용 큐
		global.surf_queue = ds_list_create();
	}
}