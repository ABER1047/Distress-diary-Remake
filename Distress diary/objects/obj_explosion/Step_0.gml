/// @description Insert description here
// You can write your code in this editor



fire_ef_timer ++;
if (effect_applied)
{
	//불꽃 이펙트 
	if (fire_ef_timer < 60)
	{
		var rd_ind = irandom_range(0,effect_ins_arr_ind-1);
		var tmp_ef_ins = effect_ins_arr[rd_ind];
		if (instance_exists(tmp_ef_ins) && tmp_ef_ins.image_xscale*256 >= 32)
		{
			var tmp_xx = tmp_ef_ins.x;
			var tmp_yy = tmp_ef_ins.y;
			var tmp_scale = irandom_range(10,20)*0.03;
			var tmp_ins = create_bubble_effect(tmp_xx,tmp_yy,0,#DD4C4C,#FFAC4B,0.1,-irandom_range(8,16),-(tmp_ef_ins.hspeed),0.03,0,true,tmp_ef_ins.depth+1);
			tmp_ins.image_xscale = tmp_scale;
			tmp_ins.image_yscale = tmp_scale;
			
			show_debug_message("ef_cr"+string(rd_ind));
		}
	}
	
	
	
	
	//시간 지나면 자동 삭제 
	if (bubble_ef_ins.child_num == 0)
	{
		show_debug_message("dest");
		instance_destroy();
	}
}






