// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param sprite_index
///@param image_index
function set_status_by_weapon(argument0,argument1)
{
	var tmp_spr_ind = argument0;
	var tmp_img_ind = argument1;
	var dmg = 0, atk_sp = 0, crit_chance = 0, knockback = 0, auto_attack = false, tmp_range = 128;
	
	if (tmp_spr_ind == spr_weapon)
	{
		switch(tmp_img_ind)
		{
			case 0:
				dmg = 3;
				atk_sp = 40;
				crit_chance = 10;
				knockback = 16;
			break;
		
			case 1:
				dmg = 2;
				atk_sp = 35;
				crit_chance = 16;
				knockback = 1;
				tmp_range = 78;
			break;
		
			case 2:
				dmg = 5;
				atk_sp = 70;
				crit_chance = 30;
				knockback = 24;
			break;
		
			case 3:
				dmg = 5;
				atk_sp = 40;
				crit_chance = 10;
				knockback = 16;
			break;
			
			case 4:
				dmg = 4;
				atk_sp = 35;
				crit_chance = 16;
				knockback = 3;
				tmp_range = 78;
			break;
			
			case 5:
				dmg = 8;
				atk_sp = 70;
				crit_chance = 30;
				knockback = 24;
			break;
			
			case 6:
				dmg = 8;
				atk_sp = 25;
				crit_chance = 10;
				knockback = 1;
				tmp_range = 64;
			break;
			
			case 7:
				dmg = 6;
				atk_sp = 25;
				crit_chance = 5;
				knockback = 1;
				tmp_range = 64;
			break;
			
			case 8:
				dmg = 8;
				atk_sp = 40;
				crit_chance = 15;
				knockback = 16;
			break;
			
			case 9:
				dmg = 7;
				atk_sp = 35;
				crit_chance = 20;
				knockback = 4;
				tmp_range = 78;
			break;
			
			case 10:
				dmg = 12;
				atk_sp = 60;
				crit_chance = 30;
				knockback = 24;
			break;
			
			case 11:
				dmg = 5;
				atk_sp = 35;
				crit_chance = 10;
				knockback = 16;
			break;
			
			case 12:
				dmg = 4;
				atk_sp = 30;
				crit_chance = 16;
				knockback = 3;
				tmp_range = 78;
			break;
			
			case 13:
				dmg = 8;
				atk_sp = 65;
				crit_chance = 30;
				knockback = 24;
			break;
			
			case 14:
				dmg = 8;
				atk_sp = 40;
				crit_chance = 15;
				knockback = 10;
			break;
			
			case 15:
				dmg = 7;
				atk_sp = 35;
				crit_chance = 20;
				knockback = 1;
				tmp_range = 78;
			break;
			
			case 16:
				dmg = 12;
				atk_sp = 60;
				crit_chance = 30;
				knockback = 12;
			break;
			
			case 17:
				dmg = 4;
				atk_sp = 30;
				crit_chance = 35;
				knockback = 16;
			break;
			
			case 18:
				dmg = 3;
				atk_sp = 25;
				crit_chance = 40;
				knockback = 4;
				tmp_range = 78;
			break;
		}
	}
	else if (tmp_spr_ind == spr_pickaxe)
	{
		tmp_range = 64;
		auto_attack = true;
		switch(tmp_img_ind)
		{
			case 0: //300
				dmg = -20;
				atk_sp = 60;
				crit_chance = 0;
				knockback = 3;
			break;
			
			case 1: //240
				dmg = -25;
				atk_sp = 60;
				crit_chance = 0;
				knockback = 3;
			break;
			
			case 2: //210
				dmg = -17;
				atk_sp = 35;
				crit_chance = 0;
				knockback = 3;
			break;
			
			case 3: //240
				dmg = -12.5;
				atk_sp = 30;
				crit_chance = 0;
				knockback = 3;
			break;
		}
	}
	else if (tmp_spr_ind == spr_comp)
	{
		switch(tmp_img_ind)
		{
			case 23:
				dmg = 1;
				atk_sp = 10;
				crit_chance = 10;
				knockback = 0;
			break;
			
			case 24:
				dmg = 5;
				atk_sp = 60;
				crit_chance = 30;
				knockback = 16;
			break;
		}
	}

	global.attack_range = tmp_range;
	global.automatic_attack_enable = auto_attack;
	global.attack_damage = (dmg)*(1+sign(global.buff_left_time[3])*0.25-sign(global.buff_left_time[2])*0.25); //데미지 계산
	global.attack_speed = atk_sp;
	global.critical_chance = crit_chance;
	global.knockback_power = knockback; //넉백 파워
}