/// @description Insert description here
// You can write your code in this editor

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
statement_by_pos();


//깊이값 설정
depth = obj_map_texture_draw.depth-16;


//룸 클리어 되었나 체크
var is_room_cleared = (global.map_arr[my_pos_yy][my_pos_xx] == 1) ? true : false;



if (is_room_cleared)
{
	image_index = s_img_ind+1;
}
else
{
	//버튼 발판 밟기
	if (s_img_ind != -4)
	{
		var tmp_ins = instance_place(x,y,obj_mob_parents);
		if ((instance_exists(tmp_ins) && tmp_ins.z == 0) || place_meeting(x,y,obj_player_pushable_object))
		{
			var tmp_val = s_img_ind+1;
			if (image_index != tmp_val)
			{
				//효과음 재생
				play_sound_pos(button_sfx,false,0.3,x,y,640,false,-4,-4);
		
				image_index = tmp_val;
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
}