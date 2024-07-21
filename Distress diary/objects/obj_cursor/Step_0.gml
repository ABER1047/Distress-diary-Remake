/// @description Insert description here
// You can write your code in this editor
x = mouse_x;
y = mouse_y;

var tmp_cursor_exists = instance_exists(tmp_cursor_sec);
tmp_check = instance_exists(obj_ui_parents);
if (!tmp_check)
{
	image_xscale = 1.5;
	image_yscale = 1.5;
	depth = -y;
	image_alpha = 0.6;
	if (!tmp_cursor_exists)
	{
		tmp_cursor_sec = instance_create_depth(x,y,depth,obj_cursor_sec);
	}
}
else
{
	image_xscale = 0.9;
	image_yscale = 0.9;
	depth = global.min_depth-32;
	image_alpha = 1;
	if (tmp_cursor_exists)
	{
		instance_destroy(tmp_cursor_sec)
	}
}

