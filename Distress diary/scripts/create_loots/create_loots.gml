// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param x
///@param y
///@param img_ind
///@param inv_width
///@param inv_height
///@param loots_name
///@param obj_id
///@param DoNotSend
///@param xpos
///@param ypos
function create_loots(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9)
{
	var tmp_my_pos_xx = argument8;
	var tmp_my_pos_yy = argument9;
	if (tmp_my_pos_xx == -4)
	{
		tmp_my_pos_xx = global.n_player_room_xx[global.my_player_id];
		tmp_my_pos_yy = global.n_player_room_yy[global.my_player_id];
	}
	
	
	var tmp_width = argument3;
	var tmp_height = argument4;
	var tmp_obj_id = argument6;
	
	if (argument2 != -4) //-4인경우 바닥에 떨군 아이템 보관용 박스 생성
	{
		var tmp_ins = instance_create_depth(argument0,argument1,depth,obj_loots);
		tmp_ins.image_index = argument2;
	}
	else
	{
		var tmp_ins = instance_create_depth(argument0,argument1,depth,obj_dropped_item_box);
	}
	tmp_ins.my_pos_xx = tmp_my_pos_xx;
	tmp_ins.my_pos_yy = tmp_my_pos_yy;
	
	//인벤토리 설정
	with(tmp_ins)
	{
		for(var i = 0; i < tmp_height+5; i++)
		{
			for(var ii = 0; ii < tmp_width+5; ii++)
			{
				//inv_info_spr_ind가
				//-4일때 = 비어있음
				//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
				reset_inv_variable(ii,i);
			}
		}
		
		if (id == tmp_ins)
		{
			set_inv_size(tmp_width,tmp_height);
			obj_id = tmp_obj_id;
			loots_name = argument5;
		}
	}
	
	
	
	show_message_log("- 상자 생성 [obj_id : "+string(tmp_obj_id)+"]");
	

	//생성된 상자 정보 다른 멀티플레이어한테 보내서 그쪽에도 오브젝트 생성하기
	if (!argument7)
	{
		buffer_seek(global.obj_data_buffer, buffer_seek_start, 0);
		buffer_write(global.obj_data_buffer, buffer_u8, global.DATA_CHEST_DATA);
		buffer_write(global.obj_data_buffer, buffer_string, global.my_player_id);
		buffer_write(global.obj_data_buffer, buffer_string, argument0);
		buffer_write(global.obj_data_buffer, buffer_string, argument1);
		buffer_write(global.obj_data_buffer, buffer_string, argument2);
		buffer_write(global.obj_data_buffer, buffer_string, tmp_width);
		buffer_write(global.obj_data_buffer, buffer_string, tmp_height);
		buffer_write(global.obj_data_buffer, buffer_string, argument5);
		buffer_write(global.obj_data_buffer, buffer_string, tmp_obj_id);
		buffer_write(global.obj_data_buffer, buffer_string, tmp_my_pos_xx);
		buffer_write(global.obj_data_buffer, buffer_string, tmp_my_pos_yy);
		send_all(global.obj_data_buffer);
	}
	
	global.object_id_ind ++;
	return tmp_ins;
}