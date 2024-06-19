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


//라이트 서피스
if surface_exists(global.light_surf)
{
	var xx_w = camera_get_view_width(view_camera[0]);
	surface_set_target(global.light_surf);
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_color);
	draw_set_color($ffffff);
	draw_set_alpha(1);
	draw_rectangle(0, 0, 1920*2, 1080*2, 0);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
}



//새로운 플레이어가 중도 참여했을 때, 맵 데이터 전송
if (global.new_player_joined > 0)
{
	//맵 데이터 전송
	code_m.alarm[4] = 1;
	
	global.new_player_joined --;
}



//1초동안 초당 평균 프레임 값 구하기
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
	
		if (fps_timer > 60)
		{
			fps_timer = 0;
			global.average_fps_for_draw = global.average_fps_per_sec/60;
		}
	}
}



//공격 속도 적용
if (global.attack_cooldown_timer > 0)
{
	global.attack_cooldown_timer ++;
	if (global.attack_cooldown_timer > global.attack_speed)
	{
		global.fixed_dir = global.b_fixed_dir; //플레이어 바라보는 방향 고정이던거 해제
		global.gage_bar_shine_animation = 1; //게이지 바 번쩍거림 이펙트
		global.attack_cooldown_timer = 0;
	}
}




