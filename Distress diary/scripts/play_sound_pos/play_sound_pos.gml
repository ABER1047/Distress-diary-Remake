// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@param soundid
///@param loops
///@param volume
///@param x
///@param y
///@param max_dis
///@param DoNotSend
function play_sound_pos(argument0,argument1,argument2,argument3,argument4,argument5,argument6)
{
	var distance_ = fix_to_zero(1-point_distance(argument3,argument4,obj_camera.x,obj_camera.y)/argument5);
	
	
	if (!argument6 && !argument1)
	{
		buffer_seek(global.sfx_data_buffer, buffer_seek_start, 0);
		buffer_write(global.sfx_data_buffer, buffer_u8, global.DATA_SFX_DATA);
		buffer_write(global.sfx_data_buffer, buffer_string, global.my_player_id);
		buffer_write(global.sfx_data_buffer, buffer_string, audio_get_name(argument0));
		buffer_write(global.sfx_data_buffer, buffer_string, argument2);
		buffer_write(global.sfx_data_buffer, buffer_string, argument3);
		buffer_write(global.sfx_data_buffer, buffer_string, argument4);
		buffer_write(global.sfx_data_buffer, buffer_string, argument5);
		send_all(global.sfx_data_buffer);
	}
	
	
	return play_sound(argument0,argument1,argument2*distance_);
}