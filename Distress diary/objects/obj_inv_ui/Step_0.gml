/// @description Insert description here
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


	//무게-골드 갯수를 다시 재기 위해 초기화
	var inv_weight = 0; //해당 인벤토리에 들어있는 모든 아이템 무게 총합 저장용
	var inv_gold_num = 0; //해당 인벤토리에 들어있는 모든 골드 갯수 저장용
	for(var i = 0; i < tmp_owner.inv_height; i++)
	{
		for(var ii = 0; ii < tmp_owner.inv_width; ii++)
		{
			var tmp_spr_ind_real = tmp_owner.inv_info_spr_ind[i][ii];
			if (tmp_spr_ind_real != -4)
			{
				create_inv_item(tmp_spr_ind_real,tmp_owner.inv_info_img_ind[i][ii],tmp_owner.inv_info_stack_num[i][ii],id,ii,i,tmp_owner.inv_info_width[i][ii],tmp_owner.inv_info_height[i][ii],tmp_owner.inv_info_rotated[i][ii],tmp_owner.inv_info_searched[i][ii],tmp_owner.inv_info_startag[i][ii]);
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


