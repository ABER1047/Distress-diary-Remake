/// @description Insert description here
// You can write your code in this editor

//인벤토리가 2개만 남아있을때, 깊이 값 초기화
if (instance_number(obj_inv_ui) == 2)
{
	global.min_depth = -999;
}


//창이 닫혔을 때, 더이상 열려있지 않다고 값 적용시키기
if (instance_exists(variable_owner) && variable_instance_exists(variable_owner,"is_opened"))
{
	variable_owner.is_opened = -4;
}


//창이 닫혔을 때, 아이템 정보값을 가지고 있는 오브젝트가 obj_dropped_item인 경우
if (instance_exists(variable_owner) && variable_owner.object_index == obj_dropped_item)
{
	//인벤 칸 자동 리사이징 해주기
	variable_owner.resize_inv = true;
}





