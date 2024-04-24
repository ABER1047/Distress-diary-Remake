/// @description Insert description here
// You can write your code in this editor

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
statement_by_pos();

if (global.show_wall_hitbox && point_distance(x,y,global.my_player_ins_id[global.my_player_id].x,global.my_player_ins_id[global.my_player_id].y) <= 128)
{
	visible = origin_visible_statement;
}