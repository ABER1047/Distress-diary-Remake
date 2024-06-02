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
		sfx = play_sound_pos(fire_turn_on_sfx,false,0.3,x,y,256,false,-4,-4);
		alarm[1] = 10;

		b_is_opened = is_opened;
		send_InstanceVariableData(id,"is_opened");
	}

	//이미지 설정
	image_index = s_img_ind+is_opened;

	
	//상호작용 중 일때
	if (is_opened)
	{
		light_timer ++;
		
		//라이트 효과
		c_light(light_col[image_index*0.5],light_scale*0.75,light_alpha);
		if (light_timer < 90)
		{
			light_alpha += (1 - light_alpha)*0.3;
			light_scale += (1 - light_scale)*0.3;
		}
		else if (light_timer < 120)
		{
			light_alpha += (0.8 - light_alpha)*0.1;
			light_scale += (0.95 - light_scale)*0.1;
		}
		else
		{
			light_timer -= irandom_range(90,120);
		}
	}
}