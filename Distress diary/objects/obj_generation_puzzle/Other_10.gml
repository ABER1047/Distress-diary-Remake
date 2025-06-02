/// @description Insert description here
// You can write your code in this editor


//퍼즐 생성
for(var i = -3; i <= 3; i++)
{
	for(var ii = -3; ii <= 3; ii++)
	{
		var tmp_xx = x+i*96 - 48;
		var tmp_yy = y+ii*96;
		if (position_meeting(tmp_xx,tmp_yy,supporter_arr[0]))
		{
			instance_create_multiplayer(obj_pillar_with_crystal,tmp_xx,tmp_yy + 96,global.object_id_ind,3,true,xpos,ypos);
		}
		else if (position_meeting(tmp_xx,tmp_yy,supporter_arr[1]))
		{
			var tmp_img_ind = 2;
			instance_create_multiplayer_ext(obj_pillar,tmp_xx,tmp_yy + 96,global.object_id_ind,0,true,xpos,ypos,"s_img_ind",string(tmp_img_ind));
		}
		else if (position_meeting(tmp_xx,tmp_yy,supporter_arr[2]))
		{
			instance_create_multiplayer(obj_pillar,tmp_xx,tmp_yy + 96,global.object_id_ind,choose(1,2),true,xpos,ypos);
		}
		else if (position_meeting(tmp_xx,tmp_yy,supporter_arr[3]))
		{
			instance_create_multiplayer(obj_pillar,tmp_xx,tmp_yy + 96,global.object_id_ind,0,true,xpos,ypos);
		}
		else if (position_meeting(tmp_xx,tmp_yy,supporter_arr[4]))
		{
			var tmp_ind = (!position_meeting(tmp_xx,tmp_yy-96,obj_only_breakable)) ? choose(0,1,2) : choose(1,2);
			instance_create_multiplayer(obj_pillar,tmp_xx,tmp_yy + 96,global.object_id_ind,tmp_ind,true,xpos,ypos);
		}
		else if (!skip_button_created && position_meeting(tmp_xx,tmp_yy,supporter_arr[5]))
		{
			//instance_create_multiplayer(obj_floor_button,tmp_xx,tmp_yy + 96,global.object_id_ind,2,false,xpos,ypos);
			skip_button_created = true;
		}
	}
}


//생성 완료
show_message_log("퍼즐 생성 완료! - ["+string(xpos)+", "+string(ypos)+" / seed:"+string(rd_map_angle)+string(rd_map_img_ind)+"]");
instance_destroy();
//instance_destroy(obj_g_puzzle_parents);