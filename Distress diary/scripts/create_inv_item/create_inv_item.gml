// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param spr_ind
///@param img_ind
///@param stack_num
///@param parents_id[inv_ui_ins]
///@param x_pos
///@param y_pos
///@param width
///@param height
///@param rotated
///@param searched
///@param StarTag
function create_inv_item(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10)
{
	var tmp_parents_id = argument3;
	
	var tmp_get_item_info = set_item_info_values(argument0,argument1,false,argument10);
	var tmp_ins = instance_create_depth(-999,-999,tmp_parents_id.depth-10,obj_inv_item);
	tmp_ins.sprite_index = argument0;
	tmp_ins.image_index = argument1;
	tmp_ins.item_name = tmp_get_item_info;
	tmp_ins.item_name_compressed = global.short_name;
	tmp_ins.stack_num = argument2;
	tmp_ins.max_stack_num = global.item_max_stack_num;
	tmp_ins.parents_id = tmp_parents_id;
	tmp_ins.x_pos = argument4;
	tmp_ins.y_pos = argument5;
	tmp_ins.item_width = argument6;
	tmp_ins.item_height = argument7;
	tmp_ins.item_rotated = argument8;
	tmp_ins.item_weight = global.item_weight;
	tmp_ins.item_searched = argument9;
	tmp_ins.item_value = global.item_value;
	tmp_ins.startag = argument10;
	tmp_ins.item_desc = global.item_description;
	tmp_ins.item_effect_desc = global.item_ef_desc;
	tmp_ins.item_name_translated = global.item_translated_name;

	return tmp_ins;
}