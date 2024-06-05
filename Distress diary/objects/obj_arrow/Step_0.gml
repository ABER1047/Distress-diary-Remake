/// @description Insert description here
// You can write your code in this editor



//화살 이동 및 히트 판정
for(var i = 0; i < _speed; i++)
{
	x += lengthdir_x(1,direction);
	y += lengthdir_y(1,direction);
	
	if (place_meeting(x,y,obj_wall_parents))
	{
		stop_flying = 1;
	}
	else
	{
		var tmp_ins = instance_place(x,y,obj_mob_parents);
		if (instance_exists(tmp_ins))
		{
			var tmp_z_val = z-tmp_ins.z;
			var hitbox_check = (abs(tmp_z_val) <= 4) || (tmp_z_val > 0 && tmp_z_val < (tmp_ins.bbox_bottom - tmp_ins.bbox_top)+4);
			if (hitbox_check && parents_obj_ind != object_get_name(tmp_ins.object_index))
			{
				is_on_mob = tmp_ins;
				saved_xscale = sign(tmp_ins.image_xscale);
			
				//데미지
				give_damage(tmp_ins,attack_dmg,true,16,parents.x,parents.y);
			
				_speed = 0;
				stop_flying = 16;
			}
		}
	}
}




//화살 날아가는 이벤트 관련
if (stop_flying > 0)
{
	stop_flying --;
	
	if (stop_flying == 0)
	{
		_speed = 0;
		stop_animation = true;
	}
}


//스프라이트 이미지 각도가 실제 direction값과 다르니 보정해줌
image_angle = direction-45+angle_comp;



//화살 갯수가 일정량을 초과한 경우, 먼저 생성된 화살부터 순차적으로 제거
if (instance_number(object_index) > global.graphics_quality*16)
{
	var min_obj_id_owner = id;
	var min_obj_id = obj_id;
	with(object_index)
	{
		if (obj_id < min_obj_id)
		{
			min_obj_id = obj_id;
			min_obj_id_owner = id;
		}
	}
	
	instance_destroy(min_obj_id_owner);
}



if (global.graphics_quality > 0)
{
	//화살 궤적 애니메이션
	if (!stop_animation)
	{
		if (animation_timer%2 == 0)
		{
			var tmp_ind = animation_timer/2;
			xx[tmp_ind] = x;
			yy[tmp_ind] = y-z;
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
			var tmp_comp_yy = is_on_mob.y - is_on_mob.z;
			var tmp_scale = sign(is_on_mob.image_xscale);
			x = is_on_mob.x;
			y = tmp_comp_yy;
			z = 0.5*(is_on_mob.bbox_bottom - is_on_mob.bbox_top);
			
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
			
			visible = is_on_mob.visible;
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
		
		//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
		statement_by_pos();
	}
}


