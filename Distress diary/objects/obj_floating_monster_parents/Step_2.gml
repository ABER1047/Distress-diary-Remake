/// @description Insert description here



//pushable_objects끼리 밀리는 효과
pushable_objects_physics();


//위치 (y축에 따라 depth 설정)
depth = -floor(y);


//플레이어 타깃팅
if (instance_exists(targeted))
{
	image_xscale = sign_nonzero(x - targeted.x)*abs(image_xscale);
	
	//타깃이랑 일정 거리 이상 멀어지면 자동으로 텔레포트
	var tmp_dis = point_distance(x,y,targeted.x,targeted.y);
	if (tmp_dis <= 480)
	{
		//타깃팅된 플레이어 따라가기
		var max_speed = 2;
		_speed += (max_speed - _speed)*0.1;
		direction += angle_difference(point_direction(targeted.x,targeted.y,x,y),direction)*0.1;
	}
	else if (tmp_dis < 640)
	{
		//타깃팅된 플레이어 따라가기
		var max_speed = 2;
		_speed += (max_speed - _speed)*0.1;
		direction += angle_difference(point_direction(x,y,targeted.x,targeted.y),direction)*0.1;
	}
	else
	{
		var tp_pos = 480, loop = true, rd_dir = irandom_range(0,359), increasement = floor(abs(sprite_width)*0.3), auto_break = 0;
		while(loop && auto_break <= 32)
		{
			auto_break ++;
			rd_dir = irandom_range(1,12)*30;
			for(var i = 16; i <= tp_pos; i = ((i+increasement <= tp_pos) ? i+increasement : tp_pos))
			{
				var tmp_xx = targeted.x+lengthdir_x(i,rd_dir);
				var tmp_yy = targeted.y+lengthdir_y(i,rd_dir);
				if (place_meeting(tmp_xx,tmp_yy,obj_wall_parents))
				{
					break;
				}
				
				if (i >= tp_pos || auto_break = 32)
				{
					x = tmp_xx;
					y = tmp_yy;
					loop = false;
					break;
				}
			}
		}
	}
}
else
{
	//타깃팅 완료
	targeted = instance_nearest(x,y,obj_player);
	
	
	if (global.is_server)
	{
		//멀티플레이어 측은 타깃정보 리셋후 리타겟팅
		send_InstanceMuchVariableData(id,"x,y,targeted",string(x)+","+string(y)+",-4");
	}
}




//데미지 애니메이션 관련 변수
if (dmg_cooltime > 0)
{
	dmg_cooltime --;
	image_blend = #E14141;
	
	if (dmg_cooltime < 50)
	{
		image_blend = c_white;
	}
	
	if (dmg_cooltime%4 == 0)
	{
		image_alpha = (image_alpha == 1) ? 0.5 : 1;
	}
		
	if (dmg_cooltime == 0)
	{
		image_alpha = 1;
	}
}





//출혈 디버프
if (buff_left_time[6] > 0)
{
	buff_left_time[6] --;
	if (buff_left_time[6]%180 == 0)
	{
		give_damage(id,1.5,true,0,x,y,10);
	}
}

//독 디버프
if (buff_left_time[15] > 0)
{
	buff_left_time[15] --;
	if (buff_left_time[15]%180 == 0)
	{
		give_damage(id,1,true,0,x,y,10);
	}
}

//버프 효과 적용
if (buff_applied_index >= 0)
{
	var i = buff_applied_index;
	send_InstanceMuchVariableData(id,"buff_left_time["+string(i)+"],buff_applied_index",string(floor(buff_left_time[i]))+","+string(buff_applied_index));
	buff_applied_index = -4;
}