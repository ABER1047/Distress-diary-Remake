/// @description 비정상적으로 연결이 끊긴 플레이어 한사람 감지후 내보내기
// You can write your code in this editor

if (global.is_server)
{
	//각 플레이어 위치 저장할 변수
	var all_player_num = global.object_id_player_only;
	if (array_length(global.saved_players_xx) < all_player_num)
	{
		array_resize(global.saved_players_xx,all_player_num);
		array_resize(global.saved_players_yy,all_player_num);
	}

	var need_to_check_ping = true;
	var is_there_any_player_need_to_check = 60+global.tickrate*60; //다시 한 번 체크하는 시간이 저장됨
	var tmp_buffer = dis_buffer;
	with(obj_player)
	{
		var tmp_target_obj_id = obj_id_player_only-1;

		
		if (obj_id_player_only != 0) //서버 자신은 제외
		{
			//각 플레이어의 핑 계산용 변수
			global.users_ping[tmp_target_obj_id] = 1;

			
			//이전에 저장된 위치랑 지금 위치랑 계속 똑같은 경우
			if (global.saved_players_xx[tmp_target_obj_id] <= -5 || (x == global.saved_players_xx[tmp_target_obj_id] && y == global.saved_players_yy[tmp_target_obj_id]))
			{
				//핑 체크 한번 더 해야되는지
				need_to_check_ping = false;
				
				
				//튕겼다고 판단한 플레이어 내보내기
				if (global.saved_players_xx[tmp_target_obj_id] <= -5)
				{
					//show_message_log("- 비정상적으로 연결이 끊긴 플레이어 내보내는 중... ["+string(obj_id_player_only)+"]");
					global.saved_players_xx[tmp_target_obj_id] = -4;
					
					buffer_seek(tmp_buffer, buffer_seek_start, 0);
					buffer_write(tmp_buffer, buffer_u8, DATA.REMOVE_CLI);
					buffer_write(tmp_buffer, buffer_string, obj_id_player_only);
					send_all(tmp_buffer);
					
					//서버측에서는 위에 버퍼 보낸게 작동이 안되서 따로 코드 한번 더 써줌
					var pos = ds_list_find_index(global.client_num, obj_id_player_only);
					ds_list_delete(global.client_num, pos);
					
					
					//나간 플레이어가 해당 플레이어인 경우
					show_message_log("'"+string(nickname)+"'가 나갔습니다.");
					instance_destroy();
				}
				else
				{
					//튕긴사람 감지 시간을 [최대 핑 허용 범위x2] 만큼으로 설정 후 재감지 시도
					//(데이터가 왔다-갔다 하는 시간이니까 2배이며, 60프레임당 1초니까 1ms은 변수상 값으로 0.16을 의미함)
					//근데 이렇게 되면 너무 빨리 여러번 검사하는 문제가 있어서
					//최적화 상 실제 핑의 4배만큼 곱해서 시간을 설정함 (= 토탈 8배임)
					is_there_any_player_need_to_check = floor(global.maximum_ping_acception/5*4);
					//show_message_log("- 비정상적으로 연결이 끊긴 플레이어를 감지함! ["+string(obj_id_player_only)+"]");
					
					
					//-5인 경우 대답이 없으면 내보내버림 (대답이 돌아올 시 -5값이 x좌표값으로 다시 바뀜)
					global.saved_players_xx[tmp_target_obj_id] = -5;
					
					//나갔나 아닌가 검사용으로 데이터 보내보기 (핑 검사용으로도 쓰임)
					buffer_seek(tmp_buffer, buffer_seek_start, 0);
					buffer_write(tmp_buffer, buffer_u8, DATA.CHECK_PLAYING_NOW);
					buffer_write(tmp_buffer, buffer_string, obj_id_player_only);
					//클라이언트에게 계산된 각 플레이어 핑 보내기
					var tmp_arr_length = array_length(global.users_ping);
					buffer_write(tmp_buffer, buffer_string, tmp_arr_length);
					for(var i = 0; i < tmp_arr_length; i++)
					{
						buffer_write(tmp_buffer, buffer_string, global.users_ping[i]);
					}
					send_all(tmp_buffer);
				}
			}
			else
			{
				global.saved_players_xx[tmp_target_obj_id] = x;
				global.saved_players_yy[tmp_target_obj_id] = y;
			}
		}
	}
	
	
	//나갔나 아닌가 검사용으로 데이터 보내보기 (핑 검사용으로도 쓰임)
	if (need_to_check_ping)
	{
		buffer_seek(tmp_buffer, buffer_seek_start, 0);
		buffer_write(tmp_buffer, buffer_u8, DATA.CHECK_PLAYING_NOW);
		buffer_write(tmp_buffer, buffer_string, 0);
		//클라이언트에게 계산된 각 플레이어 핑 보내기
		var tmp_arr_length = array_length(global.users_ping);
		buffer_write(tmp_buffer, buffer_string, tmp_arr_length);
		for(var i = 0; i < tmp_arr_length; i++)
		{
			buffer_write(tmp_buffer, buffer_string, global.users_ping[i]);
		}
		send_all(tmp_buffer);
	}


	show_message_log("- 비정상적으로 연결이 끊긴 플레이어 체크 중... ("+string(floor(is_there_any_player_need_to_check/60))+"초 후 재시도)");

	//튕겼다고 판단된 플레이어가 있을 경우 빠르게 진짜로 튕겼나 다시 한 번 체크
	alarm[0] = is_there_any_player_need_to_check;
}







