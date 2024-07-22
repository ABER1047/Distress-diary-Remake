// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param target_ins
///@param key[String]
///@param interaction_name
function draw_interaction_key(argument0,argument1,argument2)
{
	var tmp_ins = argument0;
	var tmp_interaction_key = argument1;
	var tmp_interaction_name = argument2;
	if (instance_exists(tmp_ins))
	{
		obj_cursor.interacion_ins_exists = tmp_ins;
		with(tmp_ins)
		{
			if (id == tmp_ins)
			{
				show_interaction_key = 2;
				interaction_name_for_draw = tmp_interaction_name;
		
				if (tmp_interaction_key == "Tab")
				{
					interaction_key_real_ind_for_draw = 3;
				}
				else if (tmp_interaction_key == "Shift")
				{
					interaction_key_real_ind_for_draw = 4;
				}
				else if (tmp_interaction_key == "ESC")
				{
					interaction_key_real_ind_for_draw = 7;
				}
				else if (tmp_interaction_key == "mb_r")
				{
					interaction_key_real_ind_for_draw = 8;
				}
				else
				{
					if (tmp_interaction_key == "F")
					{
						interaction_key_real_ind_for_draw = 0;
					}
					else if (tmp_interaction_key == "R")
					{
						interaction_key_real_ind_for_draw = 1;
					}
					else if (tmp_interaction_key == "G")
					{
						interaction_key_real_ind_for_draw = 2;
					}
					else if (tmp_interaction_key == "A")
					{
						interaction_key_real_ind_for_draw = 5;
					}
					else
					{
						interaction_key_real_ind_for_draw = 6;
					}
				}
			}
		}
	}
}