function chat_up(argument0) 
{
	global.chating = argument0;
	
	for(var i = 0; i < global.max_chat_stack; i++)
	{
		global.chat[global.max_chat_stack - i] = global.chat [global.max_chat_stack-1 - i];
	}
	global.chat[0] = global.chating;
	show_debug_message(global.chating);
}