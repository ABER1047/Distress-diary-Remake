/// @description Insert description here
// You can write your code in this editor
/// @description 매 틱레이트마다 정보 전송 (몬스터 정보는 서버측에서 관리)
if (global.is_server)
{
	send_ImgData(obj_id,id,sprite_index,image_index,x,y,z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	alarm[1] = global.tickrate;
}
