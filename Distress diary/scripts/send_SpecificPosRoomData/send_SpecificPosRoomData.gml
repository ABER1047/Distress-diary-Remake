// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param xpos
///@param ypos
function send_SpecificPosRoomData(argument0,argument1)
{
	var tmp_xx = argument0;
	var tmp_yy = argument1;
	buffer_seek(global.map_data_buffer, buffer_seek_start, 0);
	buffer_write(global.map_data_buffer, buffer_u8, global.DATA_ROOM_DATA_SPECIFIC);
	buffer_write(global.map_data_buffer, buffer_string, global.my_player_id);
	buffer_write(global.map_data_buffer, buffer_string, tmp_xx);
	buffer_write(global.map_data_buffer, buffer_string, tmp_yy);
	buffer_write(global.map_data_buffer, buffer_string, global.map_arr[tmp_yy][tmp_xx]);
	send_all(global.map_data_buffer);
	
	
	return true;
}