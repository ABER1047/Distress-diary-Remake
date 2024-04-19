/// @description Insert description here
// You can write your code in this editor


//퍼즐맵 전용 오브젝트의 경우 발판 밟았을때 이미지 변경
if (image_index == 62 || image_index == 63)
{
	image_index = (place_meeting(x,y,obj_floor_button)) ? 63 : 62;
}