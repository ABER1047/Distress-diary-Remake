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
			create_bubble_effect(x,y,-z,c_white,c_black,0.1,tmp_vspeed*0.48,tmp_hspeed,0.1,0,false,,,1.6);
		}
		
		create_bounce_object(x,y,z+irandom_range(0,64),_speed,direction,0,spr_deadmob_debris,1,image_yscale,irandom_range(240,360));
		
		play_sound_pos(ghost_disappear_sfx,false,0.3,x,y,1280,true,my_pos_xx,my_pos_yy);
		instance_destroy();
	}
	
	
	//라이트 효과
	var tmp_value = sin((idle_animation/180)*pi);
	c_light(#D9FFDE,(0.3+abs(tmp_value))*0.75,0.2+tmp_value*0.1,x,y-z);
	
	
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



	//공격
	if (attack_timer > 180)
	{
		var is_exists_projectile = false;
		with(obj_projectile_monster)
		{
			if (floor(obj_id) == other.obj_id)
			{
				is_exists_projectile = true;
				break;
			}
		}
		
		if (!is_exists_projectile)
		{
			for(var i = 0; i < 3; i++)
			{
				var tmp_var_name = "type,sprite_index,image_xscale,image_yscale,direction,z,dmg";
				var tmp_var = "2,spr_soul_fire_animation,0,0,"+string(i*120)+","+string(z)+",24";
				var tmp_projectile = instance_create_multiplayer_ext(obj_projectile_monster,x,y,obj_id+(i/10),0,true,my_pos_xx,my_pos_yy,tmp_var_name,tmp_var);
			}
			
			attack_timer = 0;
		}
	}
	else
	{
		attack_timer ++;
	}



	//불 이펙트
	if (global.graphics_quality > 1 && percentage_k(15))
	{
		create_bubble_effect(x+irandom_range(-16,16),y+(percentage_k(10) ? 10 : -10),-z-32,#0BE5C4,#D9FFDE,0.08,-irandom_range(6,12),irandom_range(-2,2),0.03,0,true,,,1.3);
	}
}

