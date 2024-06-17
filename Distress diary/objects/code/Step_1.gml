/// @description Insert description here

//사운드 볼륨 조절용 거리 값
if (array_length(global.my_player_ins_id) > global.my_player_id)
{
	var tmp_ins = global.my_player_ins_id[global.my_player_id];
	if (instance_exists(tmp_ins))
	{
		audio_listener_position(-tmp_ins.x,-tmp_ins.y,tmp_ins.z);
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










// 버프/디버프 시스템
if (global.apply_buff_effect[0]) //속도 저하 (속도 증가 효과는 플레이어 오브젝트에서 따로 처리)
{
	global.movement_vspeed += (0 - global.movement_vspeed)*0.2;
	global.movement_hspeed += (0 - global.movement_hspeed)*0.2;
	global.apply_buff_effect[0] = false;
}

if (global.apply_buff_effect[2]) //공격력 감소
{
}
if (global.apply_buff_effect[3]) //공격력 증가
{
}

//과적
global.apply_buff_effect[3] = (global.my_weight > 10);

if (global.apply_buff_effect[5]) //골절
{
}
if (global.apply_buff_effect[6]) //출혈
{
}
if (global.apply_buff_effect[7]) //배고픔
{
}

//슬라임 점액질 충돌 판정
with(obj_mob_parents)
{
	if (z <= 0 && place_meeting(x,y,obj_mucus_effect))
	{
		_speed += (0 - _speed)*0.2;
		
		if (id == global.my_player_ins_id[global.my_player_id])
		{
			global.apply_buff_effect[0] = true;
		}
	}
}