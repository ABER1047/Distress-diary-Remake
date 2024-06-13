/// @description Insert description here
// You can write your code in this editor
depth = obj_map_texture_draw.depth-8;


if (!stop_cal_by_pos_statement)
{
	var is_nearest_player_exists = false;
	with(obj_player)
	{
		if (!stop_cal_by_pos_statement && point_distance(other.x,other.y-48,x,y) <= 60)
		{
			is_nearest_player_exists = true;
			
			//데미지 입히기
			if (other.image_index > 1 && z == 0)
			{
				give_damage(id,9,false,4,x,y-48,60);
			}
		}
	}
	
	//트랩 작동됨
	if (is_nearest_player_exists)
	{
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