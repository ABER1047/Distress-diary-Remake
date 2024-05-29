/// @description Insert description here
// You can write your code in this editor
if (global.is_server && !stop_cal_by_pos_statement)
{
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
						tmp_value1 = targeted.x+choose(-8,8);
						tmp_value2 = targeted.y+choose(-8,8);
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