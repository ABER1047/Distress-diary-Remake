// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param slot_index
///@param spr_ind
///@param img_ind
///@param stacks
///@param rare
///@param StarTag
///@param [weight]
function set_quickslot_variable(argument0,argument1,argument2,argument3,argument4,argument5,argument6)
{
	var tmp_ind = argument0;
	global.quickslot_spr_ind[tmp_ind] = argument1;//spr_ind값 보유
	global.quickslot_img_ind[tmp_ind] = argument2;//img_ind값 보유
	global.quickslot_stack_num[tmp_ind] = argument3;//아이템의 갯수 값 보유
	global.quickslot_rare[tmp_ind] = argument4; //아이템 가치에 의한 뒷 배경 색
	global.quickslot_startag[tmp_ind] = argument5; //스타 태그
	if (argument6 == undefined)
	{
		set_item_info_values(argument1,argument2);
		global.quickslot_weight[tmp_ind] = global.item_weight; //무게
	}
	else
	{
		global.quickslot_weight[tmp_ind] = argument6; //무게
	}
	return tmp_ind;
}