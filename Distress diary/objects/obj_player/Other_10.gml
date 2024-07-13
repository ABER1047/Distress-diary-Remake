/// @description 공격 모션 재생
if (global.attack_cooldown_timer == 0 && !global.prohibit_movement_input && hp > 0 && !instance_exists(obj_ui_parents))
{
	var tmp_charging_dmg_bonus = floor(gage_bar_charged*10)/10; //차징 데미지 보너스
	if (tmp_charging_dmg_bonus < 0.25)
	{
		tmp_charging_dmg_bonus = 0;
	}
	tmp_dmg_cal = global.attack_damage*(1 + percentage_k(global.critical_chance)*global.critical_dmg_magnification + tmp_charging_dmg_bonus);
	global.attack_cooldown_timer ++;
	global.b_fixed_dir = global.fixed_dir;
	global.fixed_dir = true;
	gage_bar_charged = 0;
	alarm[2] = 1;
	
	//투척용 칼 던지기
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
		
		create_projectile(x,y,tmp_img_ind,48,2,tmp_dmg_cal,32+z,13,point_direction(x,y,mouse_x,mouse_y));
	}
}

