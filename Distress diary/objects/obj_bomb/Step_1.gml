/// @description Insert description here
// You can write your code in this editor


//터지는 애니메이션
timer ++;
if (!stop_cal_by_pos_statement)
{
	timer_sfx ++;
	var tmp_val = 15-floor(timer/12);
	if (timer_sfx > tmp_val)
	{
		//흰색으로 깜빡이는 효과
		w_alpha = 1;
		
		//효과음 재생
		play_sound_pos(bomb_timer_sfx,false,0.2,x,y,640,true,-4,-4);
		timer_sfx -= tmp_val;
	}
	w_alpha += (-0.01 - w_alpha)*0.3;
		
		
	if (timer > 150)
	{
		create_explosion_effect(x,y,28,4,-4,-4,true);
	}
}

if (timer > 150)
{
	//화면 흔들림 
	view_shake(0.1,16,0.1,0);
	
	//효과음 재생
	play_sound_pos(bomb_sfx,false,0.1,x,y,1300,false,my_pos_xx,my_pos_yy);
	
	instance_destroy();
}

