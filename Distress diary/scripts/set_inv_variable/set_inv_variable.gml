// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param ins_id
///@param inv_width[ii]
///@param inv_height[i]
///@param spr_ind
///@param img_ind
///@param name
///@param stack_num
///@param max_stack_num
///@param width
///@param height
///@param rotated
function set_inv_variable(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10)
{
	var tmp_ins = argument0;
	var i = argument2;
	var ii = argument1;
	
	//회전 및 아이템 가로/세로 길이만큼 칸 차지하는 거 적용
	var visual_width = (argument10 == 0) ? argument8 : argument9;
	var visual_height = (argument10 == 0) ? argument9 : argument8;
	
	for(var k = 0; k < visual_height; k++)
	{
		for(var kk = 0; kk < visual_width; kk++)
		{
			//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
			tmp_ins.inv_info_spr_ind[i+k][ii+kk] = -3;
		}
	}
	
	tmp_ins.inv_info_spr_ind[i][ii] = argument3;
	tmp_ins.inv_info_img_ind[i][ii] = argument4;
	tmp_ins.inv_info_name[i][ii] = argument5;
	tmp_ins.inv_info_stack_num[i][ii] = argument6;
	tmp_ins.inv_info_max_stack_num[i][ii] = argument7;
	tmp_ins.inv_info_width[i][ii] = argument8; //아이템 가로 길이
	tmp_ins.inv_info_height[i][ii] = argument9; //아이템 세로 길이
	tmp_ins.inv_info_rotated[i][ii] = argument10; //아이템 회전 유무
}