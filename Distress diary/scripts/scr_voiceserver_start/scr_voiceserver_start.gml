function scr_voiceserver_start()
{
	voice_server_started = network_create_server(network_socket_tcp, voice_server_port, 1000);
	
	if (voice_server_started >= 0) 
	{
		voice_packet_fragmented = array_create(1000,0);
		voice_fragment_buffer = array_create(1000,0);
		voice_tmp_buffer = array_create(1000,0);
		voice_send_buffer = array_create(1000,0);
		voice_write_buffer = array_create(1000,0);
		voice_header_buffer = array_create(1000,0);
		
		return true;
	}
	
	return false;
}