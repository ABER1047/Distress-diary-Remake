/// @description Insert description here
// You can write your code in this editor


startx = x+lengthdir_x(32,direction);
starty = y+lengthdir_y(32,direction);

var tmp_ang = image_angle+90;
if (tmp_ang == 0)
{
	starty += 32*dir;
}
else if (tmp_ang == 90)
{
	startx += 32*dir;
}
else if (tmp_ang == 180)
{
	starty -= 32*dir;
}
else
{
	startx -= 32*dir;
}



for(var i = 0; i < animation_frame; i++)
{
	xx1[i] = startx;
	yy1[i] = starty;
	xx2[i] = startx;
	yy2[i] = starty;
}


xx2[0] = x+lengthdir_x(line_width*2,direction);
yy2[0] = y+lengthdir_y(line_width*2,direction);


//효과음 재생
play_sound_pos(choose(swing_1_sfx,swing_2_sfx,swing_3_sfx),false,0.2,x,y,640,true,-4,-4);

visible = true;


//몬스터 공격 판정
with(obj_mob_parents)
{
	if (object_index != obj_player && id != other.id && place_meeting(x,y,other.id) && z-32 <= other.z)
	{
		give_damage(id,other.attack_dmg,true,global.knockback_power,other.x,other.y,25);
	}
}

//채굴 판정 (데미지가 마이너스 = 광질)
if (attack_dmg < 0)
{
	with(obj_only_minable)
	{
		hp -= abs(other.attack_dmg);
	}
}


alarm[1] = 2;


