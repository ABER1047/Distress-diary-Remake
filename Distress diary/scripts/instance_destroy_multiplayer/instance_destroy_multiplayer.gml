// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param ins_id[real_id]
function instance_destroy_multiplayer(argument0)
{
	var tmp_ins = argument0;
	if (instance_exists(tmp_ins))
	{
		//삭제될 오브젝트의 obj_id값
		var tmp_obj_id = tmp_ins.obj_id;
		
		//삭제될 오브젝트 정보 다른 멀티플레이어들한테 보내기
		buffer_seek(global.obj_data_buffer, buffer_seek_start, 0);
		buffer_write(global.obj_data_buffer, buffer_u8, global.DATA_OBJECTS_DATA);
		buffer_write(global.obj_data_buffer, buffer_string, global.my_player_id);
		buffer_write(global.obj_data_buffer, buffer_string, object_get_name(tmp_ins.object_index));
		buffer_write(global.obj_data_buffer, buffer_string, 1); //생성은 0, 삭제는 1
		buffer_write(global.obj_data_buffer, buffer_string, tmp_obj_id);
		send_all(global.obj_data_buffer);
		
		
		show_message_log("- 오브젝트 삭제 [obj_id : "+string(tmp_obj_id)+"]");
		
		//내쪽에서 삭제
		instance_destroy(tmp_ins);
		
		return tmp_obj_id;
	}
	else
	{
		return noone;
	}
}