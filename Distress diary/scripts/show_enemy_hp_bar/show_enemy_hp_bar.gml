// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param ins_id
///@param [returnOnly]
function show_enemy_hp_bar(argument0,argument1)
{
	var tmp_name_tag = "";
	var tmp_ins = argument0;
	switch(tmp_ins.object_index)
	{
		case obj_player:
			tmp_name_tag = tmp_ins.nickname;
		break;
		
		case obj_fireball:
			tmp_name_tag = "Flame Sphere (화염 구체)";
		break;
		
		case obj_wisp:
			tmp_name_tag = "Wisp (위습)";
		break;
		
		case obj_skull_head:
			tmp_name_tag = "Skull head (스컬 헤드)";
		break;
		
		case obj_skeleton:
			tmp_name_tag = "Skeleton (스켈레톤)";
		break;
		
		case obj_poison_slime:
			tmp_name_tag = "Poison Slime (독 슬라임)";
		break;
		
		case obj_orange_slime:
			tmp_name_tag = "Orange Slime (오랜지 슬라임)";
		break;
		
		case obj_crimson_slime:
			tmp_name_tag = "Crimson Slime (크림슨 슬라임)";
		break;
	}
	
	if (argument1 == undefined || argument1 == false)
	{
		global.enemy_hp_bar = tmp_ins;
		global.enemy_hp_bar_nametag = tmp_name_tag;
	}
	return tmp_name_tag;
}