// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@desc create_map()
///@param start_xx
///@param start_yy
///@param width
///@param height
///@param max_root_length
///@param max_room_width
///@param max_room_height
///@param additional_room_percentage
///@param max_room_num
///@param min_room_width
///@param min_room_height


function create_map(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10)
{
	global.n_player_room_xx = [ -4, -5, -6, -7, -8, -9 ];
	global.n_player_room_yy = [ -4, -5, -6, -7, -8, -9 ];
	
	global.map_creation_falied = 0;
	global.n_room_num = 0;
	
	//행 = height, 열 = width
	global.map_width = argument2;
	global.map_height = argument3;
	
	//추가 방 연결 확률
	global.room_connection_percentage = argument7;
	
	//루트 최대 길이
	global.max_root_length = argument4;
	
	//스타트 지점
	global.map_start_pos_xx = (is_inside_array(argument2,argument0)) ? argument0 : irandom_range(0,argument2);
	global.map_start_pos_yy = (is_inside_array(argument3,argument1)) ? argument1 : irandom_range(0,argument3);
	
	//현재 내 플레이어 위치 (룸)
	global.n_player_room_xx[global.my_player_id] = global.map_start_pos_xx;
	global.n_player_room_yy[global.my_player_id] = global.map_start_pos_yy;
	
	//방의 최대 넓이 지정
	global.max_room_width = argument5;
	global.max_room_height = argument6;
	
	//방 갯수
	global.max_room_num = argument8;
	
	//최소 방 넓이
	global.min_room_width = argument9;
	global.min_room_height = argument10;
	
	
	//맵 배열 초기화
	reset_map_arraies();
	

	//처음 시작 위치에 방 생성
	create_room_specific_pos(global.map_start_pos_xx,global.map_start_pos_yy,1);
	
	
	//룸 생성 알고리즘
	repeat(2)
	{
		create_map_room(global.map_start_pos_xx,global.map_start_pos_yy);
	}
	
	
	//룸 연결 알고리즘
	create_room_connection();
	
	
	//맵 생성 실패 감지
	if (global.n_room_num <= 1)
	{
		global.map_creation_falied = 1;
	}
}