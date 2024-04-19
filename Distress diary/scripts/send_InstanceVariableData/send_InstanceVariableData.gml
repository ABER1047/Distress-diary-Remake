// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param id
///@param name
///@param value
function send_InstanceVariableData(tmp_ins,val_name,tmp_variable = variable_instance_get(tmp_ins,val_name))
{
	buffer_seek(global.variable_data_buffer, buffer_seek_start, 0);
	buffer_write(global.variable_data_buffer, buffer_u8, global.DATA_INS_VAR_DATA);
	buffer_write(global.variable_data_buffer, buffer_string, global.my_player_id); //보낸 사람 적용 제외용 변수
	buffer_write(global.variable_data_buffer, buffer_string, tmp_ins.obj_id); //특정 오브젝트 real id를 찾기위한 용도
	buffer_write(global.variable_data_buffer, buffer_string, object_get_name(tmp_ins.object_index)); //위와 같음
	buffer_write(global.variable_data_buffer, buffer_string, val_name); //변수명
	buffer_write(global.variable_data_buffer, buffer_string, tmp_variable); //변수 값
	send_all(global.variable_data_buffer);
	
	show_debug_message("send data ["+string(val_name)+"] : "+string(tmp_variable));
}