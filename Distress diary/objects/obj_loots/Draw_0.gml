/// @description Insert description here
// You can write your code in this editor

//그림자 그리기
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,-image_yscale*0.85,image_angle,c_black,0.3)


//오브젝트 그리기
var tmp_alpha = image_alpha-opening_animation;
if (tmp_alpha > 0)
{
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,tmp_alpha)
}

if (opening_animation > 0)
{
	draw_sprite_ext(sprite_index,image_index+1,x,y,image_xscale,image_yscale,image_angle,image_blend,opening_animation)
}



//인터렉션 키 드로우 용
if (show_interaction_key > 0)
{
	//인터렉션 이름 드로우
	var txt_scale = 0.64*global.n_camera_zoom;
	var tmp_yy = y-192;
	draw_text_kl_scale(x-string_width(interaction_name_for_draw)*txt_scale*0.5,tmp_yy,string(interaction_name_for_draw),64,-1,image_alpha,c_white,0,-1,font_normal,txt_scale,txt_scale,0);
	
	//인터렉션 키 드로우
	draw_sprite_ext(spr_key_ui,interaction_key_real_ind_for_draw,x-string_width(interaction_name_for_draw)*txt_scale,tmp_yy+64*global.n_camera_zoom,txt_scale*2.5,txt_scale*2.5,0,c_white,image_alpha);
}








