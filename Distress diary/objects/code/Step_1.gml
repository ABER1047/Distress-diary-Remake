/// @description Insert description here
var tmp_my_p = global.my_player_ins_id[global.my_player_id];
var tmp_weight_ratio = fix_to_zero(global.my_weight-global.over_weight)/90;
var speed_by_weight = fix_to_zero(power(1-tmp_weight_ratio,2));


//사운드 볼륨 조절용 거리 값
if (array_length(global.my_player_ins_id) > global.my_player_id)
{
	if (instance_exists(tmp_my_p))
	{
		audio_listener_position(-tmp_my_p.x,-tmp_my_p.y,tmp_my_p.z);
		//show_debug_message("listener_pos_set");
	}
}



//플레이어 실제 인스턴스 아이디
if (array_length(global.my_player_ins_id) < instance_number(obj_player))
{
	get_all_players_ins_id();
}


//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
if (global.load_map_repeater > 0)
{
	for(var i = 0; i < array_length(global.add_my_pos_statement_obj_ind_list); i++)
	{
		with(asset_get_index(global.add_my_pos_statement_obj_ind_list[i]))
		{
			if (id != other.id)
			{
				statement_by_pos();
			}
		}
	}
	global.load_map_repeater --;
}



//시간 시스템
var tmp_cal_hour = floor(global.time/60);
tmp_cal_hour = (tmp_cal_hour < 10) ? "0"+string(tmp_cal_hour) : tmp_cal_hour;
var tmp_cal_min = global.time%60;
tmp_cal_min = (tmp_cal_min < 10) ? "0"+string(tmp_cal_min) : tmp_cal_min;
global.time_display = string(tmp_cal_hour)+":"+string(tmp_cal_min);
global.time_response_light += (global.time_is_day - global.time_response_light)*0.03;

global.time_increment_timer ++;
if (global.time_increment < global.time_increment_timer)
{
	//게임 내의 시간 - 1분 지남
	global.time ++;
	global.time_increment_timer -= global.time_increment;
	if (global.time >= 60*22 || global.time < 60*6.5)//오후 10시~오전 6시 30분 (밤)
	{
		global.time_is_day = false;
	}
	else //오전 6시 30분~오후 10시 (낮)
	{
		global.time_is_day = true;
	}
	
	if (global.time >= 60*24)
	{
		global.time -= 60*24;
	}
}





//스테이터스 시스템
global.defence_power = (sign(global.buff_left_time[9]) - sign(global.buff_left_time[10]))*1.5 + power(1/speed_by_weight,3); //방어력
global.over_weight = 10 + (sign(global.buff_left_time[11])*15); //최대 중량

//체력 및 스테미나가 최대치를 넘지 않도록 조정
with(tmp_my_p)
{
	if (stamina > global.max_stamina)
	{
		stamina = global.max_stamina;
	}
	
	if (hp > global.max_hp)
	{
		hp = global.max_hp;
	}
}



// 버프/디버프 시스템
for(var i = 0; i < array_length(global.buff_left_time); i++)
{
	if (global.buff_left_time[i] > 0)
	{
		global.buff_timer[i] ++;
		global.buff_left_time[i] --;
		if (global.buff_left_time[i] <= 0)
		{
			tmp_my_p.buff_left_time[19] = 0;
			send_InstanceMuchVariableData(tmp_my_p,"buff_left_time["+string(i)+"],buff_applied_index","0,"+string(i));
		}
	}
}

with(obj_mob_parents)
{
	if (z <= 0)
	{
		//이속 저하 - 슬라임 점액질 충돌 판정
		if (place_meeting(x,y,obj_mucus_effect))
		{
			if (id == tmp_my_p)
			{
				if (global.buff_left_time[0] <= 0)
				{
					apply_buff(id,0,30);
				}
				else
				{
					global.buff_left_time[0] = 30;
				}
			}
			else
			{
				_speed += (0 - _speed)*0.2;
			}
		}
		
		//독 효과 - 슬라임 점액질 충돌 판정
		if (place_meeting(x,y,obj_poison_effect))
		{
			other.tmp_timer_poisoning_effect ++;
			if (other.tmp_timer_poisoning_effect%180 == 0 && id == tmp_my_p)
			{
				apply_buff(id,15,other.tmp_timer_poisoning_effect/3);
			}
		}
	}
	
	//연막-가스 충돌 판정
	if (id == tmp_my_p)
	{
		var tmp_placed_ins = instance_place(x,y,obj_smoke_effect);
		if (instance_exists(tmp_placed_ins))
		{
			global.smoke_color = merge_color(tmp_placed_ins.image_blend,c_black,0.3);
			global.smoke_alpha += (1 - global.smoke_alpha)*0.03;
			
			if (tmp_placed_ins.buff_index >= 0 && tmp_placed_ins.tmp_buff_timer%180 == 0)
			{
				apply_buff(id,tmp_placed_ins.buff_index,tmp_placed_ins.tmp_buff_timer+10,true);
			}
		}
	}
}



//과적
if (global.my_weight > global.over_weight)
{
	if (global.buff_left_time[4] <= 5)
	{
		apply_buff(tmp_my_p,4,10,false);
	}
	global.buff_left_time[4] = 10;
}

//골절
if (global.buff_left_time[5] > 0) 
{
	if ((tmp_my_p.zspeed > 0 && tmp_my_p.z == 0) || (global.n_running && abs(global.movement_vspeed)+abs(global.movement_hspeed) >= global.max_movement_speed*0.91))
	{
		global.movement_hspeed *= 0.75;
		global.movement_vspeed *= 0.75;
		give_damage(tmp_my_p,3,true,0,tmp_my_p.x,tmp_my_p.y,10);
	}
	
	global.movement_vspeed += (0 - global.movement_vspeed)*0.01;
	global.movement_hspeed += (0 - global.movement_hspeed)*0.01;
}

//출혈
if (global.buff_timer[6] > 180) //3초당 -1.5씩 체력 감소 (초당 0.5)
{
	give_damage(tmp_my_p,1.5,true,0,tmp_my_p.x,tmp_my_p.y,10);
	global.buff_timer[6] = 0;
}


//배고픔
if (global.hunger <= 10)
{
	if (global.buff_left_time[7] <= 5)
	{
		apply_buff(tmp_my_p,7,10);
	}
	global.buff_left_time[7] = 10;
}
if (global.buff_timer[7] > 600) //매 10초마다 배고픔에 비례하여 체력 감소 (최대 10초당 6씩 = 초당 0.6)
{
	tmp_my_p.hp -= (6-global.hunger*0.5);
	global.buff_timer[7] = 0;
}


//목마름
if (global.hydration <= 10)
{
	if (global.buff_left_time[8] <= 5)
	{
		apply_buff(tmp_my_p,8,10);
	}
	global.buff_left_time[8] = 10;
}
else if (global.buff_timer[8] > 600) //매 10초마다 목마름에 비례하여 체력 감소 (최대 10초당 2씩 = 초당 0.2)
{
	tmp_my_p.hp -= (2-global.hydration*0.1);
	global.buff_timer[8] = 0;
}



//체력 재생
if (global.buff_timer[12] > 300) //매 5초마다 +2씩 체력 재생 (초당 0.4)
{
	tmp_my_p.hp += 2;
	global.buff_timer[12] = 0;
}

//행운
global.luck = (sign(global.buff_left_time[14])-sign(global.buff_left_time[13]))*2;



//중독
if (global.buff_timer[15] > 180) //매 3초마다 -1씩 체력 감소 (초당 0.33...)
{
	give_damage(tmp_my_p,1,true,0,tmp_my_p.x,tmp_my_p.y,10);
	global.buff_timer[15] = 0;
}


//아이템 서칭
global.searching_speed = 100*(1-sign(global.buff_left_time[16])*0.3);


//크리티컬 데미지 배율
global.critical_dmg_magnification = 0.5*(1+sign(global.buff_left_time[18]));


//화염
if (global.buff_left_time[19] > 0)
{
	if (global.buff_left_time[19]%180 == 0)
	{
		give_damage(tmp_my_p,1,true,0,tmp_my_p.x,tmp_my_p.y,10);
	}
	else if (global.buff_left_time[19]%5 == 0)
	{
		tmp_my_p.hp -= 0.1;
		if (global.graphics_quality >= 2)
		{
			repeat(irandom_range(1,3))
			{
				with(tmp_my_p)
				{
					if (id != other.id && percentage_k(50))
					{
						create_bubble_effect(x+irandom_range(-16,16),y-z-32,1,#DD4C4C,#FFAC4B,0.08,-irandom_range(6,12),irandom_range(-2,2),0.03,0,true,-y-1,,0.5);
					}
				}
			}
		}
	}
}

//마나 회복 속도
var tmp_activated1 = (global.buff_left_time[21] > 0) ? 1 : 0;
var tmp_activated2 = (global.buff_left_time[22] > 0) ? 1 : 0;
global.mana_recovery = 0.08*(1 + (tmp_activated1-tmp_activated2)*9);


//공속 증가 (%단위)
global.attack_speed_increasement =  (global.buff_left_time[23] > 0) ? 15 : 0;




//공격 속도 적용
if (global.attack_cooldown_timer > 0)
{
	global.attack_cooldown_timer += ((global.attack_type == 2 || global.attack_type == 5) ? 1 : speed_by_weight)*global.charging_split*(1+global.attack_speed_increasement*0.01);
	if (global.attack_cooldown_timer > global.attack_speed)
	{
		global.fixed_dir = global.b_fixed_dir; //플레이어 바라보는 방향 고정이던거 해제
		global.attack_cooldown_timer = 0;
	}
	
	//공격 쿨타임 게이지
	//global.my_player_ins_id[global.my_player_id].gage_bar_charged = global.attack_cooldown_timer/global.attack_speed;
}








//현재 들고 있는 아이템 정보 전송
var tmp_spr_ind = global.quickslot_spr_ind[global.quickslot_index];
var tmp_img_ind = global.quickslot_img_ind[global.quickslot_index];
if (instance_exists(tmp_my_p) && sprite_exists(tmp_spr_ind))
{
	var tmp_real_spr_ind = tmp_spr_ind;
	var tmp_torch_spr = [ spr_animated_torch, spr_animated_soul_torch, spr_animated_demon_torch ];
	tmp_spr_ind = (tmp_spr_ind == spr_others) ? tmp_torch_spr[tmp_img_ind] : tmp_spr_ind;
	if (tmp_my_p.holding_item_spr_ind != tmp_spr_ind || tmp_my_p.holding_item_img_ind != tmp_img_ind)
	{
		var tmp_var_name = "holding_item_spr_ind, holding_item_img_ind";
		var tmp_var = string(sprite_get_name(tmp_spr_ind))+","+string(tmp_img_ind);
		tmp_my_p.holding_item_spr_ind = tmp_spr_ind;
		tmp_my_p.holding_item_img_ind = tmp_img_ind;
		
		
		//토치 아이템을 들고 있는 경우
		if (tmp_real_spr_ind == spr_others)
		{
			tmp_my_p.light_scale = 0.3;
			tmp_my_p.light_alpha = 0.3;
			
			tmp_var_name = string(tmp_var_name)+",light_scale,light_alpha";
			tmp_var = string(tmp_var)+",0.3,0.3";
			
			//효과음 재생
			play_sound_pos(fire_ignition_sfx,false,0.1,x,y-32,640,false,-4,-4);
		}
		
		
		//들고 있는 아이템 정보 보내기
		send_InstanceMuchVariableData(tmp_my_p,tmp_var_name,tmp_var);
	}
}
else
{
	if (tmp_my_p.holding_item_spr_ind != -4)
	{
		send_InstanceVariableData(tmp_my_p,"holding_item_spr_ind",-4);
		tmp_my_p.holding_item_spr_ind = -4;
	}
}