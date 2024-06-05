/// @description 네트워크상으로 위치 전송하기 위한 용도
if (global.is_server)
{
	var changed = false;
	if (abs(_vspeed) > 0.1)
	{
		if (b_vspeed == -4)
		{
			b_vspeed = _vspeed;
			changed = true;
		}
	}
	else
	{
		b_vspeed = -4;
	}
	
	if (abs(_hspeed) > 0.1)
	{
		if (b_hspeed == -4)
		{
			b_hspeed = _hspeed;
			changed = true;
		}
	}
	else
	{
		b_hspeed = -4;
	}
	
	if (abs(zspeed) > 0.1)
	{
		if (b_zspeed == -4)
		{
			b_zspeed = zspeed;
			changed = true;
		}
	}
	else
	{
		b_zspeed = -4;
	}

	if (changed)
	{
		send_InstanceMuchVariableData(id,"_zspeed, _vspeed, _hspeed");
		send_ImgData(obj_id,id,sprite_index,image_index,x,y,z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	}
	
	alarm[1] = global.tickrate*25;
}















