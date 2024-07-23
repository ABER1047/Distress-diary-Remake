/// @description Insert description here
// You can write your code in this editor


if (gage_bar_charged > 0)
{
	global.attack_cooldown_timer = 1;
	gage_bar_charged -= 0.025*6;
	alarm[3] = 6;
	alarm[2] = 1;
}
else
{
	gage_bar_charged = 0;
}