/// @description Insert description here
// You can write your code in this editor
for(var i = 0; i < image_xscale*0.5; i++)
{
	draw_sprite_ext(sprite_index,1+global.n_room_tileset,x+i*96,y-6,2,2,0,c_white,image_alpha);
}

if (image_yscale > 2)
{
	draw_sprite_ext(sprite_index,0,x,y+90,image_xscale,image_yscale-2,0,c_white,image_alpha);
}

