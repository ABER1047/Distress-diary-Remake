/// @description Insert description here
// You can write your code in this editor
if (ds_map_find_value(async_load, "id") == send_request) //If received data is our request
{
	if (ds_map_find_value(async_load, "status") == 0) //If data received
	{
		global.my_ip = string_trim(string_replace_all(ds_map_find_value(async_load, "result")," ","")); //Write message + data (IP)
	}
	else if (ds_map_find_value(async_load, "status") < 0) //If error occurred
	{
		var error_code = ds_map_find_value(async_load, "http_status");
		global.my_ip = ""; //Write error message
	}
}















