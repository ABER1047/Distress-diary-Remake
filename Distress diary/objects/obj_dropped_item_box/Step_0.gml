/// @description Insert description here
// You can write your code in this editor

if (!stop_cal_by_pos_statement)
{
	//위치 (y축에 따라 depth 설정)
	depth = -floor(y);

	//pushable_objects끼리 밀리는 효과 추가
	pushable_objects_physics();
}



//z축 중력 적용
z_axis_gravity();


