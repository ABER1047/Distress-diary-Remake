// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param x
///@param y
///@param inv_name
///@param variable_owner
///@param max_distance
///@param [reload_inv]

function show_inv_ui(argument0,argument1,argument2,argument3,argument4,argument5)
{
	//인벤토리 관련 변수를 가진 인스턴스 (= variable_owner) 가 존재하는 경우
	var tmp_owner = argument3;
	if (instance_exists(tmp_owner))
	{
		var text_ratio = global.reversed_ratio_by_camera;
		var slot_size = 40*text_ratio; //1칸당 픽셀 사이즈
		var tmp_width = tmp_owner.inv_width, tmp_height = tmp_owner.inv_height;
		var xx_w = camera_get_view_width(view_camera[0]), yy_h = camera_get_view_height(view_camera[0]);
		var tmp_ins = instance_create_depth(-999,-999,global.min_depth,obj_inv_ui);
		tmp_ins.x_pos = floor(((argument0 == "center") ? xx_w*0.5 : argument0) - slot_size*tmp_width*0.5);
		tmp_ins.y_pos = floor(((argument1 == "center") ? yy_h*0.5 : argument1) - slot_size*tmp_height*0.5);
		tmp_ins.inv_name = argument2;
		tmp_ins.variable_owner = tmp_owner;
		tmp_ins.max_distance = argument4;
		//해당 인벤토리 ui 리로드
		tmp_ins.reload_inv = (argument5 != undefined);
		
		//인벤토리 효과음
		var target_ins_for_sfx = (object_index == code) ? obj_player : self;
		play_sound_pos(inventory1_sfx,false,0.1,target_ins_for_sfx.x,target_ins_for_sfx.y,160,false,-4,-4);
		play_sound_pos(inventory2_sfx,false,0.1,target_ins_for_sfx.x,target_ins_for_sfx.y,160,false,-4,-4);
		
		for(var i = 0; i < tmp_height; i++)
		{
			for(var ii = 0; ii < tmp_width; ii++)
			{
				var tmp_spr_ind_real = tmp_owner.inv_info_spr_ind[i][ii];
				if (sprite_exists(tmp_spr_ind_real))
				{
					create_inv_item(tmp_spr_ind_real,tmp_owner.inv_info_img_ind[i][ii],tmp_owner.inv_info_stack_num[i][ii],tmp_ins,ii,i,tmp_owner.inv_info_width[i][ii],tmp_owner.inv_info_height[i][ii],tmp_owner.inv_info_rotated[i][ii],tmp_owner.inv_info_searched[i][ii],tmp_owner.inv_info_startag[i][ii]);
				}
			}
		}
		
		show_debug_message("show_inv_ui : "+string(tmp_owner)+" / "+string(tmp_owner.inv_info_name_compressed));
		
		//변수를 가지고 있는 인스턴스한테 ui창 인스턴스 아이디 값 저장
		tmp_owner.ui_ins = tmp_ins;
		
		
		show_debug_message("루팅 중... / "+string(object_get_name(tmp_owner.object_index))+" / "+string(tmp_owner.obj_id)+" ["+string(tmp_owner.inv_width)+", "+string(tmp_owner.inv_height)+"]");
		return tmp_ins;
	}
	else
	{
		return false;
	}
}