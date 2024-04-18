/// @description Insert description here
// You can write your code in this editor


if (speed > 0)
{
	image_index += speed*0.015;
}
else
{
	image_index += (0 - image_index)*0.1;
}


//타깃팅된 플레이어 따라가기
var max_speed = 15;
if (instance_exists(targeted))
{
	tracking_timer ++;
	
	if (tracking_timer > 15)
	{
		var tmp_dir = point_direction(x,y,targeted.x,targeted.y);
		var tmp_cal = tmp_dir - direction;
		var tmp_scale = abs(image_xscale);
		tracking_dir = tmp_dir;
		image_xscale = (tmp_dir >= 90 && tmp_dir < 270) ? tmp_scale : -tmp_scale;
		tracking_timer = 0;
	}
}
else
{
	max_speed = 0;
}

speed += (max_speed - speed)*0.1;
var tmp_dis = angle_difference(direction,tracking_dir);
direction -= tmp_dis*0.1;
