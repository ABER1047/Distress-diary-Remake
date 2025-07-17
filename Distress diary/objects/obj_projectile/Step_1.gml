/// @description Insert description here
// You can write your code in this editor



//스프라이트 이미지 각도가 실제 direction값과 다르니 보정해줌
image_angle = direction-45+angle_comp;
	
	

if (type == 0 && global.graphics_quality > 0)
{
	//화살 꽂힘 효과
	if (is_on_mob != -4)
	{
		if (instance_exists(is_on_mob))
		{
			var tmp_comp_yy = is_on_mob.y - is_on_mob.z;
			var tmp_scale = sign(is_on_mob.image_xscale);
			x = is_on_mob.x;
			y = tmp_comp_yy;
			z = 0.5*(is_on_mob.bbox_bottom - is_on_mob.bbox_top);
			
			depth = is_on_mob.depth+8;
			
			if (saved_xscale == tmp_scale)
			{
				angle_comp = 0;
			}
			else
			{
				//화살이 꽂힌 방향에 따라서 몹이 방향을 틀 경우 똑같이 화살도 방향 적용
				angle_comp = 180-direction*2;
			}
			
			visible = is_on_mob.visible;
		}
		else
		{
			instance_destroy_multiplayer(id);
		}
	}
	else
	{
		//깊이 설정
		var tmp_depth = y+lengthdir_y(40,direction+180);
		depth = (y > tmp_depth) ? -floor(y) : -tmp_depth;
		
		//화살 궤적 애니메이션
		if (_speed > 0)
		{
			if (animation_timer%2 == 0)
			{
				xx[0] = x;
				yy[0] = y-z;
				for(var i = 7; i > 0; i--)
				{
					xx[i] = xx[i-1];
					yy[i] = yy[i-1];
				}
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
	}
}


//특수 효과 적용된 투사체 (애니메이션, 폭발 ...)
if (type > 0)
{
	//애니메이션 재생
	image_index += 0.175;
	if (is_on_mob != -4 || _speed == 0)
	{
		if (explosion_rad > 0)
		{
			//화면 흔들림 
			view_shake(0.1,4,0.1,0);
			
			//폭발 공격
			create_explosion_effect(x,y,real(explosion_dmg),real(explosion_rad),my_pos_xx,my_pos_yy,true);
		}
		
		
		//쇼크볼인 경우
		if (type == 2)
		{
			var tmp_max_dis = 1280;
			//연결 가능한 쇼크볼이 있는 경우
			if (instance_exists(nearest_shockball_ins))
			{
				//기존에 연결된 쇼크볼의 거리가 멀어져 끊어졌는지 체크
				var tmp_dis = point_distance(x,y,nearest_shockball_ins.x,nearest_shockball_ins.y);
				if (tmp_dis >= tmp_max_dis)
				{
					nearest_shockball_ins = -4;
				}
				else
				{
					var tmp_dir = point_direction(x,y,nearest_shockball_ins.x,nearest_shockball_ins.y);
					var dmg_info_arr = [ attack_dmg, knockback, critical_chance, magnification, bleeding_chance, poisoning_chance, burning_chance ];
					create_shockbolt(x,y,tmp_dis,4,tmp_dir,0,0,#3898FF,attacker_id,5,dmg_info_arr,my_pos_xx,my_pos_yy);
				}
			}
			else
			{
				//주변에 있는 쇼크볼 1개 감지
				var tmp_nearest_dis = tmp_max_dis;
				with(obj_projectile)
				{
					if (type == 2)
					{
						var tmp_dis = point_distance(x,y,other.x,other.y);
						if (!instance_exists(nearest_shockball_ins) && tmp_nearest_dis > tmp_dis)
						{
							nearest_shockball_ins = other.id;
							tmp_nearest_dis = tmp_dis;
						}
					}
				}
			}
		}
		
		instance_destroy_multiplayer(id);
	}
}
