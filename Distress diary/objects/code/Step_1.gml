/// @description Insert description here
var tmp_my_p = global.my_player_ins_id[global.my_player_id];


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
global.attack_damage = (3)*(1+global.apply_buff_effect[3]*0.25-global.apply_buff_effect[2]*0.25); //데미지 계산
global.knockback_power = (16); //넉백 파워
global.defence_power = (global.apply_buff_effect[9] - global.apply_buff_effect[10])*2.5; //방어력
global.over_weight = 10 + (global.apply_buff_effect[11]*10); //최대 중량

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
if (global.apply_buff_effect[0]) //속도 저하 (속도 증가 효과는 플레이어 오브젝트에서 따로 처리)
{
	global.movement_vspeed += (0 - global.movement_vspeed)*0.2;
	global.movement_hspeed += (0 - global.movement_hspeed)*0.2;
	global.apply_buff_effect[0] = false;
}

//과적
global.apply_buff_effect[4] = (global.my_weight > 10);

if (global.apply_buff_effect[5]) //골절
{
	if ((tmp_my_p.zspeed > 0 && tmp_my_p.z == 0) || (global.n_running && abs(global.movement_vspeed)+abs(global.movement_hspeed) >= global.max_movement_speed*0.91))
	{
		global.movement_hspeed *= 0.75;
		global.movement_vspeed *= 0.75;
		give_damage(tmp_my_p,3,true,0,x,y,10);
	}
	
	global.movement_vspeed += (0 - global.movement_vspeed)*0.01;
	global.movement_hspeed += (0 - global.movement_hspeed)*0.01;
}
if (global.apply_buff_effect[6]) //출혈
{
	bleeding_timer ++;
	if (bleeding_timer > 180) //3초당 -1.5씩 체력 감소 (초당 0.5)
	{
		give_damage(tmp_my_p,1.5,true,0,x,y,10);
		bleeding_timer = 0;
	}
}

//배고픔
global.apply_buff_effect[7] = (global.hunger <= 10);
if (global.apply_buff_effect[7])
{
	hunger_timer ++;
	if (hunger_timer > 600) //매 10초마다 배고픔에 비례하여 체력 감소 (최대 10초당 6씩 = 초당 0.6)
	{
		tmp_my_p.hp -= (6-global.hunger*0.5);
		hunger_timer = 0;
	}
}

//목마름
global.apply_buff_effect[8] = (global.hydration <= 10);
if (global.apply_buff_effect[8])
{
	hydration_timer ++;
	if (hydration_timer > 600) //매 10초마다 목마름에 비례하여 체력 감소 (최대 10초당 2씩 = 초당 0.2)
	{
		tmp_my_p.hp -= (2-global.hydration*0.1);
		hydration_timer = 0;
	}
}


//체력 재생
if (global.apply_buff_effect[12])
{
	hp_recovery_timer ++;
	if (hp_recovery_timer > 300) //매 5초마다 +2씩 체력 재생 (초당 0.4)
	{
		tmp_my_p.hp += 2;
		hp_recovery_timer = 0;
	}
}
else
{
	hp_recovery_timer = 0;
}

//중독
if (global.apply_buff_effect[15])
{
	poisoning_timer ++;
	if (poisoning_timer > 180) //매 3초마다 -1씩 체력 감소 (초당 0.33...)
	{
		tmp_my_p.hp -= 1;
		poisoning_timer = 0;
	}
}



//슬라임 점액질 충돌 판정
with(obj_mob_parents)
{
	if (z <= 0 && place_meeting(x,y,obj_mucus_effect))
	{
		_speed += (0 - _speed)*0.2;
		
		if (id == tmp_my_p)
		{
			global.apply_buff_effect[0] = true;
		}
	}
}