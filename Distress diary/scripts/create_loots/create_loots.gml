// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param x
///@param y
///@param img_ind
///@param inv_width
///@param inv_height
///@param loots_name
///@param obj_id
///@param DoNotSend
function create_loots(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7)
{
	var tmp_width = argument3;
	var tmp_height = argument4;
	
	var tmp_ins = instance_create_depth(argument0,argument1,depth,obj_loots);
	tmp_ins.image_index = argument2;
	tmp_ins.inv_width = tmp_width;
	tmp_ins.inv_height = tmp_height;
	tmp_ins.obj_id = argument6;
	tmp_ins.loots_name = argument5;
	
	with(tmp_ins)
	{
		if (id == tmp_ins)
		{
			for(var i = 0; i < tmp_height; i++)
			{
				for(var ii = 0; ii < tmp_width; ii++)
				{
					//inv_info_spr_ind가
					//-4일때 = 비어있음
					//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
					reset_inv_variable(ii,i);
				}
			}
		}
	}
	

	//생성된 상자 정보 다른 멀티플레이어한테 보내서 그쪽에도 오브젝트 생성하기
	if (argument7 != 1)
	{
		buffer_seek(global.obj_data_buffer, buffer_seek_start, 0);
		buffer_write(global.obj_data_buffer, buffer_u8, global.DATA_CHEST_DATA);
		buffer_write(global.obj_data_buffer, buffer_string, global.my_player_id);
		buffer_write(global.obj_data_buffer, buffer_string, argument0);
		buffer_write(global.obj_data_buffer, buffer_string, argument1);
		buffer_write(global.obj_data_buffer, buffer_string, argument2);
		buffer_write(global.obj_data_buffer, buffer_string, argument3);
		buffer_write(global.obj_data_buffer, buffer_string, argument4);
		buffer_write(global.obj_data_buffer, buffer_string, argument5);
		buffer_write(global.obj_data_buffer, buffer_string, argument6);
		send_all(global.obj_data_buffer);
	}
	
	global.object_id_ind ++;
	return tmp_ins;
}