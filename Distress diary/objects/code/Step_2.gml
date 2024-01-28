/// @description Insert description here
// You can write your code in this editor

//새로운 플레이어가 중도 참여했을 때, 맵 데이터 전송
if (global.new_player_joined > 0)
{
	send_NewMapData();
	global.new_player_joined --;
}













