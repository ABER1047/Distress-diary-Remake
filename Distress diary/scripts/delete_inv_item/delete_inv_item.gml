// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param inv_owner
///@param xpos
///@param ypos
///@param item_width
///@param item_height
///@param item_rotated
function delete_inv_item(argument0,argument1,argument2,argument3,argument4,argument5)
{
	var tmp_inv_owner = argument0;
	var visual_width = (argument5 == 0) ? argument3 : argument4;
	var visual_height = (argument5 == 0) ? argument4 : argument3;
	
	for(var k = 0; k < visual_height; k++)
	{
		for(var kk = 0; kk < visual_width; kk++)
		{
			//기존에 있던 아이템은 삭제(내부 변수 숫자값으로만)
			tmp_inv_owner.inv_info_spr_ind[argument2+k][argument1+kk] = -4; //아이템 삭제는 inv_info_spr_ind값만 -4로 해주면 됨
		}
	}
	
	return true;
}