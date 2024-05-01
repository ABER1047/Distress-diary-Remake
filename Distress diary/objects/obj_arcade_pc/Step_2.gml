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
		play_sound_pos(activate_sfx,false,0.3,x,y,256,false);
		
		if (global.my_player_ins_id[global.my_player_id] == is_opened)
		{
			var tmp_ui = instance_create_depth(x,y,depth,obj_ui_arcade_pc);
			tmp_ui.sprite_index = spr_pc_ui;
			tmp_ui.parent_id = id;
		}
		
		b_is_opened = is_opened;
	}


	if (is_opened != -4)
	{
		obj_animation_timer ++;
		if (obj_animation_timer >= 50)
		{
			display_img_ind ++;
			if (display_img_ind == 4)
			{
				display_img_ind = 1;
			}
			obj_animation_timer = 0;
		}
	}
	else
	{
		display_img_ind = 0;
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