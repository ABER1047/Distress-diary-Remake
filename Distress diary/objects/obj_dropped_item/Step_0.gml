/// @description Insert description here
// You can write your code in this editor


//위치 (y축에 따라 depth 설정)
depth = -floor(y);


//z축 중력 적용
z_axis_gravity();


//pushable_objects끼리 밀리는 효과 추가
var tmp_ins = pushable_objects_physics();
if (tmp_ins == global.my_player_ins_id[global.my_player_id])
{
	alarm[1] = 1;
}