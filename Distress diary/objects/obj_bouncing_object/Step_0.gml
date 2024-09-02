/// @description Insert description here
// You can write your code in this editor




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
var tmp_ang = power(_speed,2)*0.1;
image_angle += (abs(angle_difference(0,direction)) < 90) ? tmp_ang : -tmp_ang;

//속도 실제 적용
x += lengthdir_x(_speed,direction);
y += lengthdir_y(_speed,direction)*0.48;


//z축 설정
if (z <= 0)
{
	//깊이 설정
	if (instance_exists(obj_map_texture_floor))
	{
		depth = obj_map_texture_floor.depth-5;
	}
	
	z = 0;
	_speed += (0 - _speed)*0.1;
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
	//깊이 설정
	depth = -(y+floor(sprite_height*0.25));
	
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





//토치인 경우
if (!stop_cal_by_pos_statement && sprite_index == spr_torch)
{
	if (z <= 15)
	{
		var tmp_angle_diff1 = angle_difference(image_angle%360,0), tmp_angle_diff2 = angle_difference(image_angle%360,180);
		if (abs(tmp_angle_diff1) > 15 && abs(tmp_angle_diff2) > 15)
		{
			image_angle += (tmp_angle_diff1 > tmp_angle_diff2) ? tmp_angle_diff2*0.1 : tmp_angle_diff1*0.1;
		}
	}
	
	//라이트 효과
	var tmp_len = image_xscale*12;
	var tmp_yy = y-z*0.8+lengthdir_y(tmp_len,image_angle);
	var light_col = [ #FFAC4B, #0BE5C4, #E395F8 ];
	c_light(light_col[image_index],light_scale*0.7,light_alpha,x,tmp_yy);
	light_timer ++;
	if (light_timer < 90)
	{
		light_alpha += (1 - light_alpha)*0.1;
		light_scale += (1 - light_scale)*0.1;
	}
	else if (light_timer < 120)
	{
		light_alpha += (0.92 - light_alpha)*0.1;
		light_scale += (0.95 - light_scale)*0.1;
	}
	else
	{
		light_timer = 0;
	}
	
	
	//불 이펙트 생성
	if (global.graphics_quality >= 1)
	{
		if (percentage_k(1))
		{
			var tmp_ins = instance_create_depth(x+lengthdir_x(tmp_len*1.4,image_angle),tmp_yy,-1,obj_bright_line_effect);
			tmp_ins.image_blend = light_col[image_index];
			tmp_ins.direction = 90;
			tmp_ins.rd_dir_increasement = 90;
			tmp_ins.start_dir = 90;
			tmp_ins.speed = irandom_range(20,30)/20;
			tmp_ins.rd_dir_timer_increasement = 1;
		}
	}
}

