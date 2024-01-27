// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_MyRoomPos()
{
	buffer_seek(global.map_data_buffer, buffer_seek_start, 0);
	buffer_write(global.map_data_buffer, buffer_u8, global.DATA_MY_ROOM_POS);
	buffer_write(global.map_data_buffer, buffer_string, global.my_player_id);
	buffer_write(global.map_data_buffer, buffer_string, global.n_player_room_xx[global.my_player_id]);
	buffer_write(global.map_data_buffer, buffer_string, global.n_player_room_yy[global.my_player_id]);
	send_all(global.map_data_buffer);
}