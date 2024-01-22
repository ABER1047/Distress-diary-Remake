// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@desc load_room();
///@param x
///@param y
function load_room(argument0,argument1)
{
	//현재 룸 가로/세로 넓이
	global.n_room_width = global.map_room_width[argument1][argument0];
	global.n_room_height = global.map_room_height[argument1][argument0];
	show_message_log("현재 룸 사이즈 (가로 x 세로) : "+string(global.n_room_width)+" x "+string(global.n_room_height));
	
	
	
	
	
	//모든 벽 삭제
	instance_destroy(obj_wall_parents);
	
	//모든 룸 이동 포탈 삭제
	instance_destroy(obj_nextroom);
	
	
	//위쪽 벽 드로워 생성
	if (!instance_exists(obj_wall_upper_drawer))
	{
		instance_create_depth(0,0,0,obj_wall_upper_drawer);
	}
	
	
	//룸 사이즈 맞게 벽 생성
	var tmp_xx = room_width*0.5;
	var tmp_yy = room_height*0.5;
	var tmp_scale = 2; //wall_parents의 image_scale (플레이어가 현재 2배 사이즈라서 2배 해줌)
	var tmp_sprite_size = 48*tmp_scale; //obj_wall_parents의 스프라이트 사이즈
	
	
	
	//가로 벽 2개 생성
	var tmp_ins = instance_create_depth(tmp_xx-48,tmp_yy-global.n_room_height*0.5*tmp_sprite_size,0,obj_wall_parents);
	tmp_ins.sprite_index = spr_wall_mask_upper;
	tmp_ins.image_xscale = (global.n_room_width+2)*tmp_scale;
	tmp_ins.image_yscale = tmp_scale;
	
	var tmp_ins = instance_create_depth(tmp_xx-48,tmp_yy+(global.n_room_height*0.5+0.5)*tmp_sprite_size,0,obj_wall_parents);
	tmp_ins.sprite_index = spr_wall_mask_bottom;
	tmp_ins.image_xscale = (global.n_room_width+2)*tmp_scale;
	tmp_ins.image_yscale = tmp_scale;
	
	
	
	//세로 벽 2개 생성
	var tmp_ins = instance_create_depth(tmp_xx-global.n_room_width*0.5*tmp_sprite_size-90,tmp_yy,0,obj_wall_parents);
	tmp_ins.sprite_index = spr_wall_mask_left;
	tmp_ins.image_xscale = tmp_scale;
	tmp_ins.image_yscale = (global.n_room_height+2)*tmp_scale;
	
	var tmp_ins = instance_create_depth(tmp_xx+global.n_room_width*0.5*tmp_sprite_size+32,tmp_yy,0,obj_wall_parents);
	tmp_ins.sprite_index = spr_wall_mask_right;
	tmp_ins.image_xscale = tmp_scale;
	tmp_ins.image_yscale = (global.n_room_height+2)*tmp_scale;
	
	
	
	//다음 방으로 이동하는 포탈 생성
	var t_xx = [ global.n_room_width*0.5-1, 0, -global.n_room_width*0.5, 0 ];
	var t_yy = [ 0, -global.n_room_height*0.5, 0, global.n_room_height*0.5 ];
	
	for(var i = 0; i < 4; i++)
	{
		var tmp_ins = instance_create_depth(tmp_xx+t_xx[i]*tmp_sprite_size,tmp_yy+t_yy[i]*tmp_sprite_size,0,obj_nextroom);
		tmp_ins.tp_to = i;
	}	
}