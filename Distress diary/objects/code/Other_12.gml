/// @description 서피스 올 리셋
// You can write your code in this editor


var tmp_surf = [ global.outter_room_surf, global.light_surf, global.flashlight_surf, global.shadow_surf, global.liquid_on_floor_surf, global.reflection_surf, global.water_effect_surf, global.fire_line_surf, global.map_ui_surf ];

for(var i = 0; i < array_length(tmp_surf); i++)
{
	if (surface_exists(tmp_surf[i]))
	{
		surface_free(tmp_surf[i]);
	}
}

//버블 이펙트 외곽선 효과용 서피스
with(tmp_bubble_outline_effect)
{
	if (surface_exists(bubble_surf))
	{
		surface_free(bubble_surf);
	}
}


//draw_circular_bar()함수용 서피스
for(var i = 0; i < array_length(global.circular_bar_surf); i++)
{
	surface_free(global.circular_bar_surf[i]);
}