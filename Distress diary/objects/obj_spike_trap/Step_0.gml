/// @description Insert description here
// You can write your code in this editor
depth = obj_map_texture_floor.depth-8;


if (!stop_cal_by_pos_statement)
{
	var is_nearest_player_exists = false;
	with(obj_player)
	{
		if (!stop_cal_by_pos_statement && point_distance(other.x,other.y-56,x,y) <= 60)
		{
			is_nearest_player_exists = true;
			
			//데미지 입히기
			if (other.image_index > 1 && z == 0)
			{
				give_damage(id,9,false,4,other.x,other.y-56,60);
			}
		}
	}
	
	//트랩 작동됨
	if (is_nearest_player_exists)
	{
		if (image_index == 0)
		{
			play_sound_pos(spike_trap_sfx,false,0.03,x,y,128,true,my_pos_xx,my_pos_yy);
		}
		
		if (image_index < 2)
		{
			image_index += 0.4;
		}
	}
	else
	{
		if (image_index > 0)
		{
			image_index -= 0.4;
		}
	}
}