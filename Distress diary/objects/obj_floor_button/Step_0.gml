/// @description Insert description here
// You can write your code in this editor


//깊이값 설정
depth = obj_map_texture_draw.depth-16;


//버튼 발판 밟기
if (s_img_ind != -4)
{
	if (place_meeting(x,y,obj_mob_parents) || place_meeting(x,y,obj_player_pushable_object))
	{
		var tmp_ind = s_img_ind+1;
		if (image_index != tmp_ind)
		{
			//효과음 재생
			play_sound_pos(button_sfx,false,0.3,x,y,640,false);
		
			image_index = tmp_ind;
		}
	}
	else
	{
		if (image_index != s_img_ind)
		{
			//효과음 재생
			play_sound_pos(button_sfx,false,0.3,x,y,640,false);
	
			image_index = s_img_ind;
		}
}
}