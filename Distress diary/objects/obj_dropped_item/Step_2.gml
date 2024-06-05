/// @description Insert description here
// You can write your code in this editor



//아이템 획득
if (!stop_cal_by_pos_statement && z == 0)
{
	floating_animation += 0.03;
	
	var tmp_ins = instance_place(x,y,obj_player);
	if (instance_exists(tmp_ins))
	{
		if (touched == -4)
		{
			touched = tmp_ins;
			var is_empty = find_empty_pos(sprite_index,image_index,1,1,1,tmp_ins);
			if (is_empty)
			{
				set_inv_variable(tmp_ins,global.inv_empty_xpos,global.inv_empty_ypos,sprite_index,image_index,1,global.inv_empty_rotated,1);
				instance_destroy();
			}
			else
			{
				show_message_log("자리가 부족합니다!");
			}
		}
	}
	else
	{
		touched = -4;
	}
}