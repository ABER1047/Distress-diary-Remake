// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@param inv_width[ii]
///@param inv_height[i]
function reset_inv_variable(argument0,argument1)
{
	var i = argument0;
	var ii = argument1;
	
	//inv_info_spr_ind가
	//-4일때 = 비어있음
	//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
	inv_info_spr_ind[i][ii] = -4;//spr_ind값 보유
	inv_info_img_ind[i][ii] = -4;//img_ind값 보유
	inv_info_name[i][ii] = -4;//아이템의 이름 값 보유
	inv_info_name_compressed[i][ii] = -4;//아이템의 이름 값 보유
	inv_info_stack_num[i][ii] = -4;//아이템의 갯수 값 보유
	inv_info_max_stack_num[i][ii] = -4;//아이템의 최대 스택 갯수 값 보유
	inv_info_width[i][ii] = -4; //아이템 가로 길이
	inv_info_height[i][ii] = -4; //아이템 세로 길이
	inv_info_rotated[i][ii] = -4; //아이템 회전 유무
	inv_info_weight[i][ii] = -4; //아이템 무게 (단위는 kg)
	inv_info_searched[i][ii] = -4; //아이템 서치됨
	inv_info_startag[i][ii] = -4; //아이템 스타 태그
	
	return true;
}