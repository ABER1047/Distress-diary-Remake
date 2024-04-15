/// @description Insert description here
// You can write your code in this editor


//스프라이트 이미지 각도가 실제 direction값과 다르니 보정해줌
image_angle = direction-45+angle_comp;








if (global.graphics_quality > 0)
{
	//화살 궤적 애니메이션
	if (!stop_animation)
	{
		if (animation_timer%2 == 0)
		{
			var tmp_ind = animation_timer/2;
			xx[tmp_ind] = x;
			yy[tmp_ind] = y;
		}

		if (animation_timer >= 8*2)
		{
			animation_timer = 0;
		}
		else
		{
			animation_timer ++;
		}
	}
	
	
	
	//화살 꽂힘 효과
	if (is_on_mob != -4)
	{
		if (instance_exists(is_on_mob))
		{
			var tmp_comp_yy = is_on_mob.y - is_on_mob.z - comp_draw_yy;
			if (comp_draw_yy_check)
			{
				tmp_comp_yy += is_on_mob.floating_yy;
			}
			
			var tmp_scale = sign(is_on_mob.image_xscale);
			x = is_on_mob.x;
			y = tmp_comp_yy;
			
			depth = is_on_mob.depth+8;
			
			if (saved_xscale == tmp_scale)
			{
				angle_comp = 0;
			}
			else
			{
				//화살이 꽂힌 방향에 따라서 몹이 방향을 틀 경우 똑같이 화살도 방향 적용
				angle_comp = 180-direction*2;
			}
		}
		else
		{
			instance_destroy();
		}
	}
	else
	{
		//깊이 설정
		depth = -floor(y);
	}
}




//화살 이동 및 히트 판정
for(var i = 0; i < _speed; i++)
{
	x += lengthdir_x(1,direction);
	y += lengthdir_y(1,direction);
	
	if (place_meeting(x,y,obj_wall_parents))
	{
		_speed = 0;
		alarm[0] = 8*2;
	}
	else
	{
		var tmp_ins = instance_place(x,y,obj_mob_parents);
		if (instance_exists(tmp_ins) && parents != tmp_ins)
		{
			is_on_mob = tmp_ins;
			saved_xscale = sign(tmp_ins.image_xscale);
			
			//정확히 몹 이미지의 정중앙에 화살이 위치하도록 y축 값을 보정시켜줌
			comp_draw_yy = (sprite_get_height(tmp_ins.sprite_index)*0.5*tmp_ins.image_yscale);
			comp_draw_yy_check = variable_instance_exists(tmp_ins,"floating_yy");
			show_debug_message("comp_draw_yy_check : "+string(comp_draw_yy_check));

			//데미지
			give_damage(tmp_ins,attack_dmg,true);
			
			_speed = 0;
			alarm[0] = 8*2;
		}
	}
}



