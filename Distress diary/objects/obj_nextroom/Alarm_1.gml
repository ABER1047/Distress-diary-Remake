/// @description Insert description here
// You can write your code in this editor

var tmp_xx = [ 1, 0, -1, 0 ];
var tmp_yy = [ 0, -1, 0, 1 ];

var n_xx = global.n_player_room_xx[global.my_player_id];
var n_yy = global.n_player_room_yy[global.my_player_id];
var t_xx = global.n_player_room_xx[global.my_player_id]+tmp_xx[tp_to];
var t_yy = global.n_player_room_yy[global.my_player_id]+tmp_yy[tp_to];

var is_connected = 0;
if (is_inside_array(global.map_width,t_xx) && is_inside_array(global.map_height,t_yy))
{
	//이동 예정인 룸이 현재 룸과 연결되어 있는지 체크
	var is_connected = 0;
	var condition1 = (global.room_connected_to_xx[t_yy][t_xx] == n_xx && global.room_connected_to_yy[t_yy][t_xx] == n_yy);
	var condition2 = (global.room_connected_to_xx[n_yy][n_xx] == t_xx && global.room_connected_to_yy[n_yy][n_xx] == t_yy);
	var condition3 = (global.room_connected_to_xx_sec[t_yy][t_xx] == n_xx && global.room_connected_to_yy_sec[t_yy][t_xx] == n_yy);
	var condition4 = (global.room_connected_to_xx_sec[n_yy][n_xx] == t_xx && global.room_connected_to_yy_sec[n_yy][n_xx] == t_yy);
	if (condition1 || condition2 || condition3 || condition4)
	{
		is_connected = 1;
	}
}


image_alpha = (is_connected == 1) ? 0.2 : 0;
can_use_tp = 1;





//깊이 설정
depth = obj_map_texture_draw.depth-1;





