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
		if (instance_exists(tmp_ins) && tmp_ins.object_index != obj_bomb && tmp_ins.object_index != obj_dropped_item_box && tmp_ins.object_index != obj_dropped_item && parents_obj_ind != object_get_name(tmp_ins.object_index))
		{
			var tmp_z_val = z-tmp_ins.z;
			var hitbox_check = (abs(tmp_z_val) <= 4) || (tmp_z_val > 0 && tmp_z_val < (tmp_ins.bbox_bottom - tmp_ins.bbox_top)+4);
			if (hitbox_check)
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


