/// @description Server remove client info
// You can write your code in this editor
buffer_seek(dis_buffer, buffer_seek_start, 0);
buffer_write(dis_buffer, buffer_u8, DATA.REMOVE_CLI);
buffer_write(dis_buffer, buffer_string, global.my_player_id);
send_all(dis_buffer);