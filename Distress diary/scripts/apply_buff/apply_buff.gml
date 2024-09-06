// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param ins_id
///@param buff_index
///@param time(negativeToClearBuff)
///@param [addTime]
function apply_buff(argument0,argument1,argument2,argument3)
{
	var chk_applied = false;
	var tmp_ins = argument0, tmp_index = argument1, tmp_time = argument2;
	if (instance_exists(tmp_ins))
	{
		if (argument3 == undefined || argument3 == false)
		{
			if (tmp_time > 0)
			{
				if (tmp_time > tmp_ins.buff_left_time[tmp_index])
				{
					tmp_ins.buff_left_time[tmp_index] = tmp_time
					chk_applied = true;
				}
			}
			else
			{
				tmp_ins.buff_left_time[tmp_index] = 0;
				chk_applied = true;
			}
		}
		else
		{
			tmp_ins.buff_left_time[tmp_index] += tmp_time;
			chk_applied = true;
		}
		
		
		//내 플레이어인 경우
		if (tmp_ins == global.my_player_ins_id[global.my_player_id])
		{
			var get_max_time = max(global.buff_max_left_time[tmp_index],global.buff_left_time[tmp_index]);
			global.buff_left_time[tmp_index] = tmp_ins.buff_left_time[tmp_index];
			global.buff_max_left_time[tmp_index] = get_max_time;
		}
		
		
		//적용된 버프 효과를 네트워크 전송
		if (chk_applied)
		{
			send_InstanceVariableData(tmp_ins,"buff_left_time["+string(tmp_index)+"]",tmp_ins.buff_left_time[tmp_index]);
		}
	}
	
	return chk_applied;
}