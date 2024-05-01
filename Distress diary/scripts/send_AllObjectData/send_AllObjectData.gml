// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_AllObjectData()
{
	//전송할 오브젝트 종류
	var ins_ = [ obj_loots, obj_vending_machine, obj_arcade_pc, obj_only_breakable, obj_only_breakable_pushable, obj_floor_button, obj_floor_button ];
	
	
	buffer_seek(global.obj_data_buffer, buffer_seek_start, 0);
	buffer_write(global.obj_data_buffer, buffer_u8, global.DATA_OBJECTS_DATA_WHOLESCALE);
	buffer_write(global.obj_data_buffer, buffer_string, global.my_player_id);
	
	with(all)
	{
		var chk_ = false;
		for(var i = 0; i < array_length(ins_); i++)
		{
			if (object_index == ins_[i])
			{
				chk_ = true;
				break;
			}
		}
		
		
		if (chk_)
		{
			//문자열로 데이터 압축 후 보내기 (+상자류 오브젝트도 해당 부분은 공통적으로 보냄)
			var tmp_str = string(object_get_name(object_index))+"#"+string(obj_id)+"#"+string(x)+"#"+string(y)+"#"+string(image_index)+"#"+string(my_pos_xx)+"#"+string(my_pos_yy);
			show_debug_message("tmp_str : "+string(tmp_str));
			show_debug_message(tmp_str);
			
			
			if (object_index == obj_loots) //루팅 가능한 오브젝트(= 상자류) 정보 전송
			{
				//문자열로 데이터 압축 후 보내기 (상자류는 기존 문자열에 추가로 몇가지 더 정보를 붙여서 보냄)
				tmp_str = string(tmp_str)+"#"+string(inv_width)+"#"+string(inv_height)+"#"+string(loots_name);
				buffer_write(global.obj_data_buffer, buffer_string, tmp_str);
				show_debug_message(tmp_str);
			
			

				for(var i = 0; i < inv_height; i++)
				{
					for(var ii = 0; ii < inv_width; ii++)
					{
						//inv_info_spr_ind가
						//-4일때 = 비어있음
						//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
						
						//문자열로 데이터 압축 후 보내기
						var tmp_spr_name = (sprite_exists(inv_info_spr_ind[i][ii])) ? sprite_get_name(inv_info_spr_ind[i][ii]) : inv_info_spr_ind[i][ii];
						var tmp_str = string(tmp_spr_name)+"#"+string(inv_info_img_ind[i][ii])+"#"+string(inv_info_name[i][ii])+"#"+string(inv_info_name_compressed[i][ii])+"#"+string(inv_info_stack_num[i][ii])+"#"+string(inv_info_max_stack_num[i][ii])+"#"+string(inv_info_width[i][ii])+"#"+string(inv_info_height[i][ii])+"#"+string(inv_info_rotated[i][ii])+"#"+string(inv_info_weight[i][ii]);
						buffer_write(global.obj_data_buffer, buffer_string, tmp_str);
						show_debug_message(tmp_str);
					}
				}
			}
			else
			{
				//일반 오브젝트 정보만 전송
				buffer_write(global.obj_data_buffer, buffer_string, tmp_str);
			}
			show_message_log("- ["+string(obj_id)+"] 오브젝트 데이터 전송 완료");
		}
	}
	
	

	send_all(global.obj_data_buffer);
}