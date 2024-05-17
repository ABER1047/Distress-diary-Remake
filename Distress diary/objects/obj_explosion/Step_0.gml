/// @description Insert description here
// You can write your code in this editor



create_explo_effect_timer ++;
if (create_explo_effect_timer == 1 || create_explo_effect_timer == 10 || create_explo_effect_timer == 4 || create_explo_effect_timer == 25)
{
	var tmp_effect_dis = 128*image_xscale;
	
	//폭발 이펙트 
	var rd_val = irandom_range(1,3);
	for(var i = 0; i < image_xscale*4+rd_val; i++)
	{
		var tmp_xx = x+irandom_range(-tmp_effect_dis,tmp_effect_dis);
		var tmp_yy = y+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.42;
		var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
		var tmp_ins = create_bubble_effect(tmp_xx,tmp_yy,-1,#3B3447,#222034,0.003,irandom_range(-2,2)*0.42,irandom_range(-2,2),0.02,0,false,-tmp_yy,90);
		tmp_ins.image_xscale = 9/((1+tmp_dis/96));
		tmp_ins.image_yscale = 9/((1+tmp_dis/96));
	}



	var rd_val = irandom_range(0,2);
	for(var i = 0; i < image_xscale*4+rd_val; i++)
	{
		var tmp_xx = x+irandom_range(-tmp_effect_dis,tmp_effect_dis);
		var tmp_yy = y+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.42;
		var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
		var tmp_ins = create_bubble_effect(tmp_xx,tmp_yy,0,#DD4C4C,#FFAC4B,0.1,irandom_range(-4,4)*0.42,irandom_range(-4,4),0.03,0,true);
		tmp_ins.image_xscale = 16/((1+tmp_dis/64))
		tmp_ins.image_yscale = 16/((1+tmp_dis/64))
	}
}




//시간 지나면 자동 삭제 
if (effect_applied && child_num == 0)
{
	instance_destroy();
}