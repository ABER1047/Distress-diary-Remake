/// @description Insert description here
// You can write your code in this editor

//새로운 플레이어가 중도 참여했을 때, 맵 데이터 전송
if (global.new_player_joined > 0)
{
	send_NewMapData();
	global.new_player_joined --;
}



//5초동안 초당 평균 프레임 값 구하기
if (global.dev_mode == 1)
{
	fps_timer ++;
	if (fps_timer >= 0)
	{
		if (fps_timer == 1)
		{
			global.average_fps_per_sec = 0;
		}
		global.average_fps_per_sec += fps_real;
	
		if (fps_timer > 300)
		{
			fps_timer = 0;
			global.average_fps_for_draw = global.average_fps_per_sec/300;
		}
	}
}







