/// @description 서버 접속이 제대로 되었는지 체크
// You can write your code in this editor


//한번도 튕겼나 아닌가 체크하는 명령이 안 온경우
if (!global.is_check_me)
{
	//연결 끊기
	event_user(0);
}