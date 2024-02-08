/// @description Insert description here
// You can write your code in this editor


if (is_dragging_window && instance_number(obj_inv_ui) > 1)
{
	with(obj_inv_ui)
	{
		if (id != other.id)
		{
			depth = -999;
		}
	}
}
relative_x_pos = -4;
is_dragging_window = false;