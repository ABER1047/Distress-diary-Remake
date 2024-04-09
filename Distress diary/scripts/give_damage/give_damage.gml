// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param ins_id
///@param dmg
///@param ignore_cooltime
function give_damage(argument0,argument1,argument2)
{
	var tmp_ins = argument0;
	if (tmp_ins.dmg_cooltime == 0 || argument2)
	{
		tmp_ins.hp -= argument1;
		tmp_ins.dmg_cooltime = 60;
		if (tmp_ins.hp < 0)
		{
			tmp_ins.hp = 0;
		}
	}
}