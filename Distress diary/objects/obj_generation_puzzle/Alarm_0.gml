/// @description Insert description here
// You can write your code in this editor


if (xpos != -4 && ypos != -4)
{
	//고정 사이즈의 방 세팅
	global.map_room_width[ypos][xpos] = 8;
	global.map_room_height[ypos][xpos] = 8;
	
	//load_room(tmp_xx,tmp_yy);



	//퍼즐 생성전 퍼즐맵 타일 크기 조정
	x = room_width*0.5-48;
	y = room_height*0.5;
	image_xscale = 1/48;
	image_yscale = 1/48;


	//퍼즐맵 각도 랜덤하게 설정
	rd_map_angle = irandom_range(0,3)*90;
	rd_map_img_ind = irandom_range(0,sprite_get_number(spr_puzzle_tile)/6)*6;

	
	//퍼즐 생성용 맵 타일 생성
	supporter_arr[0] = instance_create_depth(x,y,0,puzzle_generation_step0);
	supporter_arr[0].image_angle = rd_map_angle;
	supporter_arr[1] = instance_create_depth(x,y,0,puzzle_generation_step1);
	supporter_arr[1].image_angle = rd_map_angle;
	supporter_arr[2] = instance_create_depth(x,y,0,puzzle_generation_step2);
	supporter_arr[2].image_angle = rd_map_angle;
	supporter_arr[3] = instance_create_depth(x,y,0,puzzle_generation_step3);
	supporter_arr[3].image_angle = rd_map_angle;
	supporter_arr[4] = instance_create_depth(x,y,0,puzzle_generation_step4);
	supporter_arr[4].image_angle = rd_map_angle;
	supporter_arr[5] = instance_create_depth(x,y,0,puzzle_generation_step5);
	supporter_arr[5].image_angle = rd_map_angle;
	
	
	event_user(0);
}
else
{
	//생성 실패
	show_message_log("퍼즐 생성 실패!");
	instance_destroy();
}