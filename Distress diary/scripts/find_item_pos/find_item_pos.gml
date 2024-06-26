// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param name[item]
///@param to_find_target[var_owner]
function find_item_pos(argument0,argument1)
{
	var tmp_variable_owner = argument1;
	if (instance_exists(tmp_variable_owner))
	{
		var tmp_inv_width = tmp_variable_owner.inv_width;
		var tmp_inv_height = tmp_variable_owner.inv_height;
		
		//아이템 관련 임시 변수
		var tmp_item_name = argument0;
	
		//인벤토리 전체 체크
		for(var i = 0; i < tmp_inv_height; i++) //height (y)
		{
			for(var ii = 0; ii < tmp_inv_width; ii++) //width (x)
			{			
				var tmp_spr_ind_real = tmp_variable_owner.inv_info_spr_ind[i][ii];
				if (tmp_spr_ind_real != -4 && tmp_item_name == tmp_variable_owner.inv_info_name[i][ii])
				{
					global.inv_empty_xpos = ii;
					global.inv_empty_ypos = i;
					return true;
				}
			}
		}
	}
	
	
	//모든 칸 끝까지 찾아봤는데 없는 경우, 자리를 저장하는 변수 초기화
	global.inv_empty_xpos = -4;
	global.inv_empty_ypos = -4;
	global.inv_empty_rotated = -4;
	return false;
}