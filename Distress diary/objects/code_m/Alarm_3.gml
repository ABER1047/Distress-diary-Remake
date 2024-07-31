/// @description 서버 접속이 제대로 되었는지 체크
// You can write your code in this editor


//한번도 튕겼나 아닌가 체크하는 명령이 안 온경우
if (!global.is_check_me)
{
	//연결 끊기
	event_user(0);
}


//서버 자체가 닫힌 경우를 대비해 항상 주기적으로 체크
global.is_check_me = false;
alarm[3] = floor(global.maximum_ping_acception/5*4)*2;