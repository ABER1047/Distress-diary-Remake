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
///@param StarTag
function create_inv_item(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11,argument12,argument13,argument14)
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
	tmp_ins.startag = argument14;

	//무기-장비류 아이템의 경우, 아이템 효과 설명 추가
	var tmp_str = string_split(set_status_by_weapon(argument0,argument1),",");
	if (tmp_str[1] != 0)
	{
		if (tmp_str[0] > 0)
		{
			if (tmp_str[5] == 3)
			{
				tmp_ins.item_effect_desc = string(tmp_str[0])+"-"+string(real(tmp_str[0])*3)+" 데미지\n";
			}
			else if (tmp_str[5] == 0)
			{
				tmp_ins.item_effect_desc = string(tmp_str[0])+"-"+string(real(tmp_str[0])*2)+" 데미지\n";
			}
			else
			{
				tmp_ins.item_effect_desc = string(tmp_str[0])+" 데미지\n";
			}
		}
		else
		{
			tmp_ins.item_effect_desc = string(abs(tmp_str[0]))+" 곡괭이 파워\n";
		}
		
		if (tmp_str[2] != 0)
		{
			tmp_ins.item_effect_desc = string(tmp_ins.item_effect_desc)+string(tmp_str[2])+"% 크리티컬 찬스\n";
		}
		
		if (tmp_str[3] != 0)
		{
			tmp_ins.item_effect_desc = string(tmp_ins.item_effect_desc)+string(tmp_str[3])+" 넉백\n";
		}
		
		if (tmp_str[6] != 0)
		{
			tmp_ins.item_effect_desc = string(tmp_ins.item_effect_desc)+string(tmp_str[6])+"% 정확도\n";
		}
	}
	
	
	
	show_debug_message("create_inv_item : "+string(argument3));

	return tmp_ins;
}