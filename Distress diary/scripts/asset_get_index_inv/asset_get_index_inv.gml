// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function asset_get_index_inv(argument0)
{
	return (argument0 == -3 || argument0 == -4) ? argument0 : asset_get_index(argument0);
}