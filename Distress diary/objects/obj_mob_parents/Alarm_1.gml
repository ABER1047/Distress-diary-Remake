/// @description 매 25번째 틱레이트마다 위치/이미지 정보 전송 (몬스터 정보는 서버측에서 관리)


if (global.is_server)
{
	send_ImgData(obj_id,id,sprite_index,image_index,x,y,z,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	alarm[1] = global.tickrate*25;
}
