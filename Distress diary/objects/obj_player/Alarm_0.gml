/// @description 사망시 퀵 슬롯 아이템 드랍
// You can write your code in this editor
//퀵 슬롯 내의 모든 아이템 드랍

var i = drop_index;
if (global.quickslot_spr_ind[i] != -4)
{
	//아이템 가로-세로 사이즈 구하기
	set_item_info_values(global.quickslot_spr_ind[i],global.quickslot_img_ind[i]);
						
	//아이템 드랍
	var tmp_spr_ind = [ spr_backpack, spr_comp, spr_foods, spr_healings, spr_stackables, spr_drink, spr_weapon, spr_equipments, spr_pickaxe, spr_others ];
	var tmp_get_index = 0;
	for(var ii = 0; ii < array_length(tmp_spr_ind); ii++)
	{
		if (tmp_spr_ind[ii] == global.quickslot_spr_ind[i])
		{
			tmp_get_index = ii;
			break;
		}
	}
	drop_item(tmp_get_index,global.quickslot_img_ind[i],global.quickslot_stack_num[i],global.item_width,global.item_height,global.quickslot_startag[i],true,x+irandom_range(-16,16),y+irandom_range(-16,16));
						
	//퀵슬롯 내의 아이템은 삭제
	global.quickslot_spr_ind[i] = -4;
	set_status_by_weapon(-4,-4);
}

drop_index ++;
if (drop_index < 9)
{
	alarm[0] = 2;
}

