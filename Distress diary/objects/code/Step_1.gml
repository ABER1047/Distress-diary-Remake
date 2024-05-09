/// @description Insert description here


//사운드 볼륨 조절용 거리 값
var tmp_ins = global.my_player_ins_id[global.my_player_id];
if (instance_exists(tmp_ins))
{
	audio_listener_position(-tmp_ins.x,-tmp_ins.y,tmp_ins.z);
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
	if (global.time == 60*6.5)//오전 6시 30분 (낮)
	{
		global.time_is_day = true;
	}
	else if (global.time == 60*22)//오후 10시 (밤)
	{
		global.time_is_day = false;
	}
	
	if (global.time >= 60*24)
	{
		global.time -= 60*24;
	}
}