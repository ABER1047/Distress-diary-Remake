// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_NewMapData()
{
	show_message_log("- 맵 데이터 전송 중...");
	
	buffer_seek(global.map_data_buffer, buffer_seek_start, 0);
	buffer_write(global.map_data_buffer, buffer_u8, global.DATA_NEW_MAP_DATA);
	buffer_write(global.map_data_buffer, buffer_string, global.my_player_id);
	
	//맵 시드 전송
	buffer_write(global.map_data_buffer, buffer_string, global.is_map_exists);
	
	//최대 루트 길이
	buffer_write(global.map_data_buffer, buffer_string, global.max_root_length);
	

	//행 = height, 열 = width
	buffer_write(global.map_data_buffer, buffer_string, global.map_width);
	buffer_write(global.map_data_buffer, buffer_string, global.map_height);
	
	//스타트 지점
	buffer_write(global.map_data_buffer, buffer_string, global.map_start_pos_xx);
	buffer_write(global.map_data_buffer, buffer_string, global.map_start_pos_yy);
	
	
	//전체 룸 갯수
	buffer_write(global.map_data_buffer, buffer_string, global.n_room_num);


	for(var i = 0; i < global.map_height; i++;)
	{
		for(var ii = 0; ii < global.map_width; ii++;)
		{
			//map_arr = 0 일때 방이 없음 / 1일때 방 존재
			buffer_write(global.map_data_buffer, buffer_string, global.map_arr[i][ii]);
			
			//각 방에 대한 방 넓이
			buffer_write(global.map_data_buffer, buffer_string, global.map_room_width[i][ii]);
			buffer_write(global.map_data_buffer, buffer_string, global.map_room_height[i][ii]);
			
			//방 A와 연결되있는 방 B의 위치 인덱스
			buffer_write(global.map_data_buffer, buffer_string, global.room_connected_to_xx[i][ii]);
			buffer_write(global.map_data_buffer, buffer_string, global.room_connected_to_yy[i][ii]);
			
			//방 A와 연결되있는 방 B의 위치 인덱스 (2번째 연결)
			buffer_write(global.map_data_buffer, buffer_string, global.room_connected_to_xx_sec[i][ii]);
			buffer_write(global.map_data_buffer, buffer_string, global.room_connected_to_yy_sec[i][ii]);
		}
	}
	
	send_all(global.map_data_buffer);
	
	show_message_log("- 맵 데이터 전송 완료");
}