// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param spr_ind
///@param img_ind
///@param item_name
///@param stack_num
///@param parents_id[inv_ui_ins]
///@param x_pos
///@param y_pos
function create_inv_item(argument0,argument1,argument2,argument3,argument4,argument5,argument6)
{
	var tmp_ins = instance_create_depth(-999,-999,argument4.depth-10,obj_inv_item);
	tmp_ins.sprite_index = argument0;
	tmp_ins.image_index = argument1;
	tmp_ins.item_name = argument2;
	tmp_ins.stack_num = argument3;
	tmp_ins.parents_id = argument4;
	tmp_ins.x_pos = argument5;
	tmp_ins.y_pos = argument6;
	
	return tmp_ins;
}