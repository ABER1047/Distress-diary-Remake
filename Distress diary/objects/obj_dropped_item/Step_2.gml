/// @description Insert description here
// You can write your code in this editor


//아이템 애니메이션
if (image_xscale < 2)
{
	image_xscale += 0.05+power(image_xscale*0.5,2);
}
else
{
	image_xscale += (2 - image_xscale)*0.08;
}



//아이템 획득
if (!stop_cal_by_pos_statement && z == 0 && sprite_index != spr_none)
{
	floating_animation += 0.05;
	
	var tmp_ins = instance_place(x,y,obj_player);
	if (instance_exists(tmp_ins) && tmp_ins.hp > 0 && tmp_ins.z == 0 && tmp_ins == global.my_player_ins_id[global.my_player_id])
	{
		if (touched == -4)
		{
			touched = tmp_ins;
			var is_empty = find_empty_pos(sprite_index,image_index,item_width,item_height,stack_num,tmp_ins);
			if (is_empty)
			{
				set_inv_variable(tmp_ins,global.inv_empty_xpos,global.inv_empty_ypos,sprite_index,image_index,stack_num,global.inv_empty_rotated,1,startag);
				
				with(obj_inv_ui)
				{
					reload_inv = 1;
				}
				instance_destroy_multiplayer(id);
			}
			else
			{
				var tmp_chk = find_empty_pos_quickslot();
				if (tmp_chk != -4)
				{
					set_quickslot_variable(tmp_chk,sprite_index,image_index,stack_num,get_rare_rate(id),startag);
					instance_destroy_multiplayer(id);
				}
				else
				{
					show_message_log("자리가 부족합니다!");
				}
			}
		}
	}
	else
	{
		touched = -4;
	}
}



//5분뒤 삭제
des_timer ++;
if (des_timer > 3600*5 || des_timer < 0)
{
	instance_destroy_multiplayer(id);
}