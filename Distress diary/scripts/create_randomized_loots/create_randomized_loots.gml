// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param x
///@param y
///@param img_ind
///@param obj_id
///@param DoNotSend
function create_randomized_loots(argument0,argument1,argument2,argument3,argument4)
{
	var tmp_arr_ind = floor(argument2/2);
	var tmp_inv_width = [ 3, 4, 4, 4, 4, 3, 4, 6, 3, 4, 0, 0, 8, 3 ];
	var tmp_inv_height = [ 6, 4, 4, 4, 4, 3, 4, 3, 3, 7, 0, 0, 5, 3 ];
	var tmp_chest_name = [ "버려진 철제 서랍", "버려진 백팩", "버려진 의료 가방", "버려진 PC", "버려진 PC", "나무 상자", "철제 상자", "대형 철제 상자", "공구 상자", "버려진 캐비넷", "", "", "대형 나무 상자", "금고" ];
	var tmp_ins = create_loots(argument0,argument1,argument2,tmp_inv_width[tmp_arr_ind],tmp_inv_height[tmp_arr_ind],tmp_chest_name[tmp_arr_ind],argument3,argument4);
	tmp_ins.alarm[0] = 1;
	

	return tmp_ins;
}