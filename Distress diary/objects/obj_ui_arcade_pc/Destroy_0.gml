/// @description Insert description here
// You can write your code in this editor


global.prohibit_movement_input = false;



//닫힌거 감지
if (instance_exists(parent_id))
{
	parent_id.is_opened = -4;
	
	//효과음
	play_sound_pos(arcade_off_sfx,false,0.1,parent_id.x,parent_id.y,1280,false);
}