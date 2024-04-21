/// @description Insert description here
// You can write your code in this editor

if (!stop_cal_by_pos_statement)
{
	//인터렉션 키 드로우 용
	if (show_interaction_key > 0)
	{
		show_interaction_key -= 1;
	}



	obj_animation_timer ++;
	if (obj_animation_timer >= 360)
	{
		image_index += (obj_animation_timer%20 == 0) ? 1 : 0;
		if (image_index == 47)
		{
			image_index = 45;
		}
		obj_animation_timer -= 19;
		obj_animation ++;
	
		if (obj_animation > 4)
		{
			obj_animation_timer = 0;
			image_index = 44;
			obj_animation = 0;
		}
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