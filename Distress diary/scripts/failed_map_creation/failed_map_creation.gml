// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function failed_map_creation()
{
	reset_map_arraies();
	global.is_map_exists = -4;
	global.n_room_width = -4;
	global.n_room_height = -4;
	instance_destroy(obj_wall_parents);
	instance_destroy(obj_nextroom);
}