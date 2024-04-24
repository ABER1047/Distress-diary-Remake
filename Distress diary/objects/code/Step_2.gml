/// @description Insert description here
// You can write your code in this editor

//서피스가 없어진 경우 재생성
if (window_has_focus())
{
	if (!surface_exists(global.light_surf))
	{
		event_user(0);
	}
}
else
{
	//풀스크린 상태에서 윈도우 창이 포커스 되지 않은 경우, 메모리 누수 방지를 위해 서피스 삭제
	if (window_get_fullscreen() && surface_exists(global.light_surf))
	{
		event_user(2);
	}
}



//새로운 플레이어가 중도 참여했을 때, 맵 데이터 전송
if (global.new_player_joined > 0)
{
	//맵 데이터 전송
	code_m.alarm[4] = 1;
	
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







