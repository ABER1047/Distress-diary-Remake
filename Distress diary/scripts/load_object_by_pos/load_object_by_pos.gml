// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param time
function load_object_by_pos(argument0)
{
	//기존 모든 오브젝트의 스텝이벤트에서 작동하던 statement_by_pos() 함수를
	//방 하나를 로드 할 때에만 작동시켜 코드를 최적화하는 용도로 사용됨
	var tmp_time = argument0;
	if (global.load_map_repeater < tmp_time)
	{
		global.load_map_repeater = tmp_time;
	}
}