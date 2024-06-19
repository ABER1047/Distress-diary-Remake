// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sprite_get_name_inv(argument0)
{
	return (argument0 == -3 || argument0 == -4) ? argument0 : sprite_get_name(argument0); 
}