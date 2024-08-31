/// @description Insert description here
// You can write your code in this editor




//돌진 패턴
var tmp_ins = -4;
if (delay_timer == 0)
{
	with(obj_player)
	{
		other.signx = x-other.x;
		other.signy = y-(other.y-48);
		if (abs(other.signy) <= 48)
		{
			other.signy = 0;
			tmp_ins = id;
			break;
		}
		else if (abs(other.signx) <= 48)
		{
			other.signx = 0;
			tmp_ins = id;
			break;
		}
	}
}
else if (dash_speed == 0)
{
	delay_timer ++;
	if (delay_timer > 60)
	{
		delay_timer = 0;
	}
}

if (instance_exists(tmp_ins) || dash_speed > 0)
{
	//블럭 이동 효과음
	dash_speed += (32 - dash_speed)*0.05;
	
	for(var i = 0; i < dash_speed; i++)
	{
		var tmp_signx = sign(signx), tmp_signy = sign(signy);
		var tmp_chk_yy = (tmp_signy)*64;
		if (tmp_chk_yy > 0)
		{
			tmp_chk_yy = 16;
		}
		
		if (place_meeting(x+tmp_signx*16,y+tmp_chk_yy,obj_wall_parents) || place_meeting(x+tmp_signx*16,y+tmp_chk_yy,obj_spike_block))
		{
			if (dash_speed > 2)
			{
				view_shake(2,5,2,0);
				comp_pos_grid(x,y+48);
			}
			dash_speed = 0;
			break;
		}
		
		x += tmp_signx;
		y += tmp_signy;
	}
	
	if (delay_timer == 0)
	{
		delay_timer = 1;
		if (dash_speed > 0)
		{
			play_sound_pos(move_block_sfx,false,0.1,x,y,1280,false,-4,-4);
			play_sound_pos(choose(jump_start1_sfx,jump_start2_sfx),false,0.1,x,y,1280,false,-4,-4);
		}
	}
}

var tmp_placed_mob = instance_place(x,y,obj_mob_parents);
if (instance_exists(tmp_placed_mob))
{
	give_damage(tmp_placed_mob,18,false,dash_speed,x,y-32,60);
}