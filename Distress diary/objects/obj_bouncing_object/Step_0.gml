/// @description Insert description here
// You can write your code in this editor


//깊이 설정
depth = -y;

//서서히 속도 감소
_speed += (0 - _speed)*0.01;

//오브젝트에 부딛혔을 경우 튕기는 효과
var tmp_ins = instance_place(x,y,obj_wall_parents);
if (instance_exists(tmp_ins))
{
	if (z <= tmp_ins.sprite_height)
	{
		_speed *= -0.8;
	}
}

//속도 방향대로 이미지 회전 (굴러가는 효과)
image_angle -= _speed*1.4;

//속도 실제 적용
x += lengthdir_x(_speed,direction);
y += lengthdir_y(_speed,direction)*0.48;


//z축 설정
if (z <= 0)
{
	z = 0;
	_speed += (0 - _speed)*0.03;
	if (bounce_stack > 0)
	{
		bounce_stack -= 0.1;
		zspeed *= -bounce_stack;
	}
	else
	{
		bounce_stack = 0;
		zspeed = 0;
		zgravity = 0;
		zspeed_timer = 0;
	}
}
else if (z > 0)
{
	zgravity = 0.2;
}

if (zspeed < 0 || zspeed_timer > 3)
{
	z -= zspeed;
	zspeed += zgravity*4.8;
}
else
{
	zspeed_timer ++;
}



//n프레임 뒤 자동 삭제
des_timer ++;
if (des_timer > t_des_time)
{
	image_xscale += (-0.01 - image_xscale)*0.2;
	image_yscale += (-0.01 - image_yscale)*0.2;
	
	if (image_xscale <= 0)
	{
		instance_destroy();
	}
}