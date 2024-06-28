// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


//@param
function set_status_by_weapon(argument0)
{
	var tmp_img_ind = argument0;
	var dmg = 0, atk_sp = 1, crit_chance = 0, knockback = 0;
	switch(tmp_img_ind)
	{
		case -1:
			dmg = 0;
			atk_sp = 0;
			crit_chance = 0;
			knockback = 0;
		break;
		
		case 0:
			dmg = 3;
			atk_sp = 40;
			crit_chance = 10;
			knockback = 16;
		break;
		
		case 1:
			dmg = 3;
			atk_sp = 20;
			crit_chance = 5;
			knockback = 3;
		break;
		
		case 2:
			dmg = 5;
			atk_sp = 33;
			crit_chance = 10;
			knockback = 16;
		break;
		
		case 3:
			dmg = 4;
			atk_sp = 25;
			crit_chance = 0;
			knockback = 3;
		break;
		
		case 4:
			dmg = 4;
			atk_sp = 25;
			crit_chance = 30;
			knockback = 3;
		break;
	}
	
	global.attack_damage = (dmg)*(1+sign(global.buff_left_time[3])*0.25-sign(global.buff_left_time[2])*0.25); //데미지 계산
	global.attack_speed = atk_sp;
	global.critical_chance = crit_chance;
	global.knockback_power = knockback; //넉백 파워
}