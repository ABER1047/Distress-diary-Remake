/// @description width/height/rorated setting
// You can write your code in this editor

if (instance_exists(parents_id))
{
	//아이템 회전 된 경우
	var tmp_xscale = item_width;
	var tmp_yscale = item_height;
	if (item_rotated == 1)
	{
		tmp_xscale = item_height;
		tmp_yscale = item_width;
	}


	//이미지 스케일 조정
	if (tmp_n_camera_zoom != global.n_camera_zoom)
	{
		var slot_size = 160*global.n_camera_zoom; //1칸당 픽셀 사이즈
		image_xscale = slot_size/sprite_get_width(sprite_index)*tmp_xscale; //아이템 회전 적용된 길이
		image_yscale = slot_size/sprite_get_height(sprite_index)*tmp_yscale; //아이템 회전 적용된 길이
		tmp_n_camera_zoom = global.n_camera_zoom;
		image_angle = -90*item_rotated; //아이템 회전 적용된 앵글
	}
}









