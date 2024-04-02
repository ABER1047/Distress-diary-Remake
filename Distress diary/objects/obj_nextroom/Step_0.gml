/// @description Insert description here
// You can write your code in this editor
depth = obj_map_texture_draw.depth-32;

//화살표 애니메이션
var tmp_my_p = global.my_player_ins_id[global.my_player_id];
if (point_distance(tmp_my_p.x,tmp_my_p.y,x,y) < 480)
{
	arrow_animation_yy += (0 - arrow_animation_yy)*0.1;
	arrow_animation_timer ++;
	
	if (arrow_animation_timer >= 90)
	{
		arrow_animation_yy = 128;
		arrow_animation_timer = 0;
	}
}
else
{
	arrow_animation_yy = 0;
	arrow_animation_timer = 90;
}
