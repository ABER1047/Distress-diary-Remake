// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function asyncAudioPlaying()
{
	//Only applies for client
	if (voice_client == true)
	{
		var queue = async_load[? "queue_id"]
		var tempbuff = async_load[? "buffer_id"]
		var shutdown = async_load[? "queue_shutdown"]

		for(var k = ds_map_find_first(voice_chat_users_dsmap); !is_undefined(k); k = ds_map_find_next(voice_chat_users_dsmap,k))
		{	
			if (queue == audioQueue[k])
			{
				//audio_free_play_queue(queue);
				buffer_delete(tempbuff)
			}
		}		
	}
}