/// @description Insert description here
// You can write your code in this editor



//z-axis
z_axis_gravity();


//pushable_objects끼리 밀리는 효과
pushable_objects_physics();


//위치 (y축에 따라 depth 설정)
depth = -floor(y);


//플레이어 타깃팅
if (instance_exists(targeted) && point_distance(x,y,targeted.x,targeted.y) < 960)
{
	image_xscale = sign_nonzero(x - targeted.x)*abs(image_xscale);
}
else
{
	//타깃팅 완료
	targeted = instance_nearest(x,y,obj_player);
	
	//멀티플레이어 측은 타깃정보 리셋후 리타겟팅
	send_InstanceVariableData(id,"targeted",-4);
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


