/// @description Insert description here
// You can write your code in this editor


//블럭 밀기 시스템
var tmp_ins = instance_nearest(x,y,obj_player);
var tmp_xx = x - tmp_ins.x;
var tmp_yy = y - tmp_ins.y;
var tmp_scale = sprite_width*0.5;

if (pushing_timer > 10)
{
	p_stack ++;
	pushing_timer -= 5;
	

	var tmp_sign = (p_stack%2 == 0) ? 1 : -1;
	if (abs(tmp_xx) < abs(tmp_yy))
	{
		draw_xx = 4*tmp_sign;
	}
	else
	{
		draw_yy = 4*tmp_sign;
	}
}
else
{
	if (pushing_timer > 0)
	{
		pushing_timer --;
	}
	else
	{
		if (p_stack <= 8)
		{
			p_stack = 0;
		}
		pushing_timer = 0;
		draw_xx = 0;
		draw_yy = 0;
	}
}





if (p_stack >= 999)
{
	if (abs(origin_xx - x) <= 1 && abs(origin_yy - y) <= 1)
	{
		x = origin_xx;
		y = origin_yy;
		pushing_timer = 0;
		p_stack = 0;
		draw_xx = 0;
		draw_yy = 0;
	}
	else
	{
		x += (origin_xx - x)*0.1;
		y += (origin_yy - y)*0.1;
	}
}
else if (p_stack > 8)
{
	//이동할 칸이 있는 경우
	if (abs(tmp_xx) > abs(tmp_yy))
	{
		var tmp_cal = tmp_scale*sign(tmp_xx);
		origin_xx += (!place_meeting(x+tmp_cal,y,obj_wall_parents)) ? tmp_cal : 0;
	}
	else
	{
		var tmp_cal = tmp_scale*sign(tmp_yy);
		origin_yy += (!place_meeting(x,y+tmp_cal,obj_wall_parents)) ? tmp_cal : 0;
	}

	p_stack = 999;
}

