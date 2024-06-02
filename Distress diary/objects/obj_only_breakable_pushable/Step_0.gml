/// @description Insert description here
// You can write your code in this editor



if (!stop_cal_by_pos_statement)
{
	depth = -floor(y);
	
	//퍼즐맵 전용 오브젝트의 경우 발판 밟았을때 이미지 변경
	if (image_index == 7 || image_index == 8)
	{
		if (!place_meeting(x,y,obj_floor_button))
		{
			image_index = 7;
		}
		else
		{
			image_index = 8;
			//빛 이펙트 추가
			c_light(#5CC0F9, 1, 0.4);
		}
	}
}