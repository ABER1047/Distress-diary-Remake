// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param id
///@param name
///@param values
function send_InstanceMuchVariableData(tmp_ins,val_name,tmp_values = "")
{
	buffer_seek(global.variable_data_buffer, buffer_seek_start, 0);
	buffer_write(global.variable_data_buffer, buffer_u8, global.DATA_INS_VAR_DATA);
	buffer_write(global.variable_data_buffer, buffer_string, global.my_player_id); //보낸 사람 적용 제외용 변수
	buffer_write(global.variable_data_buffer, buffer_string, tmp_ins.obj_id); //특정 오브젝트 real id를 찾기위한 용도
	buffer_write(global.variable_data_buffer, buffer_string, object_get_name(tmp_ins.object_index)); //위와 같음
	
	//값 뽑아내기
	var tmp_values_to_string = ""; //콤마로 구분된 변수값 문자열 저장용
	var tmp_varname_to_string = ""; //콤마로 구분된 변수명 문자열 저장용
	var tmp_str = string_split(val_name,",");
	var tmp_val_str = (tmp_values != "") ? string_split(tmp_values,",") : tmp_values;
	for(var i = 0; i < array_length(tmp_str); i++)
	{
		//변수명, 변수값 나열된 문자열 마지막에는 콤마 안 붙여도 되니까 빼버리기
		var add_comma = (i != array_length(tmp_str)-1) ? "," : "";
		var tmp_trimed = string_trim(tmp_str[i]);
		tmp_varname_to_string = string(tmp_varname_to_string)+string(tmp_trimed)+string(add_comma);
		
		//파라미터로 받은 변수값이 존재하지 않거나, 몇개만 존재하고 중간에 몇개는 빠져있는 경우
		var tmp_real_value = (!is_array(tmp_val_str) || tmp_val_str[i] == "") ? variable_instance_get(tmp_ins,tmp_trimed) : tmp_val_str[i];
		tmp_values_to_string = string(tmp_values_to_string)+string(tmp_real_value)+string(add_comma);
	}
	
	buffer_write(global.variable_data_buffer, buffer_string, tmp_varname_to_string); //변수명
	buffer_write(global.variable_data_buffer, buffer_string, tmp_values_to_string); //변수 값
	send_all(global.variable_data_buffer);
	
	show_debug_message("send data ["+string(tmp_varname_to_string)+"] : "+string(tmp_values_to_string));
}