/// @description Insert description here
// You can write your code in this editor

if (tmp_check)
{
	if (!hide_cursor)
	{
		draw_sprite_ext(sprite_index,(mouse_check_button(mb_left)) ? 3 : 2,x,y,image_xscale,image_yscale,25,c_white,image_alpha);
	}
	
	
	var tmp_ins_place = instance_place(x,y+16,obj_mob_parents);
	if (instance_exists(tmp_ins_place) && variable_instance_exists(tmp_ins_place,"max_hp"))
	{
		draw_text_kl_scale(x,y,string(show_enemy_hp_bar(tmp_ins_place,true))+"\n"+string(tmp_ins_place.hp)+"/"+string(tmp_ins_place.max_hp),64,-1,1,c_white,0,-1,font_normal,0.23,0.23,0,true);
	}
}

hide_cursor = false;


