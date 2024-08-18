/// @description Insert description here
// You can write your code in this editor
x = mouse_x;
y = mouse_y;

var tmp_cursor_exists = instance_exists(tmp_cursor_sec);
tmp_check = instance_exists(obj_ui_parents) || global.is_mouse_inside_quickslot;
if (!tmp_check)
{
	var ins_exists = instance_exists(interacion_ins_exists);
	if (ins_exists && interacion_ins_exists.show_interaction_key > 0)
	{
		depth = interacion_ins_exists.depth+0.1;
		
		if (tmp_cursor_exists)
		{
			instance_destroy(tmp_cursor_sec)
		}
	}
	else
	{
		interacion_ins_exists = -4;
		depth = -y;
		image_alpha = 0.6;
		if (!tmp_cursor_exists)
		{
			tmp_cursor_sec = instance_create_depth(x,y,depth,obj_cursor_sec);
		}
	}
}
else
{
	depth = global.min_depth-32;
	image_alpha = 1;
	if (tmp_cursor_exists)
	{
		instance_destroy(tmp_cursor_sec)
	}
}

