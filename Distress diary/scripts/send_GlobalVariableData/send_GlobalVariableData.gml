// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@desc send_VariableData
///@param name
function send_GlobalVariableData(argument0)
{
	buffer_seek(global.variable_data_buffer, buffer_seek_start, 0);
	buffer_write(global.variable_data_buffer, buffer_u8, global.DATA_GL_VAR_DATA);
	buffer_write(global.variable_data_buffer, buffer_string, global.my_player_id);
	buffer_write(global.variable_data_buffer, buffer_string, argument0);
	buffer_write(global.variable_data_buffer, buffer_string, variable_global_get(argument0));
	send_all(global.variable_data_buffer);
}