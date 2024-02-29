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









