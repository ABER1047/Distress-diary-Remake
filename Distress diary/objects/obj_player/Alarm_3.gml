/// @description Insert description here
// You can write your code in this editor


if (gage_bar_charged > 0)
{
	var tmp_weight_ratio = fix_to_zero(global.my_weight-global.over_weight)/90;
	var speed_by_weight = fix_to_zero(power(1-tmp_weight_ratio,1.5));
	global.attack_cooldown_timer = 1;
	gage_bar_charged -= 0.025*6;
	alarm[3] = 6/speed_by_weight;
	alarm[2] = 1;
}
else
{
	gage_bar_charged = 0;
}