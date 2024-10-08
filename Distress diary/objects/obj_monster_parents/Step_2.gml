/// @description Insert description here
// You can write your code in this editor



//z-axis
z_axis_gravity();


//pushable_objects끼리 밀리는 효과
pushable_objects_physics();


//위치 (y축에 따라 depth 설정)
depth = -floor(y);


//플레이어 타깃팅
if (instance_exists(targeted) && point_distance(x,y,targeted.x,targeted.y) < 1280)
{
	image_xscale = sign_nonzero(x - targeted.x)*abs(image_xscale);
}
else
{
	//타깃팅 완료
	targeted = instance_nearest_by_pos(x,y,obj_player);
	
	
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
	if (global.is_server && buff_left_time[6]%180 == 0)
	{
		give_damage(id,1.5,true,0,x,y,10);
	}
}

//독 디버프
if (buff_left_time[15] > 0)
{
	buff_left_time[15] --;
	if (global.is_server && buff_left_time[15]%180 == 0)
	{
		give_damage(id,1,true,0,x,y,10);
	}
}
	
//화염 디버프
if (buff_left_time[19] > 0)
{
	buff_left_time[19] --;
	if (buff_left_time[19]%180 == 0)
	{
		if (global.is_server)
		{
			give_damage(id,1,true,0,x,y,10);
		}
	}
	else if (buff_left_time[19]%5 == 0)
	{
		if (global.is_server)
		{
			hp -= 0.1;
		}
		if (global.graphics_quality >= 2)
		{
			repeat(irandom_range(1,3))
			{
				if (percentage_k(50))
				{
					var tmp_ins = create_bubble_effect(x+irandom_range(-16,16),y-z-32,1,#DD4C4C,#FFAC4B,0.08,-irandom_range(6,12),irandom_range(-2,2),0.03,0,true,-y-1);
					tmp_ins.image_xscale = 0.5;
					tmp_ins.image_yscale = 0.5;
				}
			}
		}
	}
}


//버프 효과 적용
if (buff_applied_index >= 0)
{
	var i = buff_applied_index;
	send_InstanceMuchVariableData(id,"buff_left_time["+string(i)+"],buff_applied_index",string(floor(buff_left_time[i]))+","+string(buff_applied_index));
	buff_applied_index = -4;
}