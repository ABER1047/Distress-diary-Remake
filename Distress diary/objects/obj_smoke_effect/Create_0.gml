/// @description Insert description here
// You can write your code in this editor


//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();



depth = -9999;
for(var i = 0; i < sqrt(image_xscale)*16; i++)
{
	xx[i] = -4;
	yy[i] = -4;
	_speed[i] = 0;
	_dir[i] = 0;
	_alpha[i] = 0;
}


//버프 효과 타이머
tmp_buff_timer = 0;

//버프 효과
//buff_index = -4;

//삭제 타이머
des_timer = 0;
//des_time = 0;