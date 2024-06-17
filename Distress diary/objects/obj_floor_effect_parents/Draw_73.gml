/// @description Insert description here
// You can write your code in this editor

if (global.show_wall_hitbox)
{
	draw_sprite_ext(spr_explosion,0,x,y,image_xscale,image_yscale,0,c_white,0.5);


	draw_set_alpha(1);
	draw_set_color(c_red);
	draw_circle(x,y,4,false);
}