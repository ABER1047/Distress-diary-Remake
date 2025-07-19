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
		
		create_bounce_object(x,y,z+64,_speed,direction,0,spr_deadmob_debris,0,image_yscale,irandom_range(240,360));
		
		play_sound_pos(ghost_disappear_sfx,false,0.3,x,y,1280,true,my_pos_xx,my_pos_yy);
		
		//독 가스
		instance_create_multiplayer_ext(obj_smoke_effect,x,y,global.object_id_ind,0,false,my_pos_xx,my_pos_yy,"buff_index, des_time, image_blend","15, 600, #4AB23D");
		
		
		instance_destroy();
	}
	
	
	
	if (_speed > 0)
	{
		image_index += _speed*0.015;
	}
	else
	{
		image_index += (0 - image_index)*0.1;
	}


	//타깃팅된 플레이어 따라가기
	var max_speed = 16;
	if (instance_exists(targeted))
	{
		tracking_timer ++;
	
		if (tracking_timer > 15)
		{
			var tmp_dir = point_direction(x,y,targeted.x,targeted.y)+choose(-1,1);
			var tmp_cal = tmp_dir - direction;
			var tmp_scale = abs(image_xscale);
			tracking_dir = angle_difference(direction,tmp_dir);
			image_xscale = (tmp_dir >= 90 && tmp_dir < 270) ? tmp_scale : -tmp_scale;
			tracking_timer = 0;
		}
	}
	else
	{
		max_speed = 0;
	}

	_speed += (max_speed - _speed)*0.1;
	direction -= tracking_dir*0.1;
}
