/// @description Insert description here
// You can write your code in this editor

//플레이어 이동 금지인거 풀기
global.prohibit_movement_input = false;

//창 닫힌거 감지
if (instance_exists(parent_id))
{
	parent_id.is_opened = -4;
	
	//효과음
	play_sound_pos(arcade_off_sfx,false,0.07,parent_id.x,parent_id.y,640,false,-4,-4);
}


//서피스 삭제
surf_free(crt_surf);