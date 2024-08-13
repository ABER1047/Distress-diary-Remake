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
if (!stop_cal_by_pos_statement && z == 0 && sprite_exists(sprite_index))
{
	floating_animation += 0.03;
	
	var tmp_ins = instance_place(x,y,obj_player);
	if (instance_exists(tmp_ins) && tmp_ins.z == 0)
	{
		if (touched == -4)
		{
			touched = tmp_ins;
			var is_empty = find_empty_pos(sprite_index,image_index,item_width,item_height,stack_num,tmp_ins);
			if (is_empty)
			{
				set_inv_variable(tmp_ins,global.inv_empty_xpos,global.inv_empty_ypos,sprite_index,image_index,stack_num,global.inv_empty_rotated,1,startag);
				instance_destroy_multiplayer(id);
			}
			else if (tmp_ins == global.my_player_ins_id[global.my_player_id])
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



//5분뒤 삭제
des_timer ++;
if (des_timer > 3600*5 || des_timer < 0)
{
	instance_destroy_multiplayer(id);
}