/// @description Insert description here
// You can write your code in this editor


//퍼즐 생성
for(var i = -3; i <= 3; i++)
{
	for(var ii = -3; ii <= 3; ii++)
	{
		var tmp_xx = x+i*96 - 48;
		var tmp_yy = y+ii*96;
		if (position_meeting(tmp_xx,tmp_yy,puzzle_generation_step0))
		{
			instance_create_multiplayer(obj_only_breakable_pushable,tmp_xx,tmp_yy + 96,global.object_id_ind,62,false);
		}
		else if (position_meeting(tmp_xx,tmp_yy,puzzle_generation_step1))
		{
			instance_create_multiplayer(obj_floor_button,tmp_xx,tmp_yy + 96,global.object_id_ind,58,false);
		}
		else if (position_meeting(tmp_xx,tmp_yy,puzzle_generation_step2))
		{
			instance_create_multiplayer(obj_only_breakable,tmp_xx,tmp_yy + 96,global.object_id_ind,choose(31,32),false);
		}
		else if (position_meeting(tmp_xx,tmp_yy,puzzle_generation_step3))
		{
			instance_create_multiplayer(obj_only_breakable,tmp_xx,tmp_yy + 96,global.object_id_ind,30,false);
		}
		else if (position_meeting(tmp_xx,tmp_yy,puzzle_generation_step4))
		{
			instance_create_multiplayer(obj_only_breakable,tmp_xx,tmp_yy + 96,global.object_id_ind,choose(30,31,32),false);
		}
	}
}


//생성 완료
show_message_log("퍼즐 생성 완료! - [seed:"+string(rd_map_angle)+string(rd_map_img_ind)+"]");
//instance_destroy(obj_g_puzzle_parents);