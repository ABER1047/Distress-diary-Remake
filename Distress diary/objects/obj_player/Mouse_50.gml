/// @description Insert description here
// You can write your code in this editor
if (!instance_exists(obj_ui_parents) && global.attack_speed > 0 && !global.is_mouse_inside_quickslot)
{
	if (!global.prohibit_movement_input)
	{
		//자동 공격
		if (global.attack_type == 1)
		{
			event_user(0);
		}
		else if (global.attack_type == 0 || global.attack_type == 2 || global.attack_type == 3)
		{
			//차징 공격
			if (global.attack_cooldown_timer <= 0)
			{
				if (gage_bar_charged < 1)
				{
					gage_bar_charged += 60/power(global.attack_speed,2);
				}
				else
				{
					gage_bar_charged = 1;
				}
	
				var tmp_cal = global.max_movement_speed*0.7;
				if (tmp_cal < abs(global.movement_hspeed)+abs(global.movement_vspeed))
				{
					global.movement_hspeed += (0 - global.movement_hspeed)*0.35;
					global.movement_vspeed += (0 - global.movement_vspeed)*0.35;
				}
			}
		}
	}
}
else
{
	gage_bar_charged = 0;
}