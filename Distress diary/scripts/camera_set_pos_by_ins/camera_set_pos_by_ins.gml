// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param id
function camera_set_pos_by_ins(argument0)
{
	var tmp_id = argument0;
	if (instance_exists(tmp_id))
	{
		global.camera_target = tmp_id;
		return tmp_id;
	}
	else
	{
		return -4;
	}
}