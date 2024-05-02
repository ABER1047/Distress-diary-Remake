/// @description Insert description here
// You can write your code in this editor


if (is_dragging_window && instance_number(obj_inv_ui) > 1)
{
	with(obj_inv_ui)
	{
		if (id != other.id)
		{
			depth = obj_camera.depth-64;
		}
	}
}
relative_x_pos = -4;
if (is_dragging_window == true)
{
	is_dragging_window = false;
	is_drag_dropped = true;
}



//픽셀 깨지는거 방지용으로 창 위치 정수화
relative_x_pos = floor(relative_x_pos);
relative_y_pos = floor(relative_y_pos);
x_pos = floor(x_pos);
y_pos = floor(y_pos);
x = floor(x);
y = floor(y);