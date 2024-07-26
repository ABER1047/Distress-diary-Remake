/// @description Insert description here
// You can write your code in this editor
if (image_alpha > 0)
{
	draw_sprite_ext(sprite_index,(door_appeared) ? 1+global.n_room_tileset : door_appeared,x,y,image_xscale,image_yscale,0,c_white,1);
}