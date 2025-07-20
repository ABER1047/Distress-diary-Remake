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
					var tmp_gage_increasement = (1/global.attack_speed)*global.charging_split;
					//일반 무기 게이지 차는거
					if (global.attack_type != 5)
					{
						gage_bar_charged += tmp_gage_increasement;
					}
					else
					{
						var tmp_mana_decreasement = tmp_gage_increasement*global.mana_decreasement;
						if (mana >= global.mana_decreasement)
						{
							mana -= tmp_mana_decreasement;
							gage_bar_charged += tmp_gage_increasement;
						}
					}
					
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
				
				
				//마법 영창 이펙트
				if (global.attack_type == 5)
				{
					var tmp_cal_xx = x+irandom_range(-8,8), tmp_cal_yy = y-16-z+irandom_range(-8,8)
					if (spell_effect_timer%25 == 0)
					{
						var tmp_ins = display_texts(tmp_cal_xx+lengthdir_x(48,my_n_dir*90),tmp_cal_yy+lengthdir_y(48,my_n_dir*90),c_white,id,"@rune!",irandom_range(50,30)/100);
						tmp_ins.image_alpha = 0.75;
						tmp_ins.animation = 50;
					}
					
					if (global.graphics_quality > 0 && percentage_k(3))
					{
						var tmp_signed_xscale = -sign(image_xscale);
						var tmp_ins = instance_create_depth(tmp_cal_xx,tmp_cal_yy-16,-1,obj_bright_line_effect);
						tmp_ins.image_blend = c_white;
						tmp_ins.direction = 90+irandom_range(-10,10);
						tmp_ins.rd_dir_increasement = 90+tmp_signed_xscale*30+global.movement_hspeed*20;
						tmp_ins.start_dir = 90;
						tmp_ins.speed = irandom_range(20,30)/15+abs(global.movement_hspeed*0.1);
						tmp_ins.rd_dir_timer_increasement = 1;
					}
					spell_effect_timer ++;
				}
			}
		}
	}
}
else
{
	spell_effect_timer = 0;
	gage_bar_charged = 0;
}