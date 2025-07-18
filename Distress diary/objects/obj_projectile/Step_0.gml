/// @description Insert description here
// You can write your code in this editor



//화살 이동 및 히트 판정
for(var i = 0; i < _speed; i++)
{
	//show_debug_message("flying");
	x += lengthdir_x(1,direction);
	y += lengthdir_y(1,direction);
	
	if (position_meeting(x,y,obj_wall_parents))
	{
		stop_flying = 1;
		break;
	}
	else
	{
		var tmp_ins = instance_place(x,y-z,obj_mob_parents);
		if (instance_exists(tmp_ins) && tmp_ins.object_index != obj_dropped_item && tmp_ins.object_index != obj_dropped_item_box)
		{
			var chk_pvpable = (tmp_ins.object_index != obj_player || (global.pvpable && tmp_ins.object_index == obj_player && tmp_ins.obj_id_player_only != attacker_id));
			if (chk_pvpable)
			{
				var tmp_ch = abs(tmp_ins.z - z);
				//show_message_log(tmp_ch);
				if ((tmp_ch <= 96 && tmp_ins.zspeed >= 0) || tmp_ch <= 64)
				{
					is_on_mob = tmp_ins;
					stop_flying = 1;
					//데미지
					if (saved_xscale == -4)
					{
						//불꽃 튀는 이펙트
						if (type > 0)
						{
							var tmp_light_col = [ #FFAC4B, #0BE5C4, #E395F8 ];
							var tmp_col = [ #DD4C4C, #FFAC4B, #0BE5C4, #D9FFDE, #E395F8, #FF9ED5 ];
							repeat(irandom_range(4,7)*global.graphics_quality)
							{
								if (percentage_k(50))
								{
									var tmp_ins_effect = instance_create_depth(tmp_ins.x,tmp_ins.y,-1,obj_bright_line_effect);
									tmp_ins_effect.image_blend = tmp_light_col[type-1];
									tmp_ins_effect.direction = 90;
									tmp_ins_effect.rd_dir_increasement = direction;
									tmp_ins_effect.start_dir = 90;
									tmp_ins_effect.speed = irandom_range(20,30)/15+abs(global.movement_hspeed*0.1);
									tmp_ins_effect.rd_dir_timer_increasement = 1;
								}
		
								if (percentage_k(50))
								{
									var tmp_ins_effect = create_bubble_effect(tmp_ins.x+irandom_range(-16,16),tmp_ins.y+(percentage_k(10) ? 10 : -10),-z-32,tmp_col[(type-1)*2],tmp_col[(type-1)*2+1],0.08,-irandom_range(6,12),irandom_range(-2,2),0.03,0,true);
									tmp_ins_effect.image_xscale = 1.3;
									tmp_ins_effect.image_yscale = 1.3;
								}
							}
						}
						
						
						//기본 세팅값
						saved_xscale = sign(tmp_ins.image_xscale);
						give_damage(tmp_ins,attack_dmg,true,knockback,x,y,60,critical_chance,magnification,bleeding_chance,poisoning_chance,burning_chance);
						send_InstanceMuchVariableData(id,"x,y,saved_xscale",string(tmp_ins.x)+","+string(tmp_ins.y)+","+string(saved_xscale));
					}
					break;
				}
			}
		}
	}
}





//특수 효과 적용된 투사체 (애니메이션, 폭발 ...)
var tmp_chk_nomore_reflection = (reflection_num == max_reflection_num);
if (type > 0)
{
	//애니메이션 재생
	image_index += 0.175;
	if (tmp_chk_nomore_reflection || instance_exists(is_on_mob))
	{
		if (variable_instance_exists(id,"explosion_rad") && explosion_rad > 0)
		{
			//화면 흔들림 
			view_shake(0.1,4,0.1,0);
			
			//폭발 공격
			create_explosion_effect(x+(is_on_mob.x-x)*0.5,y+(is_on_mob.y-y)*0.5,real(explosion_dmg),real(explosion_rad),my_pos_xx,my_pos_yy,true);
		}

		instance_destroy_multiplayer(id);
	}
	
	
	//쇼크볼
	if (type == 2)
	{
		var tmp_max_dis = 420;
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
				if (percentage_k(5))
				{
					//쇼크볼에서 생성된 쇼크 볼트는 데미지&넉백 0.2배
					var tmp_dir = point_direction(x,y,nearest_shockball_ins.x,nearest_shockball_ins.y);
					var dmg_info_arr = [ attack_dmg*0.2, knockback*0.2, critical_chance, magnification, bleeding_chance, poisoning_chance, burning_chance ];
					create_shockbolt(x,y,z,0,4,0,0,0,#3898FF,attacker_id,0,dmg_info_arr,my_pos_xx,my_pos_yy,0,nearest_shockball_ins,true);
				}
			}
		}
		else
		{
			//주변에 있는 쇼크볼 1개 감지
			var tmp_nearest_dis = tmp_max_dis;
			with(obj_projectile)
			{
				if (my_pos_xx == other.my_pos_xx && my_pos_yy == other.my_pos_yy && type == 2 && id != other.id)
				{
					var tmp_dis = point_distance(x,y,other.x,other.y);
					if (!instance_exists(nearest_shockball_ins) && tmp_nearest_dis > tmp_dis)
					{
						nearest_shockball_ins = other.id;
						tmp_nearest_dis = tmp_dis;
					}
				}
			}
				
			if (instance_exists(nearest_shockball_ins))
			{
				chat_up_multiplayer("connected! - shockball",false,true);
			}
		}
	}
}







//화살 날아가는 이벤트 관련
if (stop_flying > 0)
{
	stop_flying --;
	

	if (stop_flying == 0)
	{
		//미러볼인 경우
		if (tmp_chk_nomore_reflection)
		{
			_speed = 0;
			stop_animation = true;
		}
		else
		{
			reflection_num ++;
			while(true)
			{
				x -= lengthdir_x(1,direction);
				y -= lengthdir_y(1,direction);

				if (!instance_position(x,y,obj_wall_parents))
				{
					break;
				}
			}
			
			direction = get_reflection_angle(x,y,direction,_speed);
		}
	}
}


//몹한테 박힌 것도 아닌 상태 + 벽에도 안 박힘 => 삭제
if (stop_animation && is_on_mob == -4 && !place_meeting(x,y,obj_wall_parents))
{
	instance_destroy();
}





//화살 갯수가 일정량을 초과한 경우, 먼저 생성된 화살부터 순차적으로 제거
if (stop_animation && instance_number(object_index) > global.graphics_quality*16)
{
	var min_obj_id_owner = id;
	var min_obj_id = obj_id;
	with(object_index)
	{
		if (obj_id < min_obj_id)
		{
			min_obj_id = obj_id;
			min_obj_id_owner = id;
		}
	}
	
	instance_destroy(min_obj_id_owner);
}







//라이트 값이 정의된 경우, 투사체에 빛나는 효과 적용
if (variable_instance_exists(id,"light_col"))
{
	light_animation_timer ++;
	var tmp_value = sin((light_animation_timer/180)*pi);
	var tmp_light_col = [ #FFAC4B, #0BE5C4, #E395F8 ];
	c_light(tmp_light_col[light_col],(0.3+abs(tmp_value))*0.75,0.4*image_xscale+tmp_value*0.1,x,y-z);
}


