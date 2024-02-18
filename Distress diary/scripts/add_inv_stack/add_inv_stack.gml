// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param id[ins_id]
function add_inv_stack(argument0)
{
	var tmp_val = global.stack_for_inv_id[0];
	global.stack_for_inv_id[0] = argument0;
	global.stack_for_inv_id[1] = tmp_val;
}