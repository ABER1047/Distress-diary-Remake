/// @description Item info window
// You can write your code in this editor


//아이템 위에 마우스가 올라간 경우 (아이템 이동 중이 아닌 경우)
if (mouse_on == 1 && moving_now == 0)
{
	//마우스 올려놓은지 0.33초 뒤에 창 표기
	item_info_window_timer ++;
	if (item_info_window_timer > 20)
	{
		show_item_info = true;
		obj_cursor.hide_cursor = true;
	}
}
else
{
	show_item_info = false;
	item_info_window_timer = 0;
}