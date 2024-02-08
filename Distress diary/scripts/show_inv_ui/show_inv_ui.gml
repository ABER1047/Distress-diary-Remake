// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param x
///@param y
///@param inv_name
///@param variable_owner

function show_inv_ui(argument0,argument1,argument2,argument3)
{
	//인벤토리 관련 변수를 가진 인스턴스 (= variable_owner) 가 존재하는 경우
	var tmp_owner = argument3;
	if (instance_exists(tmp_owner))
	{
		var tmp_ins = instance_create_depth(-999,-999,-999,obj_inv_ui);
		tmp_ins.x_pos = argument0;
		tmp_ins.y_pos = argument1;
		tmp_ins.inv_name = argument2;
		tmp_ins.variable_owner = tmp_owner;
		
		for(var i = 0; i < tmp_owner.inv_height; i++)
		{
			for(var ii = 0; ii < tmp_owner.inv_width; ii++)
			{
				if (sprite_exists(tmp_owner.inv_info_spr_ind[i][ii]))
				{
					create_inv_item(tmp_owner.inv_info_spr_ind[i][ii],tmp_owner.inv_info_img_ind[i][ii],tmp_owner.inv_info_name[i][ii],tmp_owner.inv_info_stack_num[i][ii],tmp_owner.inv_info_max_stack_num[i][ii],tmp_ins,ii,i);
				}
			}
		}
		
		return tmp_ins;
	}
	else
	{
		return false;
	}
}