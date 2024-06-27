
// this function is only used for step event


///@param col
///@param alpha
///@param scale
///@param x
///@param y
///@param [spr_ind]
function c_light(col = c_white, alpha = 1, scale = 1, xx_ = x, yy_ = y, spr_ind = spr_grad_circle)
{
	if (surface_exists(global.light_surf))
	{
		var xx = camera_get_view_x(view_camera[0]);
		var yy = camera_get_view_y(view_camera[0]);
		surface_set_target(global.light_surf);
		gpu_set_blendmode(bm_add);
		for(var i = 1; i <= (global.graphics_quality+1); i++)
		{
			draw_sprite_ext(spr_ind,0,xx_-xx,yy_-yy,scale/i,scale/i,0,merge_color(col,c_white,0.5),alpha);
		}
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
	}
}