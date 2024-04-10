// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@desc create_map_room()
///@param x
///@param y
function create_map_room(argument0,argument1)
{
	var xx = [ -1, 0, 1, 0 ];
	var yy = [ 0, -1, 0, 1 ];
	//최대 방 갯수보다 방이 적은 경우
	show_debug_message("map_arr ("+string(argument0)+","+string(argument1)+") - "+string(global.map_arr[argument1][argument0]));
	if (global.map_arr[argument1][argument0] != 0 && global.n_room_num < global.max_room_num && global.map_arr[argument1][argument0] < global.max_root_length)
	{
		//DFS
		var failed = 0;
		while(true)
		{
			var target_i = irandom_range(0,3);
			var t_xx = argument0+xx[target_i]; //열
			var t_yy = argument1+yy[target_i]; //행
			
			
			//생성하려는 위치 인덱스가 배열 밖을 벗어나지 않는 경우
			if (is_inside_array(global.map_width,t_xx) && is_inside_array(global.map_height,t_yy))
			{
				show_debug_message("cre_room_"+string(global.n_room_num)+" / "+string(global.max_room_num)+"   /   "+string(global.map_arr[t_yy][t_xx]));
				//생성하려는 위치에 방이 존재하지 않는 경우
				if (global.map_arr[t_yy][t_xx] == 0)
				{
					//방 생성
					create_room_specific_pos(t_xx,t_yy,global.map_arr[argument1][argument0]+1);
					
					//방 A와 연결되있는 방 B의 위치 인덱스
					
					var tmp_check = true;;
					if (t_xx != global.map_start_pos_xx && t_yy != global.map_start_pos_yy)
					{
						tmp_check = true;
					}
					else if (global.create_only_one_enterance)
					{
						tmp_check = false;
					}
					
					if (tmp_check)
					{
						global.room_connected_to_xx[t_yy][t_xx] = argument0;
						global.room_connected_to_yy[t_yy][t_xx] = argument1;
					}
					
					create_map_room(t_xx,t_yy);
					break;
				}
			}
			failed ++;
			if (failed > 64)
			{
				global.map_creation_falied = 1;
				break;
			}
		}
	}
}