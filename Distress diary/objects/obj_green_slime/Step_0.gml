/// @description Insert description here
// You can write your code in this editor
if (!stop_cal_by_pos_statement)
{
	//사망 이벤트
	if (hp <= 0)
	{
		for(var i = 0; i < 360; i += 45)
		{
			var tmp_hspeed = lengthdir_x(16,i);
			var tmp_vspeed = lengthdir_y(16,i);
			var tmp_ins = create_bubble_effect(x,y,-z,c_white,c_black,0.1,tmp_vspeed*0.48,tmp_hspeed,0.1,0,false);
			tmp_ins.image_xscale = 1.6;
			tmp_ins.image_yscale = 1.6;
		}
		
		repeat(irandom_range(4,5))
		{
			create_bounce_object(x,y,z+irandom_range(0,64),_speed,direction+irandom_range(-60,60),0,spr_deadmob_debris,3,image_yscale*0.75,irandom_range(240,360));
		}
		
		play_sound_pos(ghost_disappear_sfx,false,0.3,x,y,1280,true,my_pos_xx,my_pos_yy);
		instance_destroy();
	}
	
	
	
	//매 80프레임마다 점프 공격 애니메이션 재생
	if (tracking_timer >= 80)
	{
		switch(tracking_timer)
		{
			case 80:
				//이미지 애니메이션 재생
				if (image_index < 3)
				{
					image_index += 0.7;
				}
				else
				{
					if (instance_exists(targeted))
					{
						tmp_value1 = targeted.x;
						tmp_value2 = targeted.y;
					}
					else
					{
						tmp_value1 = x;
						tmp_value2 = y;
					}
					
					//점프 효과음
					play_sound_pos(slime_jump_sfx,false,0.25,x,y,960,true,my_pos_xx,my_pos_yy);
					
					//점프 애니메이션
					zspeed = -64;
					tracking_timer = 81;
					show_debug_message(string(tracking_timer)+" /z "+string(z)+" /zspeed "+string(zspeed));
				}
			break;
		
		
			//점프 후 이동 애니메이션
			case 81:
				//슬라임 늘어나는 애니메이션
				image_xscale += (sign(image_xscale)*1.85 - image_xscale)*0.3;
				image_yscale += (3.5 - image_yscale)*0.3;
			
				//몹 이동
				x += (tmp_value1 - x)*0.08;
				y += (tmp_value2 - y)*0.08;
				
				if (zspeed > 0)
				{
					if (zspeed < 96)
					{
						zspeed = 96;
					}
				}
				else if (zspeed == 0)
				{
					//착지 효과음
					play_sound_pos(slime_land_sfx,false,0.25,x,y,960,true,my_pos_xx,my_pos_yy);
					
					//착지 애니메이션 재생
					image_xscale = sign(image_xscale)*4;
					image_yscale = 0.5;
					tracking_timer = 82;
					show_debug_message(string(tracking_timer)+" /z "+string(z)+" /zspeed "+string(zspeed));
					
					//착지시 해당 자리에 점액질 생성
					var tmp_ins = instance_create_multiplayer(obj_mucus_effect,x,y,global.object_id_ind,0,true,my_pos_xx,my_pos_yy);
					tmp_ins.image_xscale = 2.5;
				}
			break;
			
			
			//착지 애니메이션
			case 82:
				image_xscale += (sign(image_xscale)*2 - image_xscale)*0.2;
				image_yscale += (2 - image_yscale)*0.2;
				
				if (image_index > 0.5)
				{
					image_index -= 0.7;
				}
				
				if (abs(image_yscale-2) <= 0.01)
				{
					image_xscale = sign(image_xscale)*2;
					image_yscale = 2;
					image_index = 0;
					tracking_timer = 0;
					show_debug_message(string(tracking_timer)+" /z "+string(z)+" /zspeed "+string(zspeed));
				}
			break;
		}
	}
	else
	{
		if (global.is_server)
		{
			tracking_timer ++;
			
			if (tracking_timer == 80)
			{
				//애니메이션 정보 전송
				send_InstanceVariableData(id,"tracking_timer",tracking_timer);
			}
		}
	}
}