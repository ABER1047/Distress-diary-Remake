/// @description Insert description here
// You can write your code in this editor
if (!stop_cal_by_pos_statement)
{
	depth = -floor(y);

	
	//인터렉션 키 드로우 용
	if (show_interaction_key > 0)
	{
		show_interaction_key -= 1;
	}



	//다른사람이 상호작용 중인 경우, 상호작용 중이라고 정보 보내기
	if (b_is_opened != is_opened)
	{
		light_timer = 0;
		
		//효과음 재생
		play_sound_pos(fire_ignition_sfx,false,0.1,x,y-32,640,false,-4,-4);

		send_InstanceVariableData(id,"is_opened",is_opened);
		b_is_opened = is_opened;
	}

	
	//상호작용 중 일때
	if (is_opened)
	{
		light_timer ++;
		
		//라이트 효과
		c_light(light_col[fire_type],light_scale*0.75,light_alpha,x,y-32);
		if (light_timer < 90)
		{
			light_alpha += (1 - light_alpha)*0.1;
			light_scale += (1 - light_scale)*0.1;
		}
		else if (light_timer < 120)
		{
			light_alpha += (0.92 - light_alpha)*0.1;
			light_scale += (0.95 - light_scale)*0.1;
		}
		else
		{
			light_timer = 0;
		}
		
		if (!audio_is_playing(sfx_idle))
		{
			sfx_idle = play_sound_pos(fire_sfx,true,0.1,x,y-32,96,true,-4,-4);
		}
		else
		{
			gain_sound_pos(sfx_idle,light_alpha*0.1,x,y-32,96);
		}
		
		
		//불 이펙트 생성
		if (global.graphics_quality >= 2 && percentage_k(5))
		{
			var tmp_color = [ #DD4C4C,#FFAC4B, #0BE5C4,#D9FFDE ];
			var tmp_ins = create_bubble_effect(x+irandom_range(-16,16),y-fire_yy[image_index]-32,1,tmp_color[fire_type*2],tmp_color[fire_type*2+1],0.08,-irandom_range(6,12),irandom_range(-2,2),0.03,0,true,-y-1);
			tmp_ins.image_xscale = 0.7*fire_scale[image_index];
			tmp_ins.image_yscale = 0.7*fire_scale[image_index];
		}
	}
	else
	{
		if (audio_is_playing(sfx_idle))
		{
			audio_stop_sound(sfx_idle);
		}
	}
}