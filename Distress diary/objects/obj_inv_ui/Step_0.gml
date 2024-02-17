/// @description Insert description here
// You can write your code in this editor

//인벤토리 정보 변수를 가지고 있는 인스턴스 
var tmp_owner = variable_owner;

//인벤토리 ui정보 리로드
if (reload_inv == 1)
{
	with(obj_inv_item)
	{
		if (object_index != obj_inv_ui)
		{
			if (parents_id == other.id)
			{
				instance_destroy();
			}
		}
	}


	for(var i = 0; i < tmp_owner.inv_height; i++)
	{
		for(var ii = 0; ii < tmp_owner.inv_width; ii++)
		{
			if (sprite_exists(tmp_owner.inv_info_spr_ind[i][ii]))
			{
				create_inv_item(tmp_owner.inv_info_spr_ind[i][ii],tmp_owner.inv_info_img_ind[i][ii],tmp_owner.inv_info_name[i][ii],tmp_owner.inv_info_stack_num[i][ii],tmp_owner.inv_info_max_stack_num[i][ii],id,ii,i,tmp_owner.inv_info_width[i][ii],tmp_owner.inv_info_height[i][ii],tmp_owner.inv_info_rotated[i][ii]);
			}
		}
	}
	
	reload_inv = -4;
}







//인벤토리 최대 거리 적용 (거리 벗어나면 자동으로 닫히는 기능)
var tmp_my_p = global.my_player_ins_id[global.my_player_id]; //내 플레이어 인스턴스
if (max_distance != -4 && instance_exists(tmp_my_p) && point_distance(tmp_owner.x,tmp_owner.y,tmp_my_p.x,tmp_my_p.y) > max_distance)
{
	instance_destroy();
}





