
// this function is only used for step event


///@param col
///@param alpha
///@param scale
function c_light(col = c_white, alpha = 1, scale = 1)
{
	if (surface_exists(global.light_surf))
	{
		var xx = camera_get_view_x(view_camera[0]);
		var yy = camera_get_view_y(view_camera[0]);
		surface_set_target(global.light_surf);
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(spr_grad_circle,0,x-xx,y-yy,scale,scale,0,col,alpha)
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
	}
}