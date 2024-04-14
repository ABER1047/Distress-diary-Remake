/// @description Insert description here
// You can write your code in this editor

//혈흔 생기는 애니메이션 재생
animation_timer = 0;


for(var i = 0; i < 4*max(image_xscale,image_yscale); i++)
{
	var rd_val1 = choose(-1,1)*irandom_range(0,(i+1)*16);
	var rd_val2 = choose(-1,1)*irandom_range(0,(i+1)*16);
	rd_xx[i] = x+rd_val1*image_xscale;
	rd_yy[i] = y+rd_val2*image_yscale;
	blood_scale[i] = 0;
}
