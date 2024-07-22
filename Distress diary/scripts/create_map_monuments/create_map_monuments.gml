// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param seed
function create_map_monuments(argument0)
{
	for(var i = 0; i < global.map_height; i++;)
	{
		for(var ii = 0; ii < global.map_width; ii++;)
		{
			random_set_seed(argument0);
			//0 - 빈방 / 1 - 퍼즐방 / 2 - 습격방 / 3 - 세이프존 / 4 - 아케이드방
			var tmp_room_type = global.map_room_type[i][ii];
			
			if (tmp_room_type > 0)
			{
				var tmp_room_width = global.map_room_width[i][ii], tmp_room_height = global.map_room_height[i][ii];
			
				if (tmp_room_type == 1) //1 - 퍼즐방
				{
					//퍼즐 방 생성
					var tmp_ins = instance_create_depth(x,y,0,obj_generation_puzzle);
					tmp_ins.xpos = ii;
					tmp_ins.ypos = i;
					
					//방 크기 설정
					tmp_room_width = 12;
					tmp_room_height = 7;
				}
				else if (tmp_room_type == 2) //2 - 습격방
				{
					//방 크기 설정
					tmp_room_width = 18;
					tmp_room_height = 18;
				}
				else if (tmp_room_type == 3) //3 - 세이프존
				{
					//방 크기 설정
					tmp_room_width = 11;
					tmp_room_height = 6;
				}
				else if (tmp_room_type == 4) //4 - 아케이드방
				{
					//아케이드 PC 생성
					var rd_spawn_num = irandom_range(1,instance_number(obj_player)+choose(0,0,0,1));
					for(var k = 0; k < rd_spawn_num; k++)
					{
						while(true)
						{
							var tmp_xx = room_width*0.5+irandom_range(-3,3)*96;
							var tmp_yy = room_height*0.5-96;
							if (!position_meeting(tmp_xx,tmp_yy,obj_parents))
							{
								instance_create_multiplayer(obj_arcade_pc,tmp_xx,tmp_yy,global.object_id_ind,47,true,ii,i);
								break;
							}
						}
					}
					
					//방 크기 설정
					tmp_room_width = 11;
					tmp_room_height = 6;
				}
			
			
				//방 사이즈 설정
				global.map_room_width[i][ii] = tmp_room_width;
				global.map_room_height[i][ii] = tmp_room_height;
				

				show_debug_message("구조물 생성중... ["+string(ii)+", "+string(i)+"]");
			}
			
			//라이트 오브젝트 생성
			for(var k = 0; k < 4; k ++)
			{
				var dx = [ 1, 0, -1, 0 ];
				var dy = [ 0, -1, 0, 1 ];
				var t_xx = ii+dx[k];
				var t_yy = i+dy[k];
				
				var is_connected = 0;
				if (is_inside_array(global.map_width,t_xx) && is_inside_array(global.map_height,t_yy))
				{
					//이동 예정인 룸이 현재 룸과 연결되어 있는지 체크
					var is_connected = 0;
					var condition1 = (global.room_connected_to_xx[t_yy][t_xx] == ii && global.room_connected_to_yy[t_yy][t_xx] == i);
					var condition2 = (global.room_connected_to_xx[i][ii] == t_xx && global.room_connected_to_yy[i][ii] == t_yy);
					var condition3 = (global.room_connected_to_xx_sec[t_yy][t_xx] == ii && global.room_connected_to_yy_sec[t_yy][t_xx] == i);
					var condition4 = (global.room_connected_to_xx_sec[i][ii] == t_xx && global.room_connected_to_yy_sec[i][ii] == t_yy);
					if (condition1 || condition2 || condition3 || condition4)
					{
						is_connected = 1;
					}
				}

		
				//옆 방 이동 가능한 경우
				if (is_connected == 1)
				{
					var tmp_scale = 2; //wall_parents의 image_scale (플레이어가 현재 2배 사이즈라서 2배 해줌)
					var tmp_sprite_size = 48*tmp_scale; //obj_wall_parents의 스프라이트 사이즈
					var tmp_r_w = global.map_room_width[i][ii]*0.5*tmp_sprite_size, tmp_r_h = global.map_room_height[i][ii]*0.5*tmp_sprite_size;
					var dx = [ tmp_r_w-120, 0, -tmp_r_w+120, 0 ];
					var dy = [ 16, -tmp_r_h+50, 16, tmp_r_h ];
					var tmp_img_ang = k*90;
					
					for(var kk = 0; kk < 2; kk++)
					{
						if (percentage_k(50))
						{
							var tmp_xx = room_width*0.5-48+dx[k] + ((k%2 == 1) ? sign(kk-0.5)*144 : 0);
							var tmp_yy = room_height*0.5+dy[k] + ((k%2 == 0) ? sign(kk-0.5)*144 : 0);

							var tmp_ins = instance_create_multiplayer(obj_ineractable_fire,tmp_xx,tmp_yy,global.object_id_ind,(k%2 == 0) ? ((k == 0) ? 5 : 4) : 0,true,ii,i);
							tmp_ins.is_opened = percentage_k(70);
							tmp_ins.fire_type = (global.n_room_tileset == 0 || global.n_room_tileset == 1) ? 1 : 0; //타일셋에 따라 다른 종류의 불꽃 세팅
						}
					}
				}
			}
		}
	}
}