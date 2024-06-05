// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function pushable_objects_physics()
{
	var tmp_ins = instance_place(x,y,obj_mob_parents);
	if (instance_exists(tmp_ins) && (tmp_ins.my_pos_xx == my_pos_xx && tmp_ins.my_pos_yy == my_pos_yy) && (tmp_ins.image_alpha > 0 && abs(z-tmp_ins.z) <= sprite_height*0.7)) //z축도 같은지 체크
	{
		var tmp_xx = (x - tmp_ins.x)/32;
		var tmp_yy = (y - tmp_ins.y)/32;
		
		//pushable_objects끼리 부딛혔을 경우 서로 밀리는 효과
		_hspeed = (_hspeed*0.5) + tmp_xx;
		_vspeed = (_vspeed*0.5) + tmp_yy;
		
		
		//만약 오브젝트가 플레이어이고, 부딛힌 오브젝트가 몬스터인 경우 데미지 입기
		if (object_index == obj_player)
		{
			var tmp_obj_ind = object_get_parent(tmp_ins.object_index);
			if (tmp_obj_ind == obj_monster_parents || tmp_obj_ind == obj_floating_monster_parents)
			{
				//show_debug_message("placed - monster");
				give_damage(id,tmp_ins.attack_dmg,false,16,tmp_ins,other.x,other.y);
			}
		}
		
		//show_debug_message("placed ["+string(_hspeed)+"]");
	}
	
	
	//_speed를 _vspeed-_hspeed로 변환
	if (abs(_speed) > 0)
	{
		_hspeed = lengthdir_x(_speed,direction);
		_vspeed = lengthdir_y(_speed,direction);
	}
	
	if (abs(_hspeed) <= 0.1)
	{
		_hspeed = 0;
	}
	
	if (abs(_vspeed) <= 0.1)
	{
		_vspeed = 0;
	}

	
	
	//_vspeed-hspeed로 인해 오브젝트가 벽을 뚫지 못하도록 방지
	for(var i = 0; i < abs(_hspeed); i++)
	{
		var tmp_cal = sign(_hspeed);
		var ins_place = instance_place(x+tmp_cal,y,obj_wall_parents);
		if (instance_exists(ins_place))
		{
			_hspeed = 0;
			_speed = 0;
		}
		else
		{
			x += tmp_cal;
		}
	}
	
	for(var i = 0; i < abs(_vspeed); i++)
	{
		var tmp_cal = sign(_vspeed);
		var ins_place = instance_place(x,y+tmp_cal,obj_wall_parents);
		if (instance_exists(ins_place))
		{
			_vspeed = 0;
			_speed = 0;
		}
		else
		{
			y += tmp_cal;
		}
	}

	
	
	if (z <= 0) //땅 바닥에 있어야 속도 감소 효과 먹음 (= 마찰력)
	{
		if (abs(_speed) > 0)
		{
			_speed += (0 - _speed)*0.15;
		}
		else
		{
			_hspeed += (0 - _hspeed)*0.2;
			_vspeed += (0 - _vspeed)*0.2;
		}
	}
	else
	{
		//공중에 있어야 속도 감소 효과 먹음 (= 공기저항)
		if (abs(_speed) > 0)
		{
			_speed += (0 - _speed)*0.015;
		}
		else
		{
			_hspeed += (0 - _hspeed)*0.02;
			_vspeed += (0 - _vspeed)*0.02;
		}
	}
	
	return tmp_ins;
}