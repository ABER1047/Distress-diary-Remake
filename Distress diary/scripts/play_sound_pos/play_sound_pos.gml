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
	var tmp_dis_room = point_distance(tmp_xpos,tmp_ypos,my_pos_xx,my_pos_yy)*tmp_room_size;
	
	//사운드 볼륨 조절용 거리 값
	var distance_ = fix_to_zero(1-(point_distance(argument3,argument4,obj_camera.x,obj_camera.y)+tmp_dis_room)/argument5);
	
	
	//소리 볼륨이 0인경우 플레이 안함 
	var tmp_sound = -4;
	if (distance_ > 0)
	{
		tmp_sound = play_sound(argument0,argument1,argument2*distance_);
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
	
	return tmp_sound;
}