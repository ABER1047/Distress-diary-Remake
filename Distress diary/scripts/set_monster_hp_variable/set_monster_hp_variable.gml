// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param ins_id
function set_monster_hp_variable(argument0)
{
	var tmp_ins = argument0;
	var tmp_hp = 100, tmp_def_pow = 0;
	switch(tmp_ins.object_index)
	{
		case obj_fireball:
			tmp_hp = 65;
			tmp_def_pow = 4;
		break;
		
		case obj_wisp:
			tmp_hp = 65;
			tmp_def_pow = 1;
		break;
		
		case obj_skull_head:
			tmp_hp = 45;
			tmp_def_pow = 2;
		break;
		
		case obj_skeleton:
			tmp_hp = 100;
			tmp_def_pow = 2;
		break;
		
		case obj_poison_slime:
			tmp_hp = 100;
		break;
		
		case obj_orange_slime:
			tmp_hp = 115;
		break;
		
		case obj_crimson_slime:
			tmp_hp = 125;
		break;
		
		case obj_infected_skeleton:
			tmp_hp = 20;
			tmp_def_pow = 2;
		break;
		
		case obj_dummy:
			tmp_hp = 1000;
			tmp_def_pow = 0;
		break;
	}
	
	var tmp_cal = round(tmp_hp*(1+tmp_def_pow*0.01));
	tmp_ins.hp = tmp_cal;
	tmp_ins.max_hp = tmp_cal;
	return tmp_cal;
}