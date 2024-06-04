/// @description Insert description here
// You can write your code in this editor


//버블 이펙트 외곽선 효과용 서피스
if (global.graphics_quality > 0)
{
	bubble_surf = surface_create(3840,2160);
}

//해당 서피스를 이용중인 다른 오브젝트들 갯수
child_num = 0;


show_debug_message("tmp_bubble_outline_effect - created");