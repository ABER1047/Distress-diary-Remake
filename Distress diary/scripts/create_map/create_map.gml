// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@desc create_map()
///@param seed

function create_map(argument0)
{
	//맵에 있는 모든 오브젝트 삭제
	instance_destroy(obj_parents);
	
	//모든 발판 버튼 삭제
	instance_destroy(obj_floor_button);


	random_set_seed(argument0);
	var tmp_width = floor(9*(0.5+instance_number(obj_player)*0.5));
	var tmp_height = floor(9*(0.5+instance_number(obj_player)*0.5));
	var tmp_start_xx = floor(tmp_width/2);
	var tmp_start_yy = floor(tmp_height/2);
	var tmp_max_root = irandom_range(16,max(tmp_width,tmp_height)*choose(4,5,6))*instance_number(obj_player);
	var tmp_room_max_width = 24;
	var tmp_room_max_height = 24;
	var tmp_additional_room_cre_percentage = irandom_range(0,100);
	var tmp_total_room_num = irandom_range(25,floor(tmp_room_max_width*tmp_room_max_height/4))*instance_number(obj_player);
	var tmp_min_room_width = 7;
	var tmp_min_room_height = 7;
	
	global.object_id_ind = 256;
	
	global.enable_light_surf = true;
	global.create_only_one_enterance = false;
	
	global.map_creation_falied = 0;
	global.n_room_num = 0;
	
	//행 = height, 열 = width
	global.map_width = tmp_width;
	global.map_height = tmp_height;
	
	//추가 방 연결 확률
	global.room_connection_percentage = tmp_additional_room_cre_percentage;
	
	//루트 최대 길이
	global.max_root_length = tmp_max_root;
	
	//스타트 지점
	global.map_start_pos_xx = (is_inside_array(tmp_width,tmp_start_xx)) ? tmp_start_xx : irandom_range(0,tmp_width);
	global.map_start_pos_yy = (is_inside_array(tmp_height,tmp_start_yy)) ? tmp_start_yy : irandom_range(0,tmp_height);
	
	//현재 내 플레이어 위치 (룸)
	global.n_player_room_xx[global.my_player_id] = global.map_start_pos_xx;
	global.n_player_room_yy[global.my_player_id] = global.map_start_pos_yy;
	
	//모든 플레이어의 위치정보를 스타트 지점으로 초기화
	for(var i = 0; i < instance_number(obj_player); i++)
	{
		global.n_player_room_xx[i] = global.map_start_pos_xx;
		global.n_player_room_yy[i] = global.map_start_pos_yy;
	}
	
	//방의 최대 넓이 지정
	global.max_room_width = tmp_room_max_width;
	global.max_room_height = tmp_room_max_height;
	
	//방 갯수
	global.max_room_num = tmp_total_room_num;
	
	//최소 방 넓이
	global.min_room_width = tmp_min_room_width;
	global.min_room_height = tmp_min_room_height;
	
	
	//맵 배열 초기화
	reset_map_arraies();
	

	//처음 시작 위치에 방 생성
	create_room_specific_pos(global.map_start_pos_xx,global.map_start_pos_yy,1);
	
	
	//룸 생성 알고리즘
	repeat(2)
	{
		create_map_room(global.map_start_pos_xx,global.map_start_pos_yy);
		global.create_only_one_enterance = true;
	}
	
	
	//룸 연결 알고리즘
	create_room_connection();
	
	
	//맵 생성 실패 감지
	if (global.n_room_num <= 1)
	{
		show_message_log("- 맵 생성 실패! (재시도 중...)");
		failed_map_creation();
		global.n_camera_zoom = 0.7;
		
		randomize();
		global.is_map_exists = random_get_seed();
		create_map(global.is_map_exists);
	}
	else
	{
		show_message_log("- 맵 생성 정보");
		show_message_log("맵 시드 : "+string(global.is_map_exists));
		show_message_log("맵 크기 (width x height) : "+string(tmp_width)+" x "+string(tmp_height));
		show_message_log("루트 최대 길이 : "+string(tmp_max_root));
		show_message_log("룸 최대 크기 (width x height) : "+string(tmp_room_max_width)+" x "+string(tmp_room_max_height));
		show_message_log("룸 최소 크기 (width x height) : "+string(tmp_min_room_width)+" x "+string(tmp_min_room_height));
		show_message_log("추가 방 연결 확률 : "+string(tmp_additional_room_cre_percentage)+"%");
		show_message_log("방 갯수 : "+string(global.n_room_num)+"/"+string(tmp_total_room_num));
			
			
		//맵 내의 구조물 생성
		create_map_monuments(argument0);
			
			
		//현재 위치 (= 스타트 지점)에 대한 룸 정보 불러오기
		load_room(global.n_player_room_xx[global.my_player_id],global.n_player_room_yy[global.my_player_id]);
			
		show_message_log("- 맵 로드 완료");
		obj_player.x = room_width*0.5;
		obj_player.y = room_height*0.5;
									
		if (global.is_server)
		{
			code_m.alarm[4] = 30;
		}
			
		//카메라 줌 설정
		global.n_camera_zoom = 0.53;
		
		//라이트 서피스 설정
		global.enable_light_surf = true;
	}
}