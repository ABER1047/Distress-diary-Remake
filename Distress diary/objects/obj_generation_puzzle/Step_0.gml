/// @description Insert description here
// You can write your code in this editor


//퍼즐방 클리어 판정
if (can_check_is_solved)
{
	var is_all_pressed = true;
	with(obj_floor_button)
	{
		if (image_index == s_img_ind)
		{
			is_all_pressed = false;
		}
	}

	if (is_all_pressed)
	{
		show_message_log("클리어!");
		instance_destroy(obj_g_puzzle_parents);
	}
}