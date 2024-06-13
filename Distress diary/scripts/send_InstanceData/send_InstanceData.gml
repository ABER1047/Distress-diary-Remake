// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param ins(id)
///@param [variables_name]
///@param [variables]
function send_InstanceData(tmp_ins,variables_name = "",variables = "")
{
	with(tmp_ins)
	{
		buffer_seek(global.obj_data_buffer, buffer_seek_start, 0);
		buffer_write(global.obj_data_buffer, buffer_u8, global.DATA_OBJECTS_DATA);
		buffer_write(global.obj_data_buffer, buffer_string, global.my_player_id);
		buffer_write(global.obj_data_buffer, buffer_string, object_get_name(object_index));
		buffer_write(global.obj_data_buffer, buffer_string, 0);
		buffer_write(global.obj_data_buffer, buffer_string, obj_id);
		buffer_write(global.obj_data_buffer, buffer_string, x);
		buffer_write(global.obj_data_buffer, buffer_string, y);
		buffer_write(global.obj_data_buffer, buffer_string, image_index);
		buffer_write(global.obj_data_buffer, buffer_string, my_pos_xx);
		buffer_write(global.obj_data_buffer, buffer_string, my_pos_yy);
		buffer_write(global.obj_data_buffer, buffer_string, variables_name); //변수명
		buffer_write(global.obj_data_buffer, buffer_string, variables); //변수값
		send_all(global.obj_data_buffer);
	}
}