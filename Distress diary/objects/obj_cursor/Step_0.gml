/// @description Insert description here
// You can write your code in this editor
x = mouse_x;
y = mouse_y;

var tmp_cursor_exists = instance_exists(tmp_cursor_sec);
var tmp_room_xx = room_width*0.5;
var tmp_room_yy = room_height*0.5;
var tmp_wall_scale = 2;
var tmp_wall_sprite_size = tmp_wall_scale*48;
var tmp_xx1_surf = tmp_room_xx-global.n_room_width*0.5*tmp_wall_sprite_size-48;
var tmp_yy1_surf = tmp_room_yy-global.n_room_height*0.5*tmp_wall_sprite_size;
var tmp_xx2_surf = tmp_room_xx+global.n_room_width*0.5*tmp_wall_sprite_size-48;
var tmp_yy2_surf = tmp_room_yy+global.n_room_height*0.5*tmp_wall_sprite_size;
var is_mouse_outside_room = (mouse_x >= tmp_xx2_surf || mouse_x <= tmp_xx1_surf || mouse_y >= tmp_yy2_surf || mouse_y <= tmp_yy1_surf)
tmp_check = instance_exists(obj_ui_parents) || global.is_mouse_inside_quickslot || is_mouse_outside_room;
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

