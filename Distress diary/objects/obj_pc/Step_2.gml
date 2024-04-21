/// @description Insert description here
// You can write your code in this editor
if (!stop_cal_by_pos_statement)
{
	//인터렉션 키 드로우 용
	if (show_interaction_key > 0)
	{
		show_interaction_key -= 1;
	}




	//컴퓨터 전원 켜짐
	if (b_is_opened != is_opened)
	{
		//효과음 재생
		play_sound_pos(flash_light_sfx,false,0.1,x,y,256,false);
		play_sound_pos(activate_sfx,false,0.3,x,y,256,false);
		b_is_opened = is_opened;
	}


	if (is_opened == true)
	{
		obj_animation_timer ++;
		if (obj_animation_timer >= 50)
		{
			image_index ++;
			if (image_index == 51)
			{
				image_index = 48;
			}
			obj_animation_timer = 0;
		}
	}
	else
	{
		image_index = 47;
	}





	//벤딩머신 사운드 이펙트
	sfx_timer ++;
	if (sfx_timer > 45)
	{
		sfx = play_sound_pos(vending_machine_sfx,false,0.1,x,y,640,true);
		sfx_timer = 0;
	}

	if (sfx != -4)
	{
		gain_sound_pos(sfx,0.1,x,y,320);
	}
}