// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function reset_map_arraies()
{
	for(var i = 0; i < global.map_height; i++;)
	{
		for(var ii = 0; ii < global.map_width; ii++;)
		{
			//map_arr = 0 일때 방이 없음 - 1일때는 방 존재(문 열림) - 2일때는 방 완전 클리어 - 3일때는 방 존재(문 닫힘)
			global.map_arr[i][ii] = 0;
			
			//방 종류
			//0 - 빈방 / 1 - 퍼즐방 / 2 - 습격방 / 3 - 세이프존 / 4 - 아케이드방 / 5 - 시크릿 방
			global.map_room_type[i][ii] = 0;
			
			
			//각 방에 대한 방 넓이
			global.map_room_width[i][ii] = 0;
			global.map_room_height[i][ii] = 0;
			
			//방 A와 연결되있는 방 B의 위치 인덱스
			global.room_connected_to_xx[i][ii] = -4;
			global.room_connected_to_yy[i][ii] = -4;
			
			//방 A와 연결되있는 방 B의 위치 인덱스 (2번째 연결)
			global.room_connected_to_xx_sec[i][ii] = -4;
			global.room_connected_to_yy_sec[i][ii] = -4;
		}
	}
}