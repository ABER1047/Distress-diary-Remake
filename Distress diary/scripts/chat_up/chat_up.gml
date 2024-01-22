function chat_up(argument0) 
{
global.chating = argument0;
	
	for(var i = 0; i < 10; i++)
	{
	global.chat[10 - i] = global.chat [9 - i];
	}
	global.chat[0] = global.chating;
}