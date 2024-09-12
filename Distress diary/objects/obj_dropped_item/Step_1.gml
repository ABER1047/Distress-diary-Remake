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
	
	var tmp_nearest_ins = instance_nearest(x,y,obj_player);
	if (instance_exists(tmp_nearest_ins) && tmp_nearest_ins.hp > 0)
	{
		var tmp_dis = point_distance(x,y,tmp_nearest_ins.x,tmp_nearest_ins.y);
		if (tmp_dis < 96 && tmp_dis > 32)
		{
			direction = point_direction(x,y,tmp_nearest_ins.x,tmp_nearest_ins.y);
			_speed = 16/(tmp_dis);
		}
	}
	
	var tmp_ins = instance_place(x,y,obj_player);
	if (instance_exists(tmp_ins) && tmp_ins.hp > 0 && tmp_ins.z == 0 && tmp_ins == global.my_player_ins_id[global.my_player_id])
	{
		if (touched != tmp_ins)
		{
			touched = tmp_ins;
			var tmp_chk = find_empty_pos_quickslot(sprite_index,image_index,stack_num);
			if (tmp_chk != -4)
			{
				set_quickslot_variable(tmp_chk[0],sprite_index,image_index,tmp_chk[1],get_rare_rate(id),startag);
				instance_destroy_multiplayer(id);
			}
			else
			{
				var has_empty_pos = find_empty_pos(sprite_index,image_index,item_width,item_height,stack_num,tmp_ins);
				if (has_empty_pos != false)
				{
					set_inv_variable(tmp_ins,global.inv_empty_xpos,global.inv_empty_ypos,sprite_index,image_index,stack_num,global.inv_empty_rotated,1,startag);
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