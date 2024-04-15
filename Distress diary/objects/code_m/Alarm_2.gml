/// @description 서버측에서 튕겼나 아닌가 체크하는거에 대답하는 코드
// You can write your code in this editor

buffer_seek(dis_buffer, buffer_seek_start, 0);
buffer_write(dis_buffer, buffer_u8, DATA.REPLY_STILL_PLAYING);
buffer_write(dis_buffer, buffer_string, global.my_player_id);
send_all(dis_buffer);

global.is_check_me = true;
















