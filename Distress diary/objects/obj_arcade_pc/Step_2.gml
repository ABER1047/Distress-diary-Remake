/// @description Insert description here
// You can write your code in this editor


//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
statement_by_pos();


if (!stop_cal_by_pos_statement)
{
	//인터렉션 키 드로우 용
	if (show_interaction_key > 0)
	{
		show_interaction_key -= 1;
	}




	//다른사람이 상호작용 중인 경우, 상호작용 중이라고 정보 보내기
	if (b_is_opened != is_opened)
	{
		//효과음 재생
		play_sound_pos(activate_sfx,false,0.3,x,y,256,false,-4,-4);
		
		if (global.my_player_ins_id[global.my_player_id] == is_opened)
		{
			var tmp_ui = instance_create_depth(x,y,depth,obj_ui_arcade_pc);
			tmp_ui.parent_id = id;
		}
		
		
		send_InstanceVariableData(id,"is_opened");
		b_is_opened = is_opened;
	}


	//상호작용 중 일때
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
		sfx = play_sound_pos(vending_machine_sfx,false,0.1,x,y,640,true,-4,-4);
		sfx_timer = 0;
	}

	if (sfx != -4)
	{
		gain_sound_pos(sfx,0.1,x,y,320);
	}
}