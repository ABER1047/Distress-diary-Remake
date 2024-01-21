// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@desc create_room_connection()
function create_room_connection()
{
	var xx = [ -1, 0, 1, 0 ];
	var yy = [ 0, -1, 0, 1 ];
	for(var i = 0; i < global.map_height; i++;)
	{
		for(var ii = 0; ii < global.map_width; ii++;)
		{
			//현재 체크하는 위치에 룸이 존재하는 경우
			if (global.map_arr[i][ii] != 0)
			{
				var tmp_attempt = 0;
				while(percentage_k(global.room_connection_percentage))
				{
					var random_connection = irandom_range(0,3);
					var t_xx = ii+xx[random_connection];
					var t_yy = i+yy[random_connection];
					
					//생성하려는 위치 인덱스가 배열 밖을 벗어나지 않는 경우
					if (is_inside_array(global.map_width,t_xx) && is_inside_array(global.map_height,t_yy))
					{
						if (global.map_arr[t_yy][t_xx] != 0)
						{
							if (ii != global.room_connected_to_xx[t_yy][t_xx] && i != global.room_connected_to_yy[t_yy][t_xx] && t_xx != global.room_connected_to_xx[i][ii] && t_yy != global.room_connected_to_yy[i][ii])
							{
								if (ii != global.room_connected_to_xx_sec[t_yy][t_xx] && i != global.room_connected_to_yy_sec[t_yy][t_xx] && t_xx != global.room_connected_to_xx_sec[i][ii] && t_yy != global.room_connected_to_yy_sec[i][ii])
								{
									global.room_connected_to_xx_sec[t_yy][t_xx] = ii;
									global.room_connected_to_yy_sec[t_yy][t_xx] = i;
								}
							}
						}
					}
					
					tmp_attempt ++;
					if (tmp_attempt > 32)
					{
						show_message_log("룸 추가 연결 실패!");
						break;
					}
				}
			}
		}
	}
}