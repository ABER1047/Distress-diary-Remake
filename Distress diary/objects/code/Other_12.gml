/// @description 서피스 정리
// You can write your code in this editor


var tmp_surf = [ outter_room_surf, global.light_surf, global.flashlight_surf, global.shadow_surf, global.blood_surf, global.text_surf ];

for(var i = 0; i < array_length(tmp_surf); i++)
{
	if surface_exists(tmp_surf[i])
	{
		surface_free(tmp_surf[i]);
	}
}
