/// @description Insert description here
// You can write your code in this editor

is_dragging_window = is_inside_rectangle(mouse_x,mouse_y,startx,w_starty,endx,starty);
if (is_dragging_window)
{
	if (instance_number(obj_inv_ui) > 1)
	{
		depth = global.min_depth-11;
		global.min_depth = depth;
	}
	
	show_debug_message("global.min_depth : "+string(global.min_depth));
	
	//인벤토리 창 스택에 추가
	add_inv_stack(id);
}
