/// @description Insert description here
// You can write your code in this editor


var rd_val = irandom_range(0,2);
for(var i = 0; i < image_xscale*2+rd_val; i++)
{
	var tmp_ins = create_bubble_effect(x+irandom_range(-16,16),y+(percentage_k(10) ? 10 : -10),0,#DD4C4C,#FFAC4B,0.03,-irandom_range(6,12),irandom_range(-16,16),0.03,0,true);
	tmp_ins.image_xscale = 1.3+i*0.3;
	tmp_ins.image_yscale = 1.3+i*0.3;
}



var tmp_val = irandom_range(0,20);
alarm[2] = tmp_val;