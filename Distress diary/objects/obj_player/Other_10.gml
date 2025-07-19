/// @description 공격 모션 재생
if (global.attack_cooldown_timer == 0 && !global.prohibit_movement_input && hp > 0 && !instance_exists(obj_ui_parents))
{
	global.b_fixed_dir = global.fixed_dir;
	global.fixed_dir = true;
	global.attack_cooldown_timer = 1;
	alarm[2] = 1;
	
	
	if (global.attack_type != 5)
	{
		var tmp_charging_dmg_bonus = floor(gage_bar_charged*10)/10; //차징 데미지 보너스
		if (tmp_charging_dmg_bonus < 0.25 || global.attack_type == 2 || global.attack_type == 4)
		{
			tmp_charging_dmg_bonus = 0;
		}
		else if (global.attack_type == 3 && tmp_charging_dmg_bonus >= 1)
		{
			tmp_charging_dmg_bonus = 2;
		}
		tmp_dmg_cal = global.attack_damage*(1 + tmp_charging_dmg_bonus + (zspeed > 0 ? 0.1 : 0));
	
		//투척용 무기/도구 던지기
		var tmp_val = global.quickslot_stack_num[global.quickslot_index];
		if (tmp_val > 0)
		{
			var tmp_knife_type = global.quickslot_img_ind[global.quickslot_index];
			var tmp_img_ind = 3;
			if (tmp_knife_type == 4)
			{
				tmp_img_ind = 4;
			}
		
			var tmp_cal_accurate = (2-gage_bar_charged)*(150-global.accurate)*0.15;
			var tmp_m_dir = point_direction(x,y,mouse_x,mouse_y);
			if (global.quickslot_spr_ind[global.quickslot_index] == spr_weapon)
			{
				create_projectile(x,y,tmp_img_ind,48,2,tmp_dmg_cal,32+z,tmp_cal_accurate,tmp_m_dir,0);
			}
			else
			{
				//토치 던지기
				var tmp_sp = 16*(0.3+tmp_charging_dmg_bonus)+abs(_speed)+abs(global.movement_vspeed)+abs(global.movement_hspeed);
				create_bounce_object(x,y+8+lengthdir_y(48,tmp_m_dir),z+48,tmp_sp,tmp_m_dir,irandom_range(-8,-12),holding_item_spr_ind,holding_item_img_ind,1.5,3600,-4,-4,false);
			
				//효과음 재생
				play_sound_pos(fire_ignition_sfx,false,0.1,x,y-32,640,false,-4,-4);
			}
		
			global.quickslot_stack_num[global.quickslot_index] -= 1;
			if (tmp_val <= 1)
			{
				global.quickslot_spr_ind[global.quickslot_index] = -4;
			}
		}
	}
	else //마법 공격
	{
		var tmp_spell_type = global.quickslot_img_ind[global.quickslot_index];
		var tmp_cal_accurate = (2-gage_bar_charged)*(100-global.accurate);
		var dmg_info_arr = [ global.attack_damage, global.knockback_power, global.critical_chance, global.critical_dmg_magnification, global.bleeding_chance, global.poisoning_chance, global.burning_chance ];
		var tmp_m_dir = point_direction(x,y,mouse_x,mouse_y);
		var tmp_charging_num = 0;
		for(var i = 1; i <= global.charging_split; i++)
		{
			if (gage_bar_charged >= i/global.charging_split)
			{
				tmp_charging_num = i;
			}
			else
			{
				break;
			}
		}
		
		chat_up_multiplayer("tmp_charging_num : "+string(tmp_charging_num)+" / "+string(tmp_spell_type),false,true);
		tmp_dmg_cal = (tmp_charging_num == 0) ? 1 : global.attack_damage;
		
		if (tmp_charging_num != 0)
		{
			var tmp_xx = x+lengthdir_x(16,tmp_m_dir), tmp_yy = y+8+lengthdir_y(16,tmp_m_dir);
			switch(tmp_spell_type)
			{
				case 19:
					create_shockbolt(tmp_xx,tmp_yy,z+32,0,4,tmp_m_dir,0,0,#3898FF,global.my_player_id,tmp_cal_accurate,dmg_info_arr);
				break;
			
				case 20:
					create_shockbolt(tmp_xx,tmp_yy,z+32,0,4,tmp_m_dir,0,tmp_charging_num,#3898FF,global.my_player_id,tmp_cal_accurate,dmg_info_arr);
				break;
				
				case 21:
					create_shockbolt(tmp_xx,tmp_yy,z+32,0,4,tmp_m_dir,0,tmp_charging_num,#3898FF,global.my_player_id,tmp_cal_accurate,dmg_info_arr);
				break;
				
				case 22:
					create_projectile(tmp_xx,tmp_yy,0,2,2,global.attack_damage,z+16,0,tmp_m_dir,2,spr_projectile_shockball,,,1);
				break;
				
				case 23:
					create_projectile(tmp_xx,tmp_yy,0,2,2,global.attack_damage,z+16,0,tmp_m_dir,2,spr_projectile_shockball,,,1,tmp_charging_num);
				break;
				
				case 24:
					create_projectile(tmp_xx,tmp_yy,0,12,2,global.attack_damage,z+16,0,tmp_m_dir,3,spr_projectile_mirrorball,,,2,tmp_charging_num);
				break;
				
				case 25:
					create_projectile(tmp_xx,tmp_yy,0,17,2,global.attack_damage,z+16,0,tmp_m_dir,1,spr_projectile_fireball,25,2.25,0);
				break;
			}
		}
	}
	
	
	
	if (global.attack_type == 2) //단검 공격
	{
		gage_bar_charged -= 0.025;
		alarm[3] = 1;
	}
	else
	{
		gage_bar_charged = 0;
	}
}

