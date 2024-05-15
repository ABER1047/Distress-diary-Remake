/// @description Insert description here
// You can write your code in this editor



//핑 계산
if (global.is_server)
{
	//핑은 서버측에서 계산해서 클라이언트한테 보내주는 구조
	for(var i = 0; i < array_length(global.users_ping); i++)
	{
		if (global.users_ping[i] > 0)
		{
			global.users_ping[i] ++;
		}
	}
}









//VC system
/*if (voice_client == true)
{
	//	voice client step	
	//if (connected_to_voice_server == true)
	//{
		if keyboard_check(pushToTalkKey) 
		{
			if (mic_on == false && mic_set == true)
			{
				mic_on = true;
				record_info[mic_id] = audio_start_recording(mic_id);
				
				//send to server recording has started
				scr_voiceclient_send_userinfo();
			}
		}
		else
		{
			if (mic_on == true)
			{
				mic_on = false;
				
				audio_stop_recording(record_info[mic_id]); 
				
				//send to server recording has stopped
				scr_voiceclient_send_userinfo();
			}
		}
	//}
	
	//change microphone
	for(var i = 0; i < number_of_mics; i++)
	{
		if (keyboard_check(ord(string(i+1))))
		{
			mic_id = i;
			mic_set = true;
		}
	}
}*/