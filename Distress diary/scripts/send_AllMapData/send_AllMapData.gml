// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_AllMapData()
{
	show_message_log("- 맵 데이터 전송 중...");
	
	buffer_seek(global.map_data_buffer, buffer_seek_start, 0);
	buffer_write(global.map_data_buffer, buffer_u8, global.DATA_NEW_MAP_DATA);
	buffer_write(global.map_data_buffer, buffer_string, global.my_player_id);
	
	//맵 시드 전송
	buffer_write(global.map_data_buffer, buffer_string, global.is_map_exists);
	send_all(global.map_data_buffer);
	
	show_message_log("- 맵 데이터 전송 완료");
}