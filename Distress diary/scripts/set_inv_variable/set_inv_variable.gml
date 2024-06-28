// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param ins_id
///@param x_pos[ii]
///@param y_pos[i]
///@param spr_ind
///@param img_ind
///@param stack_num
///@param rotated
///@param searched 
///@param StarTag
function set_inv_variable(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8)
{
	var item_rotated = argument6;
	var tmp_spr_ind = argument3;
	var tmp_img_ind = argument4;
	var item_name = set_item_info_values(tmp_spr_ind,tmp_img_ind);
	var tmp_item_width = global.item_width;
	var tmp_item_height = global.item_height;
	var tmp_startag = argument8;
	if (tmp_startag == undefined || tmp_startag < 0)
	{
		var tmp_rd_startag = irandom_range(1,100)-global.luck*5;
		if (tmp_rd_startag <= 1)
		{
			tmp_startag = 4;
		}
		else if (tmp_rd_startag <= 3)
		{
			tmp_startag = 3;
		}
		else if (tmp_rd_startag <= 10)
		{
			tmp_startag = 2;
		}
		else if (tmp_rd_startag <= 35)
		{
			tmp_startag = 1;
		}
		else
		{
			tmp_startag = 0;
		}
	}

	var tmp_ins = argument0;
	var i = argument2;
	var ii = argument1;
	
	//회전 및 아이템 가로/세로 길이만큼 칸 차지하는 거 적용
	var visual_width = (item_rotated == 0) ? tmp_item_width : tmp_item_height;
	var visual_height = (item_rotated == 0) ? tmp_item_height : tmp_item_width;
	

	
	with(tmp_ins)
	{
		if (id == tmp_ins)
		{
			for(var k = 0; k < visual_height; k++)
			{
				for(var kk = 0; kk < visual_width; kk++)
				{
					//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
					inv_info_spr_ind[i+k][ii+kk] = -3;
				}
			}
			
			inv_info_spr_ind[i][ii] = tmp_spr_ind;
			inv_info_img_ind[i][ii] = tmp_img_ind;
			inv_info_name[i][ii] = item_name;
			inv_info_name_compressed[i][ii] = global.short_name; //압축된 이름이 따로 없는 경우 기존 이름 그대로 사용
			inv_info_stack_num[i][ii] = argument5;
			inv_info_max_stack_num[i][ii] = global.item_max_stack_num;
			inv_info_width[i][ii] = tmp_item_width; //아이템 가로 길이
			inv_info_height[i][ii] = tmp_item_height; //아이템 세로 길이
			inv_info_rotated[i][ii] = item_rotated; //아이템 회전 유무
			inv_info_weight[i][ii] = global.item_weight; //아이템 무게
			inv_info_searched[i][ii] = argument7; //아이템 서치됨
			inv_info_startag[i][ii] = (global.item_max_stack_num == -4) ? tmp_startag : 0; //스타 태그 (스택이 가능한 아이템은 태그가 붙지 않음)
		}
	}
	
	//show_debug_message("set_inv_variable : "+string(tmp_ins)+" / "+string(tmp_ins.inv_info_name_compressed));
}