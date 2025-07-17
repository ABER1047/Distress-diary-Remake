/// @description Insert description here
// You can write your code in this editor
if (!stop_cal_by_pos_statement)
{
	if (dmg_cooltime == 0)
	{
		hp = max_hp;
	}
	
	if (_speed > 0)
	{
		image_index += _speed*0.015;
	}
	else
	{
		image_index += (0 - image_index)*0.1;
	}

	_speed += (0 - _speed)*0.1;
}
