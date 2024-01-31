// Script assets have changed for v2.3.0 see


///@param variable_owner[obj_id]
///@param object_index
function send_InventoryData(argument0,argument1)
{
	var tmp_variable_owner = -4;
	with(argument1)
	{
		if (obj_id == argument0)
		{
			tmp_variable_owner = id;
		}
	}
	
	if (instance_exists(tmp_variable_owner))
	{
		var tmp_width = tmp_variable_owner.inv_width;
		var tmp_height = tmp_variable_owner.inv_height;
		
		buffer_seek(global.inv_data_buffer, buffer_seek_start, 0);
		buffer_write(global.inv_data_buffer, buffer_u8, global.DATA_INV_DATA);
		buffer_write(global.inv_data_buffer, buffer_string, argument0);
		buffer_write(global.inv_data_buffer, buffer_string, object_get_name(argument1));
		for(var i = 0; i < tmp_height; i++)
		{
			for(var ii = 0; ii < tmp_width; ii++)
			{
				//inv_info_spr_ind가
				//-4일때 = 비어있음
				//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
				buffer_write(global.inv_data_buffer, buffer_string, inv_info_spr_ind[i][ii]); //spr_ind값 보유
				buffer_write(global.inv_data_buffer, buffer_string, inv_info_img_ind[i][ii]); //img_ind값 보유
				buffer_write(global.inv_data_buffer, buffer_string, inv_info_name[i][ii]); //아이템의 이름 값 보유
				buffer_write(global.inv_data_buffer, buffer_string, inv_info_stack_num[i][ii]); //아이템의 갯수 값 보유
			}
		}
		send_all(global.inv_data_buffer);
		
		return true;
	}
	else
	{
		return false;
	}
}