/// @description Insert description here
// You can write your code in this editor

if (instance_exists(parent_id))
{
	depth = parent_id.depth+21;
}
else
{
	if (child_num == 0)
	{
		instance_destroy();
	}
}



if (global.graphics_quality > 0 && surface_exists(bubble_surf))
{
	//외곽선 효과
	var xx = camera_get_view_x(view_camera[0]);
	var yy = camera_get_view_y(view_camera[0]);
	
	surface_set_target(bubble_surf);
	draw_clear_alpha(c_black,0);
	with(obj_bubble_effect)
	{
		if (parent_id == other.id && !sprite_exists(sprite_index))
		{
			draw_set_alpha(1);
			draw_set_color(c_white);
			draw_circle(x+hspeed-xx,y+vspeed-yy,(image_xscale+scale_for_outline)*32,false);
		}
	}
	surface_reset_target();
}