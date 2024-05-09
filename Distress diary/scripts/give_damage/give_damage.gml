// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param ins_id
///@param dmg
///@param ignore_cooltime
function give_damage(argument0,argument1,argument2)
{
	var tmp_ins = argument0;
	if (instance_exists(tmp_ins) && (tmp_ins.dmg_cooltime == 0 || argument2))
	{
		var tmp_dmg = argument1;
		tmp_ins.hp -= tmp_dmg;
		tmp_ins.dmg_cooltime = 60;
		if (tmp_ins.hp < 0)
		{
			tmp_ins.hp = 0;
		}
		
		
		
		//혈흔 이펙트 생성
		var tmp_depth = obj_map_texture_draw.depth-4;
		var tmp_ins = instance_create_depth(tmp_ins.x,tmp_ins.y,tmp_depth,obj_blood_effect);
		
		
		//피격음
		play_sound_pos(hit_sfx,false,0.1,obj_camera.x,obj_camera.y,960,false,-4,-4);
		
		
		//데미지 정보 표기
		var tmp_yy = (tmp_ins.y-128);
		tmp_yy += (variable_instance_exists(tmp_ins,"floating_yy")) ? tmp_ins.floating_yy : 0;
		tmp_yy -= (variable_instance_exists(tmp_ins,"z")) ? tmp_ins.z : 0;
		
		damage_display(tmp_ins.x,tmp_yy,#7A213A,tmp_ins,string(tmp_dmg));
	}
}