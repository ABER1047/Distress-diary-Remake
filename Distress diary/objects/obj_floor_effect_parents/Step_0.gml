/// @description Insert description here
// You can write your code in this editor

//액체 그리기
if (surface_exists(global.liquid_on_floor_surf))
{
	animation_timer ++;
	
	if (animation_timer > 200)
	{
		des_timer = true;
	}
}