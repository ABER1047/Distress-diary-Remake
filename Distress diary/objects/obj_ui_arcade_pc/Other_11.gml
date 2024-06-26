/// @description Insert description here
// You can write your code in this editor
var output = bet_amount*(my_bet_dice+2);
var tmp_my_p = global.my_player_ins_id[global.my_player_id];


if (i != -4 && ii != -4 && tmp_my_p.inv_info_stack_num[i][ii]+output <= tmp_my_p.inv_info_max_stack_num[i][ii]) //인벤토리에 칸이 있는 경우
{
	tmp_my_p.inv_info_stack_num[i][ii] += output;
	global.my_gold += output;
	show_message_log("보상 지급 - ["+string(ii)+", "+string(i)+" / "+string(tmp_my_p.inv_info_stack_num[i][ii])+"]");
}
else
{
	//인벤에 아이템이 꽉 찬 경우 아이템 떨구기
	drop_item(spr_stackables,0,output,1,1,0);
}