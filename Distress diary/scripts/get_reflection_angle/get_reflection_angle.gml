///@param x
///@param y
///@param dir
///@param projectile_size

function get_reflection_angle(argument0,argument1,argument2,argument3)
{
	var tmp_x = argument0, tmp_y = argument1;
	var tmp_size = argument3;
	var tmp_dir = argument2;
	
	
	var tmp_angle1 = direction - 5, tmp_angle2 = direction + 5;
	var tmp_get_x1 = -4, tmp_get_y1 = -4;
	var tmp_get_x2 = -4, tmp_get_y2 = -4;
	for(var i = 0; i < tmp_size; i++)
	{
		var tmp_x1 = tmp_x + lengthdir_x(tmp_size,tmp_angle1), tmp_y1 = tmp_y + lengthdir_y(tmp_size,tmp_angle1);
		var tmp_x2 = tmp_x + lengthdir_x(tmp_size,tmp_angle2), tmp_y2 = tmp_y + lengthdir_y(tmp_size,tmp_angle2);
		if (tmp_x1 == -4 && position_meeting(tmp_x1,tmp_y1,obj_wall_parents))
		{
			tmp_get_x1 = tmp_x1;
			tmp_get_y1 = tmp_y1;
		}
		
		if (tmp_x2 == -4 && position_meeting(tmp_x2,tmp_y2,obj_wall_parents))
		{
			tmp_get_x2 = tmp_x2;
			tmp_get_y2 = tmp_y2;
		}
		
		if (tmp_get_x1 != -4 && tmp_get_x2 != -4)
		{
			break;
		}
	}
	
	var tmp_wall_angle = point_direction(tmp_get_x1,tmp_get_y1,tmp_get_x2,tmp_get_y2);
	return angle_difference((tmp_wall_angle+tmp_dir)%360,180);
}