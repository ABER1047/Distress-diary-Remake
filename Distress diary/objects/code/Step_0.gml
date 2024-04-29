/// @description Insert description here
// You can write your code in this editor





//새로운 방 방문 (= 플레이어가 적정 선 이상 이동시 방 문 닫기)
if (global.can_check_room_cleared)
{
	var tmp_my_p = global.my_player_ins_id[global.my_player_id];
	if (instance_exists(tmp_my_p))
	{
		var tmp_xx = global.n_player_room_xx[global.my_player_id];
		if (tmp_xx != -4)
		{
			var tmp_yy = global.n_player_room_yy[global.my_player_id];
			if (global.visited_new_room)
			{
				//방 문을 닫기 전에 먼저 해당 룸이 클리어 된 상태인지 체크
				if (check_is_room_cleared())
				{
					global.visited_new_room = false;
					global.can_check_room_cleared = false;
					alarm[0] = 10;
				}
				else
				{
					// 플레이어가 적정 선 이상 이동시 방 문 닫기
					if (point_distance(global.f_pos_xx,global.f_pos_yy,tmp_my_p.x,tmp_my_p.y) > 32)
					{
						//방 정보 보내기
						send_SpecificPosRoomData(tmp_xx,tmp_yy);
						global.visited_new_room = false;
						global.can_check_room_cleared = false;
						alarm[0] = 10;
					}
				}
			}
			else
			{
				//클리어 판정 체크 후 방 오픈
				if (global.map_arr[tmp_yy][tmp_xx] >= 3 && check_is_room_cleared())
				{
					global.can_check_room_cleared = false;
					global.map_arr[tmp_yy][tmp_xx] = 2;
					send_SpecificPosRoomData(tmp_xx,tmp_yy);
				}
			}
		}
	}
}