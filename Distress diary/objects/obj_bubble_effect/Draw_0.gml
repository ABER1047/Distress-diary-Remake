/// @description Insert description here
// You can write your code in this editor

if (sprite_exists(sprite_index))
{
	draw_self();
	if (image_index > 8)
	{
		instance_destroy();
	}
	
	image_angle -= hspeed*1.5;
}
else
{
	draw_set_color(image_blend);
	draw_set_alpha(image_alpha);
	draw_circle(x,y,image_xscale*32,false);
}

