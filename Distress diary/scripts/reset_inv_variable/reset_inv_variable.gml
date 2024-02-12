// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@param inv_width[ii]
///@param inv_height[i]
function reset_inv_variable(argument0,argument1)
{
	//inv_info_spr_ind가
	//-4일때 = 비어있음
	//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
	inv_info_spr_ind[argument1][argument0] = -4;//spr_ind값 보유
		
		
	inv_info_img_ind[argument1][argument0] = -4;//img_ind값 보유
	inv_info_name[argument1][argument0] = -4;//아이템의 이름 값 보유
	inv_info_stack_num[argument1][argument0] = -4;//아이템의 갯수 값 보유
	inv_info_max_stack_num[argument1][argument0] = -4;//아이템의 최대 스택 갯수 값 보유
	
	return true;
}