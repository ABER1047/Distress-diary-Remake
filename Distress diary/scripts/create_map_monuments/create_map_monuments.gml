// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_map_monuments()
{
	for(var i = 0; i < global.map_height; i++;)
	{
		for(var ii = 0; ii < global.map_width; ii++;)
		{
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
							var tmp_yy = room_width*0.5-96;
							if (!position_meeting(tmp_xx,tmp_yy,obj_parents))
							{
								instance_create_multiplayer(obj_arcade_pc,tmp_xx,tmp_yy,global.object_id_ind,47,false,ii,i);
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
				
				
				show_message_log("구조물 생성중... ["+string(ii)+", "+string(i)+"]");
			}
		}
	}
}