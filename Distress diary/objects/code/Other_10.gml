/// @description 서피스 리셋 후 재생성
// You can write your code in this editor

//서피스 전체 리셋
event_user(2);
var tmp_w = camera_get_view_width(view_camera[0])*1.1;
var tmp_h = camera_get_view_height(view_camera[0])*1.1;

global.light_surf = surface_create(tmp_w,tmp_h);
global.flashlight_surf = surface_create(tmp_w,tmp_h);
global.shadow_surf = surface_create(tmp_w,tmp_h);
	
//버블 이펙트 외곽선 효과용 서피스
global.bubble_surf = surface_create(tmp_w,tmp_h);
	
//바닥 액체 그리기용 서피스
global.liquid_on_floor_surf = surface_create(tmp_w,tmp_h);


global.outter_room_surf = surface_create(tmp_w,tmp_h);


if (surface_exists(application_surface))
{
	surface_resize(application_surface, tmp_w, tmp_h);
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
		bubble_surf = surface_create(tmp_w,tmp_h);
	}
}
















