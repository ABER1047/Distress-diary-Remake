/// @description Insert description here
// You can write your code in this editor

draw_sprite_ext(spr_shadow,0,x,y,image_xscale,image_yscale,0,c_white,image_alpha*0.3);
draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);



draw_text_kl_scale(x,y-192,string(nickname)+"\nsoc : "+string(soc)+"\nobj_id : "+string(obj_id),64,-1,1,c_white,0,0,normal_font,0.4,0.4,0)