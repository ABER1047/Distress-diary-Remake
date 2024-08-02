/// @description Insert description here
// You can write your code in this editor



//화살 이동 및 히트 판정
for(var i = 0; i < _speed; i++)
{
	show_debug_message("flying");
	x += lengthdir_x(1,direction);
	y += lengthdir_y(1,direction);
	
	if (place_meeting(x,y,obj_wall_parents))
	{
		stop_flying = 1;
	}
	else
	{
		var tmp_ins = instance_place(x,y-z,obj_monster_parents);
		if (instance_exists(tmp_ins))
		{
			var tmp_ch = abs(tmp_ins.z - z);
			show_message_log(tmp_ch);
			if (tmp_ch <= 96)
			{
				for(var i = 0; i < 8; i++)
				{
					xx[i] = 0;
					yy[i] = 0;
				}
				
				is_on_mob = tmp_ins;
				stop_flying = 16;
				_speed = 0;
				//데미지
				if (saved_xscale == -4)
				{
					saved_xscale = sign(tmp_ins.image_xscale);
					give_damage(tmp_ins,attack_dmg,true,16,x,y,60);
					send_InstanceMuchVariableData(id,"x,y,saved_xscale",string(x)+","+string(y)+","+string(saved_xscale));
				}
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


if (stop_animation && is_on_mob == -4 && !place_meeting(x,y,obj_wall_parents))
{
	instance_destroy();
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



