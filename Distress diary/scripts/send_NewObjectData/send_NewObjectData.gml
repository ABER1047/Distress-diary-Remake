// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_NewObjectData()
{
	buffer_seek(global.obj_data_buffer, buffer_seek_start, 0);
	buffer_write(global.obj_data_buffer, buffer_u8, global.DATA_OBJECTS_DATA);
	with(obj_parents)
	{
		if (object_index != obj_player)
		{
			//루트 가능한 오브젝트 (= 상자류)가 아닌경우
			if (!variable_instance_exists(id,"is_opened"))
			{
				//여기부분은 아직 개발 안됨
				buffer_write(global.obj_data_buffer, buffer_string, obj_id);
				buffer_write(global.obj_data_buffer, buffer_string, object_get_name(object_index));
			}
			else
			{
				send_InventoryDataAll(obj_id,object_index);
			}
		}
	}
	send_all(global.obj_data_buffer);
}