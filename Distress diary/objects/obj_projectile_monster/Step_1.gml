/// @description Insert description here
// You can write your code in this editor

//깊이 설정
depth = -y;

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
statement_by_pos();


//플레이어한테 충돌한 판정
var tmp_ins = instance_place(x,y,obj_player);
if (instance_exists(tmp_ins))
{
	give_damage(tmp_ins,dmg,false,16,x,y,60);
	instance_destroy_multiplayer(id);
}