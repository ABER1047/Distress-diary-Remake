/// @description Insert description here
// You can write your code in this editor

//z축 중력 적용
z_axis_gravity();


//pushable_objects끼리 밀리는 효과 추가
pushable_objects_physics();



//인터렉션 키 드로우 용
if (show_interaction_key > 0)
{
	show_interaction_key -= 1;
}


//다른사람이 루팅 중인 경우, 루팅 중이라고 정보 보내기
if (is_opened != b_is_opened)
{
	resize_inv = true;
	send_InstanceVariableData(id,"is_opened");
	b_is_opened = is_opened;
}



//아이템 갯수가 늘어날때마다 윈도우 창이 커지는 거 적용
if (resize_inv)
{
	var max_width = 0, max_height = 0;
	for(var i = 1; i <= 9; i++)
	{
		for(var ii = 1; ii <= 9; ii++)
		{
			if (inv_info_spr_ind[i-1][ii-1] != -4) //-1하는 이유는 i = 0은 width = 1을 의미하기 때문
			{
				if (max_width < ii)
				{
					max_width = ii;
				}
				
				if (max_height < i)
				{
					max_height = i;
				}
			}
		}
	}
	
	
	if (max_width == 0 && max_height == 0)
	{
		//아이템 다 빼간 경우 삭제
		des_timer = -4;
	}
	else
	{
		inv_width = max_width;
		inv_height = max_height;
		show_message_log("- 자동 칸 조절 ["+string(inv_width)+", "+string(inv_height)+"]");
	}
	
	resize_inv = false;
}
	



//5분뒤 삭제
des_timer ++;
if (des_timer > 3600*5 || des_timer < 0)
{
	instance_destroy_multiplayer(id);
}




