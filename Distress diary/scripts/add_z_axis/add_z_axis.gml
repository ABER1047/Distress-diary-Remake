// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_z_axis()
{
	if (!variable_instance_exists(id,"z"))
	{
		z = 0;
	}
	if (!variable_instance_exists(id,"zspeed"))
	{
		zspeed = 0;
	}
	zgravity = 0;
}