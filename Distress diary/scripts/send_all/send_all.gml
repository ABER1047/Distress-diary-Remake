function send_all(argument0) 
{
	buffer = argument0;
	
	if (global.is_server == false) 
	{
		network_send_packet(code_m.server , buffer, buffer_get_size(buffer));
	}
	else 
	{
		for(var i = 0; i < ds_list_size(global.client_num); i++) 
		{
			var soc = global.client_num[| i];
			if (soc < 0)
			{
				continue;
			}
			network_send_packet(soc , buffer, buffer_get_size(buffer));
		}
	}
}