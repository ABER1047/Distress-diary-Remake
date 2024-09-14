/// @description Insert description here
// You can write your code in this editor

if (!stop_cal_by_pos_statement)
{
	if (place_meeting(x,y,global.my_player_ins_id[global.my_player_id]))
	{
		global.smoke_color = image_blend;
		global.smoke_alpha += (1 - global.smoke_alpha)*0.03;
		//show_message_log("////"+string(global.smoke_alpha));
	}
}