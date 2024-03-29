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
			buffer_write(global.inv_data_buffer, buffer_string, x);
			buffer_write(global.inv_data_buffer, buffer_string, y);
			buffer_write(global.inv_data_buffer, buffer_string, image_index);
			buffer_write(global.inv_data_buffer, buffer_string, tmp_width);
			buffer_write(global.inv_data_buffer, buffer_string, tmp_height);
			buffer_write(global.inv_data_buffer, buffer_string, loots_name);
			
			
			var tmp_str = "";
			for(var i = 0; i < tmp_height; i++)
			{
				for(var ii = 0; ii < tmp_width; ii++)
				{
					//inv_info_spr_ind가
					//-4일때 = 비어있음
					//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
					var tmp_spr_name = (sprite_exists(inv_info_spr_ind[i][ii])) ? sprite_get_name(inv_info_spr_ind[i][ii]) : inv_info_spr_ind[i][ii];
					buffer_write(global.inv_data_buffer, buffer_string, tmp_spr_name); //spr_ind값 보유
					buffer_write(global.inv_data_buffer, buffer_string, inv_info_img_ind[i][ii]); //img_ind값 보유
					buffer_write(global.inv_data_buffer, buffer_string, inv_info_name[i][ii]); //아이템의 이름 값 보유
					buffer_write(global.inv_data_buffer, buffer_string, inv_info_stack_num[i][ii]); //아이템의 갯수 값 보유
					buffer_write(global.inv_data_buffer, buffer_string, inv_info_max_stack_num[i][ii]); //아이템의 최대 스택 갯수 값 보유
					buffer_write(global.inv_data_buffer, buffer_string, inv_info_width[i][ii]); //아이템의 이름 값 보유
					buffer_write(global.inv_data_buffer, buffer_string, inv_info_height[i][ii]); //아이템의 갯수 값 보유
					buffer_write(global.inv_data_buffer, buffer_string, inv_info_rotated[i][ii]); //아이템의 최대 스택 갯수 값 보유
					buffer_write(global.inv_data_buffer, buffer_string, inv_info_weight[i][ii]); //아이템의 무게 (kg단위)
					buffer_write(global.inv_data_buffer, buffer_string, 0); //아이템 서치됨
					tmp_str = string(tmp_str)+string(inv_info_spr_ind[i][ii])+" ";
				}
				tmp_str = string(tmp_str)+"\n"
			}
			
			show_debug_message(tmp_str); //인벤토리 정보 디버그 콘솔창에 표기
			send_all(global.inv_data_buffer);
		
			return true;
		}
	}
	
	
	//만약 tmp_variable_owner인스턴스가 존재하지 않는 경우
	return false;
}