// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param ins_id
///@param dmg
///@param ignore_cooltime
///@param knockback
///@param attacker_xx
///@param attacker_yy
///@param dmg_cooltime
///@param [critical_chance]
///@param [magnification]
function give_damage(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8)
{
	var tmp_ins = argument0;
	if (instance_exists(tmp_ins))
	{
		//넉백
		var knockback_speed = argument3;
		var is_dmg_cooltime_exists = argument2 || (variable_instance_exists(tmp_ins,"dmg_cooltime") && tmp_ins.dmg_cooltime == 0);
		var is_hp_exists = variable_instance_exists(tmp_ins,"hp");
		var is_speed_exists = variable_instance_exists(tmp_ins,"_speed");
		if (knockback_speed > 0 && is_speed_exists && ((is_hp_exists && is_dmg_cooltime_exists) || !is_hp_exists))
		{
			var attacker_xx = argument4;
			var attacker_yy = argument5;
			var dir_ = point_direction(attacker_xx,attacker_yy,tmp_ins.x,tmp_ins.y);
			tmp_ins._speed += knockback_speed;
			tmp_ins.direction = dir_;
		}
	
		if (is_hp_exists && (argument2 || is_dmg_cooltime_exists))
		{
			var tmp_dmg = (tmp_ins != global.my_player_ins_id[global.my_player_id]) ? argument1 : argument1*(1-global.defence_power*0.01);
			
			//크리티컬 확률이랑 크리티컬 데미지 배율이 정의된 경우
			if (argument7 != undefined && argument8 != undefined && percentage_k(argument7))
			{
				tmp_dmg *= (1+argument8);
			}
			tmp_ins.hp -= tmp_dmg;
			tmp_ins.dmg_cooltime = argument6;
			if (tmp_ins.hp < 0)
			{
				tmp_ins.hp = 0;
			}

		
			//디버그용 메시지
			show_message_log(tmp_ins.hp);

			//데이터 값 전송
			var tmp_var_name = "x,y,direction,hp,dmg_cooltime";
			var tmp_var = string(tmp_ins.x)+","+string(tmp_ins.y)+","+string(tmp_ins.direction)+","+string(tmp_ins.hp)+","+string(tmp_ins.dmg_cooltime);
			if (is_speed_exists)
			{
				tmp_var = string(tmp_var)+","+string(tmp_ins._speed);
				tmp_var_name = string(tmp_var_name)+",_speed";
			}
			send_InstanceMuchVariableData(tmp_ins,tmp_var_name,tmp_var);
		
		
		
			//혈흔 이펙트 생성
			var tmp_depth = obj_map_texture_draw.depth-4;
			var tmp_ins = instance_create_multiplayer(obj_blood_effect,tmp_ins.x,tmp_ins.y,global.object_id_ind,0,true,-4,-4);
		
		
			//피격음
			play_sound_pos(hit_sfx,false,0.1,obj_camera.x,obj_camera.y,960,false,-4,-4);
		

			//데미지 정보 표기
			var tmp_yy = (tmp_ins.y-128);
			tmp_yy -= (variable_instance_exists(tmp_ins,"z")) ? tmp_ins.z : 0;
		
			damage_display(tmp_ins.x,tmp_yy,#7A213A,tmp_ins,string(tmp_dmg));
		}
	}
}