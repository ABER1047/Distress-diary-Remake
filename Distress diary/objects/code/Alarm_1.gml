/// @description Slowed step
//스텝이벤트 역할을 하는데, 좀 딜레이가 있는 스텝이벤트


//인벤토리 코인 갯수/무게 측정
var tmp_my_p = global.my_player_ins_id[global.my_player_id];
var inv_weight = 0, inv_gold_num = 0;
for(var i = 0; i < tmp_my_p.inv_height; i++)
{
	for(var ii = 0; ii < tmp_my_p.inv_width; ii++)
	{
		var tmp_spr_ind_real = tmp_my_p.inv_info_spr_ind[i][ii];
		if (sprite_exists(tmp_spr_ind_real))
		{
			var tmp_weight = tmp_my_p.inv_info_weight[i][ii];
			if (tmp_my_p.inv_info_max_stack_num[i][ii] > 0)
			{
				var tmp_stacks = tmp_my_p.inv_info_stack_num[i][ii];
				if (tmp_my_p.inv_info_img_ind[i][ii] == 0)
				{
					inv_gold_num += tmp_stacks;
				}
				inv_weight += tmp_stacks*tmp_weight;
			}
			else
			{
				inv_weight += tmp_weight;
			}
		}
	}
}

for(var i = 0; i < 9; i++)
{
	//퀵슬롯 정보도 계산
	var tmp_spr = global.quickslot_spr_ind[i];
	if (sprite_exists(tmp_spr))
	{
		if (global.quickslot_stack_num[i] > 0)
		{
			inv_weight += global.quickslot_weight[i]*global.quickslot_stack_num[i];
			if (global.quickslot_img_ind[i] == 0)
			{
				inv_gold_num += global.quickslot_stack_num[i];
			}
		}
		else
		{
			inv_weight += global.quickslot_weight[i];
		}
	}
}
		
//내 무게 설정
global.my_weight = inv_weight;
		
//내 보유 골드 설정
global.my_gold = inv_gold_num;






//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
if (global.load_map_repeater <= 0)
{
	with(obj_mob_parents)
	{
		statement_by_pos();
	}
}






//step
alarm[1] = 15;


