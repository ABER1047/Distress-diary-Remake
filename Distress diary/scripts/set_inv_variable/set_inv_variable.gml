// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param inv_width[ii]
///@param inv_height[i]
///@param spr_ind
///@param img_ind
///@param name
///@param stack_num
///@param max_stack_num
function set_inv_variable(argument0,argument1,argument2,argument3,argument4,argument5,argument6)
{
	var i = argument1;
	var ii = argument0;
	
	inv_info_spr_ind[i][ii] = argument2;
	inv_info_img_ind[i][ii] = argument3;
	inv_info_name[i][ii] = argument4;
	inv_info_stack_num[i][ii] = argument5;
	inv_info_max_stack_num[i][ii] = argument6;
}