/// @description Insert description here
// You can write your code in this editor

var tmp_chk = (global.n_player_room_xx[global.my_player_id] == my_pos_xx && global.n_player_room_yy[global.my_player_id] == my_pos_yy);
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
if (tmp_chk)
{
	play_sound_pos(choose(swing_1_sfx,swing_2_sfx,swing_3_sfx),false,0.2,x,y,640,true,my_pos_xx,my_pos_yy);
}
visible = tmp_chk;


//몬스터 공격 판정
with(obj_mob_parents)
{
	//팀킬 가능 여부 체크
	var tmp_str = other.already_attacked;
	var chk_teammate_attackable = (object_index == obj_player && global.pvpable && other.owner_player_id != obj_id_player_only && string_pos("/"+string(obj_id_player_only)+"/",tmp_str) == 0);
	if ((chk_teammate_attackable || object_index != obj_player) && id != other.id && place_meeting(x,y,other.id) && abs(z-other.z) <= 96)
	{
		//팀킬 가능시, 공격 쿨타임이 없어 여러번 공격이 중첩 되지 않도록 수정
		if (chk_teammate_attackable)
		{
			other.already_attacked = string(tmp_str)+"/"+string(obj_id_player_only)+"/";
		}
		
		if (other.owner_player_id == global.my_player_id)
		{
			give_damage(id,other.attack_dmg,true,other.knockback,other.x,other.y,25,other.critical_chance,other.magnification,other.bleeding_chance,other.poisoning_chance,other.burning_chance);
			
			//화면흔들림 효과
			if (variable_instance_exists(id,"hp"))
			{
				view_shake(1+floor(other.attack_dmg/5)*1.5,1+floor(other.attack_dmg/5),1,2);
			}
		}
	}
}

//채굴 판정 (데미지가 마이너스 = 광질)
var tmp_ins = instance_nearest(x,y+32,obj_only_minable);
with(tmp_ins)
{
	if (id != other.id && place_meeting(x,y,other.id))
	{
		repeat(irandom_range(1,3))
		{
			//폭발 잔해 이펙트 
			var tmp_xx = x + (other.x-x)*0.5;
			var tmp_yy = y + (other.y-y)*0.5;
			var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
			var tmp_scale = irandom_range(10,20)*0.1;
			create_bounce_object(tmp_xx,tmp_yy,irandom_range(0,64),irandom_range(0,16),irandom_range(0,359),-irandom_range(2,8),spr_stone_flake,irandom_range(0,3),tmp_scale,irandom_range(120,240));
		}
		
		play_sound_pos(choose(pickaxe_1,pickaxe_2,pickaxe_3),false,0.3,x,y,1200,true,-4,-4);
		if (other.attack_dmg < 0)
		{
			var tmp_dmg = other.attack_dmg;
			hp -= abs(tmp_dmg);
			
			if (hp <= 0)
			{
				repeat(irandom_range(1,3))
				{
					//폭발 잔해 이펙트 
					var tmp_xx = x + (other.x-x)*0.5;
					var tmp_yy = y + (other.y-y)*0.5;
					var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
					var tmp_scale = irandom_range(10,20)*0.1;
					create_bounce_object(tmp_xx,tmp_yy,irandom_range(0,64),irandom_range(4,9),irandom_range(0,359),-irandom_range(2,8),spr_stone_flake,irandom_range(0,3),tmp_scale,irandom_range(120,240));
				}
				instance_destroy();
			}
		}
	}
}

animation_played = true;
alarm[1] = 2;


