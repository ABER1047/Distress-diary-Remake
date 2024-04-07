// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function z_axis_gravity()
{
	///////////////////////////for z///////////////////////////
	if (zspeed < 0 || zspeed_timer > 3)
	{
		z -= zspeed;
		zspeed += zgravity*9.81;
	}
	else
	{
		zspeed_timer ++;
	}

	if (z <= 0)
	{
		if (zspeed > 0)
		{
			zspeed = 0;
		}
		zgravity = 0;
		z = 0;
		zspeed_timer = 0;
	}
	else if (z > 0)
	{
		zgravity = 0.07;
	}
}