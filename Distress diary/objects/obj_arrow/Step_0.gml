/// @description Insert description here
// You can write your code in this editor


//스프라이트 이미지 각도가 실제 direction값과 다르니 보정해줌
image_angle = direction-45;



//깊이 설정
depth = -floor(y);



//화살 궤적 애니메이션
if (global.graphics_quality > 0)
{
	if (animation_timer%2 == 0)
	{
		var tmp_ind = animation_timer/2;
		xx[tmp_ind] = x;
		yy[tmp_ind] = y;
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




//화살 이동
for(var i = 0; i < _speed; i++)
{
	x += lengthdir_x(1,direction);
	y += lengthdir_y(1,direction);
	
	if (place_meeting(x,y,obj_wall_parents))
	{
		_speed = 0;
	}
}