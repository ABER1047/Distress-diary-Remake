/// @description Insert description here
// You can write your code in this editor

//오브젝트 그리기
if (image_alpha > 0)
{
	draw_sprite_ext(sprite_index,image_index,x+draw_xx,y+draw_yy,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}


if (global.show_wall_hitbox && point_distance(x,y,global.my_player_ins_id[global.my_player_id].x,global.my_player_ins_id[global.my_player_id].y) <= 128)
{
	draw_text(x,y+64,string(my_pos_xx)+", "+string(my_pos_yy))
}