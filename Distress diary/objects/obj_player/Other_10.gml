/// @description 공격 모션 재생
if (global.attack_cooldown_timer == 0 && !global.prohibit_movement_input && hp > 0 && !instance_exists(obj_ui_parents))
{
	global.attack_cooldown_timer ++;
	global.b_fixed_dir = global.fixed_dir;
	global.fixed_dir = true;
	alarm[2] = 1;
}

