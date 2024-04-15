/// @description Insert description here
// You can write your code in this editor



//외곽선 효과
if (global.graphics_quality > 0 && surface_exists(bubble_surf))
{
	var xx = camera_get_view_x(view_camera[0]);
	var yy = camera_get_view_y(view_camera[0]);
	
	draw_surface_ext(bubble_surf,xx,yy,1,1,0,#17111A,1);
}