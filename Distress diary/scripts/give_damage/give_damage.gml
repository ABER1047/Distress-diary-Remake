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
		
		
		
		//혈흔 이펙트 생성
		var tmp_depth = tmp_ins.depth+16;
		if (instance_exists(obj_map_texture_draw))
		{
			tmp_depth = obj_map_texture_draw.depth-4;
		}
		
		var tmp_ins = instance_create_depth(tmp_ins.x,tmp_ins.y,tmp_depth,obj_blood_effect);
		
		
		//피격음
		play_sound_pos(hit_sfx,false,0.1,x,y,960,false);
	}
}