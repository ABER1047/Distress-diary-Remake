function send_one(argument0, argument1) 
{
	var type = argument0;
	var val_name = argument1;
	var real_val = variable_instance_get(code_m.my_instance_id, val_name);
	
	buffer_seek(code_m.one_buffer, buffer_seek_start, 0);
	buffer_write(code_m.one_buffer, buffer_u8, DATA.ONE_DATA);
	
	buffer_write(code_m.one_buffer, buffer_u8, code_m.object_id);
	buffer_write(code_m.one_buffer, buffer_u8, type);
	buffer_write(code_m.one_buffer, buffer_string, val_name);
	buffer_write(code_m.one_buffer, type, real_val);
	
	send_all(code_m.one_buffer);
}