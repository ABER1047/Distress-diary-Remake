/// @description Insert description here
// You can write your code in this editor



//랜덤한 바닥 타일 디자인
for(var i = 0; i < global.n_room_width; i++)
{
	for(var ii = 0; ii < global.n_room_height; ii++)
	{
		rd_tile_break_ef[i][ii] = irandom_range(-4,2); //타일 바닥 깨진 효과
		rd_tile_break_ef_ang[i][ii] = irandom_range(0,3)*90; //타일 바닥 깨진 효과 각도
		rd_tile_moss_ef[i][ii] = irandom_range(-14,5); //타일 바닥 이끼 효과
		rd_tile_moss_ef_ang[i][ii] = irandom_range(0,3)*90; //타일 바닥 이끼 효과 각도
	}
}

