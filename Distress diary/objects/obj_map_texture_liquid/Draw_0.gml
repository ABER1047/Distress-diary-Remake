/// @description Insert description here
// You can write your code in this editor
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);


//바닥 액체 그리기
if (surface_exists(global.liquid_on_floor_surf))
{
	if (global.graphics_quality > 1)
	{
		var dx = [ 0, -3, 0, 3 ];
		var dy = [ -3, 0, 3, 0 ];
		for(var i = 0; i < 4; i++)
		{
			draw_surface_ext(global.liquid_on_floor_surf,xx+dx[i],yy+dy[i],1,1,0,#17111A,1);
		}	
	}

	draw_surface(global.water_effect_surf,xx,yy);
}
