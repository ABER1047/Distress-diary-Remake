// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@desc create_room_specific_pos()
///@param x
///@param y
///@param connection_num
function create_room_specific_pos(argument0,argument1,argument2)
{
	//랜덤 방 종류 지정용 변수
	var tmp_room_type;
	
	
	//방 생성 (global.map_arr에 저장된 값은 시작 루트로 부터 끝 루트까지의 거리를 나타냄)
	global.map_arr[argument1][argument0] = argument2;
	show_debug_message("map_arr_ ("+string(argument0)+","+string(argument1)+") - "+string(global.map_arr[argument1][argument0]));
					
	//각 방에 대한 방 넓이
	//첫 방 사이즈는 동일한 사이즈로 생성 
	var tmp_room_width, tmp_room_height;
	if (argument0 == global.map_start_pos_xx && argument1 == global.map_start_pos_yy)
	{
		//방 종류 지정
		tmp_room_type = 3;
		
		tmp_room_width = 7;
		tmp_room_height = 7;
	}
	else
	{
		//방 종류 지정
		//0 - 빈방 / 1 - 퍼즐방 / 2 - 습격방 / 3 - 세이프존 / 4 - 아케이드방
		tmp_room_type = choose(0,0,0,0,0,0,1,2,3,4)
		
		tmp_room_width = irandom_range(global.min_room_width,global.max_room_width);
		tmp_room_height = irandom_range(global.min_room_height,global.max_room_height);
	}

	
	//방 종류 지정
	global.map_room_type[argument1][argument0] = tmp_room_type;
	
	
	
	
	//방 사이즈 설정
	global.map_room_width[argument1][argument0] = tmp_room_width;
	global.map_room_height[argument1][argument0] = tmp_room_height;
	
	//총 룸 갯수
	global.n_room_num ++;
}