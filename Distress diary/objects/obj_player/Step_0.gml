/// @description Insert description here
// You can write your code in this editor



//이동 관련
if (keyboard_check(ord("W")))
{
	global.n_dir = 1;
	global.movement_vspeed += (-global.max_movement_vspeed - global.movement_vspeed)*0.1;
}
else if (keyboard_check(ord("S")))
{
	global.n_dir = 3;
	global.movement_vspeed += (global.max_movement_vspeed - global.movement_vspeed)*0.1;
}

if (keyboard_check(ord("D")))
{
	global.n_dir = 0;
	global.movement_hspeed += (global.max_movement_hspeed - global.movement_hspeed)*0.1;
}
else if (keyboard_check(ord("A")))
{
	global.n_dir = 2;
	global.movement_hspeed += (-global.max_movement_hspeed - global.movement_hspeed)*0.1;
}


if (keyboard_check_released(ord("A")) || keyboard_check_released(ord("D")))
{
	global.movement_hspeed = 0;
}

if (keyboard_check_released(ord("W")) || keyboard_check_released(ord("S")))
{
	global.movement_vspeed = 0;
}




//이동 속도에 따른 실제 이동
for(var i = 0; i < abs(global.movement_hspeed); i++)
{
	var tmp = sign(global.movement_hspeed);
	//벽에 막혔는지 체크
	if (!place_meeting(x+tmp,y,obj_wall_parents))
	{
		x += tmp;
	}
	else
	{
		global.movement_hspeed = 0;
		break;
	}
}

for(var i = 0; i < abs(global.movement_vspeed); i++)
{
	var tmp = sign(global.movement_vspeed);
	//벽에 막혔는지 체크
	if (!place_meeting(x,y+tmp,obj_wall_parents))
	{
		y += tmp;
	}
	else
	{
		global.movement_vspeed = 0;
		break;
	}
}



//움직임 애니메이션
if (global.movement_hspeed == 0 && global.movement_vspeed == 0)
{
	image_index += (0 - image_index)*0.1;
}
else
{
	image_index += max(abs(global.movement_hspeed),abs(global.movement_vspeed))*0.015;
}

if (image_index < 0)
{
	image_index += image_number;
}
else if (image_index > image_number)
{
	image_index -= image_number;
}





//바라보는 방향에 따른 스프라이트 설정
if (global.n_dir == 0 || global.n_dir == 2)
{
	sprite_index = spr_original_bp0;
	image_xscale = (global.n_dir == 0) ? -abs(image_xscale) : abs(image_xscale);
}
else if (global.n_dir == 1)
{
	sprite_index = spr_original_bp0_1;
}
else
{
	sprite_index = spr_original_bp0_2;
}



//위치 (y축에 따라 depth 설정)
depth = -y;