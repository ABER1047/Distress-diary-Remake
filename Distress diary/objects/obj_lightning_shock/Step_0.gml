

if (image_alpha >= 1)
{
	//몬스터 공격 판정
	with(obj_mob_parents)
	{
		//팀킬 가능 여부 체크
		var chk_pvpable = (object_index != obj_player || (global.pvpable && object_index == obj_player && obj_id_player_only != other.attacker_id));
		if (chk_pvpable)
		{
			var tmp_ch = abs(other.z - z);
			//show_message_log(tmp_ch);
			if (place_meeting(x,y,other.id) && ((tmp_ch <= 96 && zspeed >= 0) || tmp_ch <= 64))
			{
				give_damage(id,other.attack_dmg,true,other.knockback,other.x,other.y,25,other.critical_chance,other.magnification,other.bleeding_chance,other.poisoning_chance,other.burning_chance);
			
				//화면흔들림 효과
				if (variable_instance_exists(id,"hp"))
				{
					view_shake(1+floor(other.attack_dmg/5)*1.5,1+floor(other.attack_dmg/5),1,2);
				}
			}
		}
	}
}
else if (image_alpha <= 0)
{
	instance_destroy();
}
image_alpha -= 0.05;