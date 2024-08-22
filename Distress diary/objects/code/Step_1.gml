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
global.defence_power = (sign(global.buff_left_time[9]) - sign(global.buff_left_time[10]))*2.5; //방어력
global.over_weight = 10 + (sign(global.buff_left_time[11])*10); //최대 중량

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
		if (global.buff_left_time[i] <= 1)
		{
			global.buff_timer[i] = 0;
			global.buff_max_left_time[i] = 1;
		}
	}
}

//이속 저하 - 슬라임 점액질 충돌 판정
with(obj_mob_parents)
{
	if (z <= 0 && place_meeting(x,y,obj_mucus_effect))
	{
		if (id == tmp_my_p)
		{
			buff_activate(0,60);
		}
		else
		{
			_speed += (0 - _speed)*0.2;
		}
	}
}


//과적
global.buff_left_time[4] = (global.my_weight > 10);

if (global.buff_left_time[5] > 0) //골절
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

if (global.buff_timer[6] > 180) //3초당 -1.5씩 체력 감소 (초당 0.5)
{
	give_damage(tmp_my_p,1.5,true,0,x,y,10);
	global.buff_timer[6] = 0;
}


//배고픔
global.buff_left_time[7] = (global.hunger <= 10);
if (global.buff_timer[7] > 600) //매 10초마다 배고픔에 비례하여 체력 감소 (최대 10초당 6씩 = 초당 0.6)
{
	tmp_my_p.hp -= (6-global.hunger*0.5);
	global.buff_timer[7] = 0;
}


//목마름
global.buff_left_time[8] = (global.hydration <= 10);
if (global.buff_timer[8] > 600) //매 10초마다 목마름에 비례하여 체력 감소 (최대 10초당 2씩 = 초당 0.2)
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
	tmp_my_p.hp -= 1;
	global.buff_timer[15] = 0;
}


//아이템 서칭
global.searching_speed = 100*(1-sign(global.buff_left_time[16])*0.3);


//크리티컬 데미지 배율
global.critical_dmg_magnification = 0.5*(1+sign(global.buff_left_time[18]));