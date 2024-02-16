/// @description Insert description here
// You can write your code in this editor



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

	var tmp_owner = variable_owner;
	
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













