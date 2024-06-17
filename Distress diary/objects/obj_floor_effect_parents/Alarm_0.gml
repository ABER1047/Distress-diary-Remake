/// @description Insert description here
// You can write your code in this editor
for(var i = 0; i < 3*image_xscale; i++)
{
	var rd_val1 = choose(-1,1)*irandom_range(0,(i+1)*16);
	var rd_val2 = choose(-1,1)*irandom_range(0,(i+1)*16);
	rd_xx[i] = x+rd_val1*image_xscale;
	rd_yy[i] = y+rd_val2*image_xscale*0.47;
	blood_scale[i] = 0;
	
	image_yscale = image_xscale*0.48;
}
