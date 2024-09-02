// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param string
///@param show_nickname
///@param [DoNotSend]
function chat_up_multiplayer(argument0,argument1,argument2)
{
	var tmp_str = argument0;
	if (argument1 == true)
	{
		tmp_str = string(global.nickname)+" : "+string(tmp_str);
	}
	
	
	show_message_log(tmp_str);
	
	if (argument2 == undefined || argument2 == false)
	{
		//채팅 전송
		buffer_seek(chat_buffer, buffer_seek_start, 0);
		buffer_write(chat_buffer, buffer_u8, DATA.CHAT);
		buffer_write(chat_buffer, buffer_string, global.my_player_id);
		buffer_write(chat_buffer, buffer_string, tmp_str);
		send_all(chat_buffer);
	}
	
	return tmp_str;
}