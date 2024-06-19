// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param slot_index
///@param spr_ind
///@param img_ind
///@param stacks
function set_quickslot_variable(argument0,argument1,argument2,argument3)
{
	var tmp_ind = argument0;
	global.quickslot_spr_ind[tmp_ind] = argument1;//spr_ind값 보유
	global.quickslot_img_ind[tmp_ind] = argument2;//img_ind값 보유
	global.quickslot_stack_num[tmp_ind] = argument3;//아이템의 갯수 값 보유
	
	return tmp_ind;
}