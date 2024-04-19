/// @description 네트워크상으로 위치 전송하기 위한 용도


var changed = false;
if (abs(vspeed) > 0.1)
{
	if (b_vspeed == -4)
	{
		send_InstanceVariableData(id,"vspeed");
		b_vspeed = vspeed;
		changed = true;
	}
}
else
{
	b_vspeed = -4;
}
	
if (abs(hspeed) > 0.1)
{
	if (b_hspeed == -4)
	{
		send_InstanceVariableData(id,"hspeed");
		b_hspeed = hspeed;
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
		send_InstanceVariableData(id,"zspeed");
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
	send_ImgData(obj_id,id,sprite_index,image_index,x,y,z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}


















