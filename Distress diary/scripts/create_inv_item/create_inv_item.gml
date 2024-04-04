// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param spr_ind
///@param img_ind
///@param item_name
///@param item_name[comp]
///@param stack_num
///@param max_stack_num
///@param parents_id[inv_ui_ins]
///@param x_pos
///@param y_pos
///@param width
///@param height
///@param rotated
///@param searched
function create_inv_item(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11,argument12,argument13)
{
	var tmp_parents_id = argument6;
	var tmp_item_name = argument2;
	
	var tmp_ins = instance_create_depth(-999,-999,tmp_parents_id.depth-10,obj_inv_item);
	tmp_ins.sprite_index = argument0;
	tmp_ins.image_index = argument1;
	tmp_ins.item_name = tmp_item_name;
	tmp_ins.item_name_compressed = argument3;
	tmp_ins.stack_num = argument4;
	tmp_ins.max_stack_num = argument5;
	tmp_ins.parents_id = tmp_parents_id;
	tmp_ins.x_pos = argument7;
	tmp_ins.y_pos = argument8;
	tmp_ins.item_width = argument9;
	tmp_ins.item_height = argument10;
	tmp_ins.item_rotated = argument11;
	tmp_ins.item_weight = argument12;
	tmp_ins.item_searched = argument13;
	tmp_ins.item_value = set_item_value(tmp_item_name,tmp_ins);
	
	
	show_debug_message("create_inv_item : "+string(argument3));

	return tmp_ins;
}