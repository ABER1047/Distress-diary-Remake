// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param soundid
///@param loops
///@param volume
function play_sound(argument0,argument1,argument2)
{
	return audio_play_sound(argument0,1,argument1,global.master_volume*global.sfx_volume*argument2);
}