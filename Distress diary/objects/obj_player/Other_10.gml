/// @description 공격 모션 재생
if (global.attack_cooldown_timer == 0 && !global.prohibit_movement_input && hp > 0 && !instance_exists(obj_ui_parents))
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
	global.b_fixed_dir = global.fixed_dir;
	global.fixed_dir = true;
	if (global.attack_type == 2)
	{
		gage_bar_charged -= 0.025;
		alarm[3] = 1;
	}
	else
	{
		gage_bar_charged = 0;
	}
	global.attack_cooldown_timer = 1;
	alarm[2] = 1;
	
	//투척용 무기/도구 던지기
	var tmp_val = global.quickslot_stack_num[global.quickslot_index];
	if (tmp_val > 0)
	{
		global.quickslot_stack_num[global.quickslot_index] -= 1;
		if (tmp_val <= 1)
		{
			global.quickslot_spr_ind[global.quickslot_index] = -4;
		}
		
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
			create_projectile(x,y,tmp_img_ind,48,2,tmp_dmg_cal,32+z,tmp_cal_accurate,tmp_m_dir);
		}
		else
		{
			//토치 던지기
			var tmp_sp = 16*(0.3+tmp_charging_dmg_bonus)+abs(_speed)+abs(global.movement_vspeed)+abs(global.movement_hspeed);
			create_bounce_object(x,y-16+lengthdir_y(48,tmp_m_dir),z+32,tmp_sp,tmp_m_dir,irandom_range(-8,-12),holding_item_spr_ind,holding_item_img_ind,1.5,3600,-4,-4,false);
			
			//효과음 재생
			play_sound_pos(fire_ignition_sfx,false,0.1,x,y-32,640,false,-4,-4);
		}
	}
}

