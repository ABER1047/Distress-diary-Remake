/// @description Insert description here
// You can write your code in this editor
if (!instance_exists(obj_ui_parents) && global.attack_speed > 0 && !global.is_mouse_inside_quickslot)
{
	if (!global.prohibit_movement_input)
	{
		//차징 공격
		if (global.attack_type != 1 && global.my_player_id == obj_id_player_only && global.attack_speed > 0)
		{
			event_user(0);
		}
	}
}
else
{
	gage_bar_charged = 0;
}