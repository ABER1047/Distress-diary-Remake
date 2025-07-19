/// @description Insert description here


//불이 원 주위로 빙빙 돔
if (type == 1 || type == 2)
{
	if (parents == -1)
	{
		parents = -4;
		with(obj_monster_parents)
		{
			if (obj_id == floor(other.obj_id))
			{
				other.parents = id;
			}
		}
	}
	
	if (instance_exists(parents))
	{
		//해당 투사체 주인으로 부터의 거리 설정용 변수
		tmp_value4 += 0.01;
		var tmp_range = (type == 1) ? 64 : 256;
		tmp_value1 += (128+sin(tmp_value4)*tmp_range - tmp_value1)*0.1;
		z += (parents.z - z)*0.1;
		
		direction += 2;
		
		
		//일정 거리 이상 멀어진 경우, 불 삭제후 재생성
		if (tmp_value2 != -4 && point_distance(tmp_value2,tmp_value3,parents.x,parents.y) > 640)
		{
			parents = -4;
		}
		else
		{
			//부모 인스턴스 위치 저장용
			tmp_value2 = parents.x;
			tmp_value3 = parents.y;
		}
		
		x = tmp_value2+lengthdir_x(tmp_value1,direction);
		y = tmp_value3+lengthdir_y(tmp_value1,direction);
		
		
		
		//크기 설정
		image_xscale += (2.5 - image_xscale)*0.1;
		image_yscale += (2.5 - image_yscale)*0.1;
		
		//애니메이션 재생
		image_index += 0.175;
		
		
		//불 이펙트
		var tmp_col = [ #DD4C4C, #FFAC4B, #0BE5C4, #D9FFDE ];
		if (percentage_k(5))
		{
			create_bubble_effect(x+irandom_range(-16,16),y+(percentage_k(10) ? 10 : -10),-z-32,tmp_col[(type-1)*2],tmp_col[(type-1)*2+1],0.08,-irandom_range(6,12),irandom_range(-2,2),0.03,0,true,,,1.3);
		}
		
		//라이트 효과
		var tmp_value = sin(tmp_value4);
		c_light(tmp_col[(type-1)*2+1],(0.3+abs(tmp_value))*0.75,0.2+tmp_value*0.1,x,y-z);
	}
	else
	{
		//크기 설정
		image_xscale += (-0.01 - image_xscale)*0.1;
		image_yscale += (-0.01 - image_yscale)*0.1;
		
		if (image_xscale <= 0)
		{
			instance_destroy_multiplayer(id);
		}
	}
}