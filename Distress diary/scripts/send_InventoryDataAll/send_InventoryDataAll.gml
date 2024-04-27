// Script assets have changed for v2.3.0 see


///@param variable_owner[obj_id]
///@param object_index
function send_InventoryDataAll(argument0,argument1)
{
	var tmp_variable_owner = argument0;
	with(argument1)
	{
		if (obj_id == argument0)
		{
			tmp_variable_owner = id;
		}
	}
	
	with(tmp_variable_owner)
	{
		if (id == tmp_variable_owner)
		{
			var tmp_width = inv_width;
			var tmp_height = inv_height;
		
			buffer_seek(global.inv_data_buffer, buffer_seek_start, 0);
			buffer_write(global.inv_data_buffer, buffer_u8, global.DATA_INV_DATA);
			buffer_write(global.inv_data_buffer, buffer_string, global.my_player_id);
			buffer_write(global.inv_data_buffer, buffer_string, argument0);
			buffer_write(global.inv_data_buffer, buffer_string, object_get_name(argument1));
			
			//혹시 오브젝트 자체가 존재하지 않는 경우를 대비하여 새로운 오브젝트 생성을 위한 정보 보내기
			var tmp_str = string(x)+"#"+string(y)+"#"+string(image_index)+"#"+string(tmp_width)+"#"+string(tmp_height)+"#"+string(loots_name)+"#"+string(my_pos_xx)+"#"+string(my_pos_yy);
			buffer_write(global.inv_data_buffer, buffer_string, tmp_str);
			
			
			

			for(var i = 0; i < tmp_height; i++)
			{
				for(var ii = 0; ii < tmp_width; ii++)
				{
					//inv_info_spr_ind가
					//-4일때 = 비어있음
					//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
					
					//문자열로 데이터 압축 후 보내기
					var tmp_spr_name = (sprite_exists(inv_info_spr_ind[i][ii])) ? sprite_get_name(inv_info_spr_ind[i][ii]) : inv_info_spr_ind[i][ii];
					var tmp_str = string(tmp_spr_name)+"#"+string(inv_info_img_ind[i][ii])+"#"+string(inv_info_name[i][ii])+"#"+string(inv_info_name_compressed[i][ii])+"#"+string(inv_info_stack_num[i][ii])+"#"+string(inv_info_max_stack_num[i][ii])+"#"+string(inv_info_width[i][ii])+"#"+string(inv_info_height[i][ii])+"#"+string(inv_info_rotated[i][ii])+"#"+string(inv_info_weight[i][ii]);
					buffer_write(global.inv_data_buffer, buffer_string, tmp_str);
				}
			}
			
			send_all(global.inv_data_buffer);
		
			return true;
		}
	}
	
	
	//만약 tmp_variable_owner인스턴스가 존재하지 않는 경우
	return false;
}