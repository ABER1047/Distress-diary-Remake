/// @description Insert description here
// You can write your code in this editor


//위치 (y축에 따라 depth 설정)
depth = -floor(y);


//z축 중력 적용
z_axis_gravity();


//pushable_objects끼리 밀리는 효과 추가
pushable_objects_physics();


//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
statement_by_pos();