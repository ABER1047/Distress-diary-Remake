/// @description Insert description here
// You can write your code in this editor


if (!stop_cal_by_pos_statement)
{
	//사망 이벤트
	if (hp <= 0)
	{
		for(var i = 0; i < 360; i += 45)
		{
			var tmp_hspeed = lengthdir_x(16,i);
			var tmp_vspeed = lengthdir_y(16,i);
			var tmp_ins = create_bubble_effect(x,y,-z,c_white,c_black,0.1,tmp_vspeed*0.48,tmp_hspeed,0.1,0,false);
			tmp_ins.image_xscale = 1.6;
			tmp_ins.image_yscale = 1.6;
		}
		
		create_bounce_object(x,y,z+irandom_range(0,64),_speed,direction,0,spr_deadmob_debris,2,image_yscale,irandom_range(240,360));
		
		play_sound_pos(ghost_disappear_sfx,false,0.3,x,y,1280,true,my_pos_xx,my_pos_yy);
		instance_destroy();
	}
	
	
	//라이트 효과
	var tmp_value = sin((idle_animation/180)*pi);
	var tmp_alpha_b = (0.3+abs(tmp_value))*0.75;
	var tmp_alpha = (attack_timer > 180) ? tmp_alpha_b*image_alpha : tmp_alpha_b;
	c_light(#3E375C,tmp_alpha,0.2+tmp_value*0.1,x,y-z);
	
	
	//idle animation
	idle_animation ++;
	if (idle_animation < 90)
	{
		z += (32 - z)*0.01;
	}
	else if (idle_animation < 180)
	{
		z += (96 - z)*0.01;
	}
	else
	{
		idle_animation = 0;
	}




	//패턴
	if (dmg_cooltime > 0)
	{
		attack_timer = 0;
	}
	
	if (attack_timer > 180)
	{
		image_alpha += (-0.01 - image_alpha)*0.05;
		
		if (image_alpha < 0)
		{
			_speed += (6 - _speed)*0.1;
			direction += angle_difference(point_direction(x,y,targeted.x,targeted.y),direction)*0.3;
		}
	}
	else
	{
		attack_timer ++;
	}



	//불 이펙트
	if (global.graphics_quality > 1 && percentage_k(15))
	{
		var tmp_ins = create_bubble_effect(x+irandom_range(-16,16),y+(percentage_k(10) ? 10 : -10),-z-32,c_black,#3E375C,0.05,-irandom_range(0,12),irandom_range(-2,2),0.07,0,true);
		tmp_ins.image_xscale = 1.3;
		tmp_ins.image_yscale = 1.3;
	}
}


