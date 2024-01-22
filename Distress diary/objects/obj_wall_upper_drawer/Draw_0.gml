/// @description Insert description here
// You can write your code in this editor
//현재 불러와진 룸 그리기
var tmp_room_xx = room_width*0.5;
var tmp_room_yy = room_height*0.5;
var tmp_wall_scale = 2;
var tmp_wall_sprite_size = tmp_wall_scale*48;
var n_wall_type = 0;
for(var i = 0; i < global.n_room_width; i++)
{
	//위쪽 벽 그리기
	var tmp_spr_ind = n_wall_type*3+1;
	if (i == 0)
	{
		tmp_spr_ind -= 1;
	}
	else if (i == global.n_room_width-1)
	{
		tmp_spr_ind += 1;
	}
	draw_sprite_ext(spr_tiles_walls,tmp_spr_ind,tmp_room_xx+(-global.n_room_width*0.5+i)*tmp_wall_sprite_size,y,tmp_wall_scale,tmp_wall_scale,0,c_white,1);
}











