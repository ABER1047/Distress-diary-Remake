// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@param soundid
///@param loops
///@param volume
///@param x
///@param y
///@param max_dis
///@param DoNotSend
///@param xpos
///@param ypos
function play_sound_pos(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8)
{
	var tmp_room_size = 960; //임의의 방 하나의 사이즈 (실제 방사이즈 아님)
	
	//내 플레이어가 있는 방 위치
	var my_pos_xx = global.n_player_room_xx[global.my_player_id];
	var my_pos_yy = global.n_player_room_yy[global.my_player_id];
	
	//소리가 근원지의 방 위치 
	var tmp_xpos = (argument7 != -4) ? argument7 : my_pos_xx;
	var tmp_ypos = (argument8 != -4) ? argument8 : my_pos_yy;
	
	//룸 사이의 거리
	var tmp_dis_xx = (tmp_xpos-my_pos_xx)*tmp_room_size;
	var tmp_dis_yy = (tmp_ypos-my_pos_yy)*tmp_room_size;


	//사운드 플레이
	var tmp_sound = -4;
	var tmp_xx = -(argument3+tmp_dis_xx);
	var tmp_yy = -(argument4+tmp_dis_yy);
	var tmp_ins = global.my_player_ins_id[global.my_player_id];
	if (instance_exists(tmp_ins) && point_distance(tmp_ins.x,tmp_ins.y,tmp_xx,tmp_yy) <= argument5+64)
	{
		tmp_sound = audio_play_sound_at(argument0,-(argument3+tmp_dis_xx),-(argument4+tmp_dis_yy),0,64,argument5,10,argument1,0,argument2*global.master_volume*global.sfx_volume);
	}
	
	
	if (!argument6 && !argument1)
	{
		buffer_seek(global.sfx_data_buffer, buffer_seek_start, 0);
		buffer_write(global.sfx_data_buffer, buffer_u8, global.DATA_SFX_DATA);
		buffer_write(global.sfx_data_buffer, buffer_string, global.my_player_id);
		buffer_write(global.sfx_data_buffer, buffer_string, audio_get_name(argument0));
		buffer_write(global.sfx_data_buffer, buffer_string, argument2);
		buffer_write(global.sfx_data_buffer, buffer_string, argument3);
		buffer_write(global.sfx_data_buffer, buffer_string, argument4);
		buffer_write(global.sfx_data_buffer, buffer_string, argument5);
		buffer_write(global.sfx_data_buffer, buffer_string, tmp_xpos);
		buffer_write(global.sfx_data_buffer, buffer_string, tmp_ypos);
		send_all(global.sfx_data_buffer);
	}
	
	show_debug_message("real_x : "+string(argument3)+" / real_y : "+string(argument4));
	show_debug_message("x : "+string(argument3+tmp_dis_xx)+" / y : "+string(argument4+tmp_dis_yy));
	
	return tmp_sound;
}