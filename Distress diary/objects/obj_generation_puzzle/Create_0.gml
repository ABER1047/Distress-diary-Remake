/// @description Insert description here
// You can write your code in this editor




var tmp_xx = global.n_player_room_xx[global.my_player_id];
var tmp_yy = global.n_player_room_yy[global.my_player_id];
if (tmp_xx != -4 && tmp_yy != -4)
{
	//고정 사이즈의 방 세팅
	global.map_room_width[tmp_yy][tmp_xx] = 8;
	global.map_room_height[tmp_yy][tmp_xx] = 8;
	
	load_room(tmp_xx,tmp_yy);



	//퍼즐 생성전 퍼즐맵 타일 크기 조정
	x = room_width*0.5-48;
	y = room_height*0.5;
	image_xscale = 1/48;
	image_yscale = 1/48;


	//퍼즐맵 각도 랜덤하게 설정
	rd_map_angle = irandom_range(0,3)*90;
	rd_map_img_ind = irandom_range(0,sprite_get_number(spr_puzzle_tile)/5)*5;


	//퍼즐 생성용 맵 타일 생성
	var tmp_ins = instance_create_depth(x,y,0,puzzle_generation_step0);
	tmp_ins.image_angle = rd_map_angle;
	var tmp_ins = instance_create_depth(x,y,0,puzzle_generation_step1);
	tmp_ins.image_angle = rd_map_angle;
	var tmp_ins = instance_create_depth(x,y,0,puzzle_generation_step2);
	tmp_ins.image_angle = rd_map_angle;
	var tmp_ins = instance_create_depth(x,y,0,puzzle_generation_step3);
	tmp_ins.image_angle = rd_map_angle;
	var tmp_ins = instance_create_depth(x,y,0,puzzle_generation_step4);
	tmp_ins.image_angle = rd_map_angle;
	
	alarm[0] = 1;
}
else
{
	//생성 실패
	show_message_log("퍼즐 생성 실패!");
	instance_destroy(obj_g_puzzle_parents);
}
