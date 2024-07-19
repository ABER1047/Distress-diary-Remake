/// @description Insert description here
// You can write your code in this editor
if (!global.prohibit_movement_input)
{
	if (global.automatic_attack_enable)
	{
		event_user(0);
	}
	else
	{
		if (global.attack_cooldown_timer <= 0 && gage_bar_charged < 1)
		{
			gage_bar_charged += 0.025;
	
			var tmp_cal = global.max_movement_speed*0.7;
			if (tmp_cal < abs(global.movement_hspeed)+abs(global.movement_vspeed))
			{
				global.movement_hspeed += (0 - global.movement_hspeed)*0.35;
				global.movement_vspeed += (0 - global.movement_vspeed)*0.35;
			}
		}
	}
}