// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param x
///@param y
///@param col
///@param id
///@param text
///@param [size]

function display_texts(argument0,argument1,argument2,argument3,argument4,argument5)
{
	var tmp_depth = -(argument1+16);
	var tmp_ins_for_depth = argument3;
	if (instance_exists(tmp_ins_for_depth))
	{
		tmp_depth = argument3.depth-32;
	}
	
	var tmp_ins = instance_create_depth(argument0,argument1,tmp_depth,obj_text_display);
	tmp_ins.image_blend = argument2;
	tmp_ins.animation = 0;
	
	var tmp_text = argument4;
	if (tmp_text != "@rune!")
	{
		tmp_ins.text = tmp_text;
	}
	else
	{
		tmp_ins.text = "";
		tmp_ins.sprite_index = spr_rune_letter;
		tmp_ins.image_index = irandom_range(0,sprite_get_number(spr_rune_letter)-1);
	}
	
	if (argument5 != undefined)
	{
		var tmp_size = argument5;
		tmp_ins.image_xscale = tmp_size;
		tmp_ins.image_yscale = tmp_size;
	}
	
	return tmp_ins;
}