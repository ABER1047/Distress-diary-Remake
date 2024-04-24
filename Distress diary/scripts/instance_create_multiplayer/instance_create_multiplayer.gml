// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param object_index
///@param x
///@param y
///@param obj_id
///@param image_index
///@param DoNotSend
///@param xpos
///@param ypos
function instance_create_multiplayer(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7)
{
	var tmp_obj_ind = argument0;
	var tmp_xx = argument1;
	var tmp_yy = argument2;
	var tmp_obj_id = argument3;
	var tmp_img_ind = argument4;
	
	show_debug_message("- 오브젝트 생성 [obj_id : "+string(tmp_obj_id)+"]");
	var tmp_ins = instance_create_depth(tmp_xx,tmp_yy,0,tmp_obj_ind);
	tmp_ins.image_index = tmp_img_ind;
	tmp_ins.obj_id = tmp_obj_id;

	
	
	if (argument5 == false)
	{
		var tmp_my_pos_xx = argument6;
		var tmp_my_pos_yy = argument7;
		if (argument6 == -4)
		{
			tmp_my_pos_xx = global.n_player_room_xx[global.my_player_id];
			tmp_my_pos_yy = global.n_player_room_yy[global.my_player_id];
		}
		tmp_ins.my_pos_xx = tmp_my_pos_xx;
		tmp_ins.my_pos_yy = tmp_my_pos_yy;
		
		
		send_InstanceData(tmp_ins);
	}
	
	
	global.object_id_ind ++;
	return tmp_ins;
}