// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_map_monuments()
{
	for(var i = 0; i < global.map_height; i++;)
	{
		for(var ii = 0; ii < global.map_width; ii++;)
		{
			var tmp_room_type = global.map_room_type[i][ii];
			
			if (tmp_room_type > 0)
			{
				var tmp_room_width = global.map_room_width[i][ii], tmp_room_height = global.map_room_height[i][ii];
			
				if (tmp_room_type == 1)
				{
					//퍼즐 방 생성
					var tmp_ins = instance_create_depth(x,y,0,obj_generation_puzzle);
					tmp_ins.xpos = ii;
					tmp_ins.ypos = i;
					
					tmp_room_width = 9;
					tmp_room_height = 9;
				}
			
			
				//방 사이즈 설정
				global.map_room_width[i][ii] = tmp_room_width;
				global.map_room_height[i][ii] = tmp_room_height;
				
				
				show_message_log("구조물 생성중... ["+string(ii)+", "+string(i)+"]");
			}
		}
	}
}