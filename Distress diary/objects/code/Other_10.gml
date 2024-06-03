/// @description surf reset
// You can write your code in this editor

//서피스 전체 리셋
surf_free_all();


global.light_surf = surf_cre(3840,2160);
global.flashlight_surf = surf_cre(3840,2160);
global.shadow_surf = surf_cre(3840,2160);
	
//버블 이펙트 외곽선 효과용 서피스
global.bubble_surf = surf_cre(3840,2160);
	
//바닥 액체 그리기용 서피스
global.liquid_on_floor_surf = surf_cre(3840,2160);


outter_room_surf = surf_cre(3840,2160);


if (surface_exists(application_surface))
{
	surface_resize(application_surface, window_get_width(), window_get_height());
}

//아이템 이미지 scale 재설정
with(obj_inv_item)
{
	tmp_n_camera_zoom = -4;
}


//버블 이펙트 외곽선 효과용 서피스
with(tmp_bubble_outline_effect)
{
	if (object_index == tmp_bubble_outline_effect)
	{
		bubble_surf = surf_cre(3840,2160);
	}
}















