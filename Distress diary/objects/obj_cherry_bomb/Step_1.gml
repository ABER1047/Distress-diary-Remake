/// @description Insert description here
// You can write your code in this editor



//위치 (y축에 따라 depth 설정)
depth = -floor(y);


//z축 중력 적용
z_axis_gravity();



//pushable_objects끼리 밀리는 효과
pushable_objects_physics();



//터지는 애니메이션
if (!stop_cal_by_pos_statement)
{
	timer_sfx ++;
	var tmp_val = 15-floor(z/25);
	if (timer_sfx > tmp_val)
	{
		//흰색으로 깜빡이는 효과
		w_alpha = 1;
		
		//효과음 재생
		play_sound_pos(bomb_timer_sfx,false,0.2,x,y,640,true,-4,-4);
		timer_sfx -= tmp_val;
	}
	w_alpha += (-0.01 - w_alpha)*0.3;
		
		
	if (z <= 0)
	{
		create_explosion_effect(x,y,38,2,-4,-4,true);
	}
}

if (z <= 0)
{
	//화면 흔들림 
	view_shake(0.1,16,0.1,0);
	
	//효과음 재생
	play_sound_pos(bomb_sfx,false,0.1,x,y,1300,false,my_pos_xx,my_pos_yy);
	
	instance_destroy();
}


draw_alpha = !stop_cal_by_pos_statement;