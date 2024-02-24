// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param spr_ind
///@param img_ind
///@param item_name
///@param stack_num
///@param max_stack_num
///@param parents_id[inv_ui_ins]
///@param x_pos
///@param y_pos
///@param width
///@param height
///@param rotated
function create_inv_item(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11)
{
	var tmp_parents_id = argument5;
	
	var tmp_ins = instance_create_depth(-999,-999,tmp_parents_id.depth-10,obj_inv_item);
	tmp_ins.sprite_index = argument0;
	tmp_ins.image_index = argument1;
	tmp_ins.item_name = argument2;
	tmp_ins.stack_num = argument3;
	tmp_ins.max_stack_num = argument4;
	tmp_ins.parents_id = tmp_parents_id;
	tmp_ins.x_pos = argument6;
	tmp_ins.y_pos = argument7;
	tmp_ins.item_width = argument8;
	tmp_ins.item_height = argument9;
	tmp_ins.item_rotated = argument10;
	tmp_ins.item_weight = argument11;

	return tmp_ins;
}