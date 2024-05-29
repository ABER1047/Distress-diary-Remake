// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_speed_valuables()
{
	//속도 관련 변수
	_speed = 0;
	if (!variable_instance_exists(id,"_vspeed"))
	{
		_vspeed = 0;
	}
	if (!variable_instance_exists(id,"_hspeed"))
	{
		_hspeed = 0;
	}
}