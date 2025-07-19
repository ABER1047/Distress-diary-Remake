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
		else
		{
			//차징 공격
			if (global.attack_cooldown_timer <= 0)
			{
				if (gage_bar_charged < 1)
				{
					gage_bar_charged += 60/power(global.attack_speed/global.charging_split,2);
					
					for(var i = 0; i < global.charging_split; i++)
					{
						if (global.gage_bar_shine_animation <= 0.5 && floor(100*gage_bar_charged/i) == floor(100/global.charging_split))
						{
							global.gage_bar_shine_animation = 1; //게이지 바 번쩍거림 이펙트
							break;
						}
					}
				}
				else
				{
					gage_bar_charged = 1;
					if (global.gage_bar_shine_animation <= 0)
					{
						global.gage_bar_shine_animation = 1; //게이지 바 번쩍거림 이펙트
					}
				}
	
				var tmp_cal = global.max_movement_speed*0.7;
				if (tmp_cal < abs(global.movement_hspeed)+abs(global.movement_vspeed))
				{
					global.movement_hspeed += (0 - global.movement_hspeed)*0.35;
					global.movement_vspeed += (0 - global.movement_vspeed)*0.35;
				}
			}
			
			
			//마법 영창 이펙트
			if (global.attack_type == 5)
			{
				if (spell_effect_timer%25 == 0)
				{
					var tmp_ins = display_texts(x+lengthdir_x(48,my_n_dir*90)+irandom_range(-8,8),y+lengthdir_y(48,my_n_dir*90)-16-z+irandom_range(-8,8),c_white,id,"@rune!",irandom_range(50,30)/100);
					tmp_ins.image_alpha = 0.75;
					tmp_ins.animation = 50;
				}
				spell_effect_timer ++;
			}
		}
	}
}
else
{
	spell_effect_timer = 0;
	gage_bar_charged = 0;
}