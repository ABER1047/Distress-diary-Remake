/// @description Insert description here
// You can write your code in this editor

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
statement_by_pos();


//깊이값 설정
depth = obj_map_texture_draw.depth-16;


//버튼 발판 밟기
if (is_cleared)
{
	image_index = s_img_ind+1;
}
else
{
	if (s_img_ind != -4)
	{
		var tmp_ins = instance_place(x,y,obj_mob_parents);
		if ((instance_exists(tmp_ins) && tmp_ins.z == 0) || place_meeting(x,y,obj_player_pushable_object))
		{
			var tmp_ind = s_img_ind+1;
			if (image_index != tmp_ind)
			{
				//효과음 재생
				play_sound_pos(button_sfx,false,0.3,x,y,640,false,-4,-4);
		
				image_index = tmp_ind;
			}
		}
		else
		{
			if (image_index != s_img_ind)
			{
				//효과음 재생
				play_sound_pos(button_sfx,false,0.3,x,y,640,false,-4,-4);
	
				image_index = s_img_ind;
			}
		}
	}
	
	if (s_img_ind == 56 && image_index == s_img_ind+1)
	{
		skip_puzzle_timer++;
		if (skip_puzzle_timer > 600)
		{
			with(obj_floor_button)
			{
				is_cleared = true;
			}
			skip_puzzle_timer = 0;
		}
	}
	else
	{
		skip_puzzle_timer = 0;
	}
}