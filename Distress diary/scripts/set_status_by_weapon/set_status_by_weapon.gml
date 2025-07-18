// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param sprite_index
///@param image_index
///@param [onlyReturn]
///@param [StarTag]
function set_status_by_weapon(argument0,argument1,argument2,argument3)
{
	var tmp_spr_ind = argument0;
	var tmp_img_ind = argument1;
	var dmg = 0, atk_sp = 0, crit_chance = 0, knockback = 0, tmp_attack_type = 0, tmp_range = 128, tmp_accurate = 0, tmp_bleeding = 0, tmp_poisoning = 0, tmp_burn = 0, tmp_mana = 0, tmp_charging_split = 1;
	
	if (tmp_spr_ind == spr_weapon)
	{
		switch(tmp_img_ind)
		{
			case 0:
				dmg = 3.8;
				atk_sp = 40;
				crit_chance = 10;
				knockback = 16;
				tmp_bleeding = 10;
			break;
		
			case 1:
				dmg = 2;
				atk_sp = 35;
				crit_chance = 16;
				knockback = 1;
				tmp_range = 78;
				tmp_attack_type = 2;
			break;
		
			case 2:
				dmg = 5;
				atk_sp = 70;
				crit_chance = 30;
				knockback = 24;
				tmp_attack_type = 3;
			break;
		
			case 3:
				dmg = 5.8;
				atk_sp = 40;
				crit_chance = 10;
				knockback = 16;
				tmp_bleeding = 15;
			break;
			
			case 4:
				dmg = 4;
				atk_sp = 35;
				crit_chance = 16;
				knockback = 3;
				tmp_range = 78;
				tmp_attack_type = 2;
			break;
			
			case 5:
				dmg = 8;
				atk_sp = 70;
				crit_chance = 30;
				knockback = 24;
				tmp_attack_type = 3;
			break;
			
			case 6:
				dmg = 8;
				atk_sp = 25;
				crit_chance = 10;
				knockback = 1;
				tmp_range = 64;
				tmp_accurate = 75;
				tmp_attack_type = 4;
				tmp_poisoning = 40;
			break;
			
			case 7:
				dmg = 6;
				atk_sp = 25;
				crit_chance = 5;
				knockback = 1;
				tmp_range = 64;
				tmp_accurate = 75;
				tmp_attack_type = 4;
				tmp_bleeding = 15;
			break;
			
			case 8:
				dmg = 9;
				atk_sp = 40;
				crit_chance = 15;
				knockback = 16;
				tmp_bleeding = 18;
			break;
			
			case 9:
				dmg = 7;
				atk_sp = 35;
				crit_chance = 20;
				knockback = 4;
				tmp_range = 78;
				tmp_attack_type = 2;
			break;
			
			case 10:
				dmg = 12;
				atk_sp = 60;
				crit_chance = 30;
				knockback = 24;
				tmp_attack_type = 3;
			break;
			
			case 11:
				dmg = 6;
				atk_sp = 35;
				crit_chance = 10;
				knockback = 16;
				tmp_bleeding = 15;
			break;
			
			case 12:
				dmg = 4;
				atk_sp = 30;
				crit_chance = 16;
				knockback = 3;
				tmp_range = 78;
				tmp_attack_type = 2;
			break;
			
			case 13:
				dmg = 8;
				atk_sp = 65;
				crit_chance = 30;
				knockback = 24;
				tmp_attack_type = 3;
			break;
			
			case 14:
				dmg = 9;
				atk_sp = 40;
				crit_chance = 15;
				knockback = 10;
				tmp_bleeding = 10;
				tmp_poisoning = 60;
			break;
			
			case 15:
				dmg = 7;
				atk_sp = 35;
				crit_chance = 20;
				knockback = 1;
				tmp_range = 78;
				tmp_attack_type = 2;
				tmp_poisoning = 15;
			break;
			
			case 16:
				dmg = 12;
				atk_sp = 60;
				crit_chance = 30;
				knockback = 12;
				tmp_attack_type = 3;
				tmp_poisoning = 70;
			break;
			
			case 17:
				dmg = 5;
				atk_sp = 30;
				crit_chance = 35;
				knockback = 16;
				tmp_bleeding = 16;
			break;
			
			case 18:
				dmg = 3;
				atk_sp = 25;
				crit_chance = 40;
				knockback = 4;
				tmp_range = 78;
				tmp_attack_type = 2;
			break;
			
			//쇼크볼트
			case 19:
				dmg = 48;
				atk_sp = 180;
				knockback = 2;
				tmp_accurate = 80;
				tmp_attack_type = 5;
				tmp_mana = 10;
				tmp_charging_split = 3;
				tmp_burn = 15;
			break;
			
			//라이트닝 볼트
			case 20:
				dmg = 48;
				atk_sp = 144;
				knockback = 2;
				tmp_accurate = 80;
				tmp_attack_type = 5;
				tmp_mana = 10;
				tmp_charging_split = 3;
				tmp_burn = 15;
			break;
			
			//홀리 라이트닝
			case 21:
				dmg = 28;
				atk_sp = 240;
				knockback = 3;
				tmp_accurate = 100;
				tmp_attack_type = 5;
				tmp_mana = 50;
				tmp_charging_split = 5;
				tmp_burn = 15;
			break;
			
			//쇼크볼
			case 22:
				dmg = 35;
				atk_sp = 90;
				knockback = 9;
				tmp_accurate = 100;
				tmp_attack_type = 5;
				tmp_mana = 22;
				tmp_charging_split = 1;
				tmp_burn = 15;
			break;
			
			//리플렉트 쇼크볼
			case 23:
				dmg = 30;
				atk_sp = 255;
				knockback = 7;
				tmp_accurate = 100;
				tmp_attack_type = 5;
				tmp_mana = 30;
				tmp_charging_split = 3;
				tmp_burn = 15;
			break;
			
			//리플렉트 볼
			case 24:
				dmg = 10;
				atk_sp = 400;
				knockback = 7;
				tmp_accurate = 100;
				tmp_attack_type = 5;
				tmp_mana = 10;
				tmp_charging_split = 5;
				tmp_burn = 15;
			break;
			
			//파이어볼
			case 25:
				dmg = 43;
				atk_sp = 180;
				knockback = 7;
				tmp_accurate = 100;
				tmp_attack_type = 5;
				tmp_mana = 30;
				tmp_charging_split = 3;
				tmp_burn = 90;
			break;
			
			//포이즌볼
			case 26:
				dmg = 43;
				atk_sp = 180;
				knockback = 7;
				tmp_accurate = 100;
				tmp_attack_type = 5;
				tmp_mana = 30;
				tmp_charging_split = 3;
				tmp_poisoning = 90;
			break;
			
			//워터볼
			case 27:
				dmg = 43;
				atk_sp = 180;
				knockback = 7;
				tmp_accurate = 100;
				tmp_attack_type = 5;
				tmp_mana = 30;
				tmp_charging_split = 3;
			break;

			//고스트 볼
			case 28:
				dmg = 43;
				atk_sp = 180;
				knockback = 7;
				tmp_accurate = 100;
				tmp_attack_type = 5;
				tmp_mana = 30;
				tmp_charging_split = 3;
				tmp_poisoning = 50;
			break;
		}
	}
	else if (tmp_spr_ind == spr_pickaxe)
	{
		tmp_range = 64;
		tmp_attack_type = 1;
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
				dmg = 0.5;
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
	else if (tmp_spr_ind == spr_others)
	{
		switch(tmp_img_ind)
		{
			case 0:
			case 1:
			case 2:
				dmg = 1.2;
				atk_sp = 40;
				crit_chance = 10;
				knockback = 0;
				tmp_accurate = 70;
				tmp_attack_type = 4;
				tmp_burn = 90;
			break;
		}
	}
	
	
	if (argument2 == undefined || argument2 == false)
	{
		var tmp_cal_crit = crit_chance;
		var tmp_cal_dmg = dmg;
		if (tmp_attack_type != 1)
		{
			tmp_cal_crit += (argument3 == undefined || argument3 = 0) ? 0 : 5+argument3*2;
		}
		else
		{
			tmp_cal_dmg -= argument3*1.5;
		}
		
		var tmp_weight_ratio = fix_to_zero(global.my_weight-global.over_weight)/90;
		var speed_by_weight = fix_to_zero(power(1-tmp_weight_ratio,2));
		global.attack_range = tmp_range;
		global.attack_type = tmp_attack_type;
		global.attack_damage_origin = dmg;
		global.attack_damage = (tmp_cal_dmg)*(1+sign(global.buff_left_time[3])*0.25-sign(global.buff_left_time[2])*0.25); //데미지 계산
		global.attack_speed = atk_sp;
		global.critical_chance = tmp_cal_crit;
		global.knockback_power = knockback; //넉백 파워
		global.accurate = tmp_accurate;
		global.bleeding_chance = tmp_bleeding;
		global.poisoning_chance = tmp_poisoning;
		global.burning_chance = tmp_burn;
		global.mana_decreasement = tmp_mana;
		global.charging_split = tmp_charging_split; //차징 단계 분리 정도
	}
	
	return string(dmg)+","+string(atk_sp)+","+string(crit_chance)+","+string(knockback)+","+string(tmp_range)+","+string(tmp_attack_type)+","+string(tmp_accurate)+","+string(tmp_bleeding)+","+string(tmp_poisoning)+","+string(tmp_burn);
}