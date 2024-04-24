// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_AllObjectData()
{
	buffer_seek(global.obj_data_buffer, buffer_seek_start, 0);
	buffer_write(global.obj_data_buffer, buffer_u8, global.DATA_OBJECTS_DATA_WHOLESCALE);
	buffer_write(global.obj_data_buffer, buffer_string, global.my_player_id);
	
	with(obj_parents)
	{
		if (id != other.id && object_index != obj_player)
		{
			//일반 오브젝트 정보 전송 (+상자류 오브젝트도 해당 부분은 공통적으로 보냄)
			buffer_write(global.obj_data_buffer, buffer_string, object_get_name(object_index));
			buffer_write(global.obj_data_buffer, buffer_string, obj_id);
			buffer_write(global.obj_data_buffer, buffer_string, x);
			buffer_write(global.obj_data_buffer, buffer_string, y);
			buffer_write(global.obj_data_buffer, buffer_string, image_index);
			buffer_write(global.obj_data_buffer, buffer_string, my_pos_xx);
			buffer_write(global.obj_data_buffer, buffer_string, my_pos_yy);
			
			
			if (object_index == obj_loots) //루팅 가능한 오브젝트(= 상자류) 정보 전송
			{
				buffer_write(global.obj_data_buffer, buffer_string, inv_width);
				buffer_write(global.obj_data_buffer, buffer_string, inv_height);
				buffer_write(global.obj_data_buffer, buffer_string, loots_name);
			
			
				var tmp_str = "";
				for(var i = 0; i < inv_height; i++)
				{
					for(var ii = 0; ii < inv_width; ii++)
					{
						//inv_info_spr_ind가
						//-4일때 = 비어있음
						//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
						var tmp_spr_name = (sprite_exists(inv_info_spr_ind[i][ii])) ? sprite_get_name(inv_info_spr_ind[i][ii]) : inv_info_spr_ind[i][ii];
						buffer_write(global.obj_data_buffer, buffer_string, tmp_spr_name); //spr_ind값 보유
						buffer_write(global.obj_data_buffer, buffer_string, inv_info_img_ind[i][ii]); //img_ind값 보유
						buffer_write(global.obj_data_buffer, buffer_string, inv_info_name[i][ii]); //아이템의 이름 값 보유
						buffer_write(global.obj_data_buffer, buffer_string, inv_info_name_compressed[i][ii]); //아이템의 이름 값 보유
						buffer_write(global.obj_data_buffer, buffer_string, inv_info_stack_num[i][ii]); //아이템의 갯수 값 보유
						buffer_write(global.obj_data_buffer, buffer_string, inv_info_max_stack_num[i][ii]); //아이템의 최대 스택 갯수 값 보유
						buffer_write(global.obj_data_buffer, buffer_string, inv_info_width[i][ii]); //아이템의 이름 값 보유
						buffer_write(global.obj_data_buffer, buffer_string, inv_info_height[i][ii]); //아이템의 갯수 값 보유
						buffer_write(global.obj_data_buffer, buffer_string, inv_info_rotated[i][ii]); //아이템의 최대 스택 갯수 값 보유
						buffer_write(global.obj_data_buffer, buffer_string, inv_info_weight[i][ii]); //아이템의 무게 (kg단위)
					}
				}
			}
		}
		
		show_message_log("- ["+string(obj_id)+"] 오브젝트 데이터 전송 완료");
	}
	
	

	send_all(global.obj_data_buffer);
}