/// @description surf reset
// You can write your code in this editor
if (!surface_exists(global.light_surf))
{
	global.light_surf = surface_create(3840,2160);
	global.flashlight_surf = surface_create(3840,2160);
	global.shadow_surf = surface_create(3840,2160);
	
	//버블 이펙트 외곽선 효과용 서피스
	global.bubble_surf = surface_create(3840,2160);
	
	//바닥 액체 그리기용 서피스
	global.liquid_on_floor_surf = surface_create(3840,2160);
}

if (!surface_exists(outter_room_surf))
{
	outter_room_surf = surface_create(3840,2160);
}

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
		bubble_surf = surface_create(3840,2160);
	}
}















