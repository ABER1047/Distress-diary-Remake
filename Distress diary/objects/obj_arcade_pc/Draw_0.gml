/// @description Insert description here
// You can write your code in this editor


//오브젝트 그리기
if (image_alpha > 0)
{
	var tmp_y = y-24;
	draw_sprite_ext(sprite_index,image_index,x+draw_xx,tmp_y+draw_yy,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(spr_pc_ui_state,display_img_ind,x+draw_xx-2,tmp_y+draw_yy-82,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}




