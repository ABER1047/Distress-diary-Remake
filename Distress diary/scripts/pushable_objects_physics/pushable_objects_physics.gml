// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function pushable_objects_physics()
{
	var tmp_ins = instance_place(x,y,obj_pushable_object);
	if (instance_exists(tmp_ins) && z == tmp_ins.z) //z축도 같은지 체크
	{
		var tmp_xx = (x - tmp_ins.x)/32;
		var tmp_yy = (y - tmp_ins.y)/32;
		
		//pushable_objects끼리 부딛혔을 경우 서로 밀리는 효과
		hspeed = (hspeed*0.5) + tmp_xx;
		vspeed = (vspeed*0.5) + tmp_yy;
	}
	
	if (z == 0) //땅 바닥에 있어야 속도 감소 효과 먹음 (= 마찰력)
	{
		hspeed += (0 - hspeed)*0.2;
		vspeed += (0 - vspeed)*0.2;
	}
	else
	{
		//공중에 있어야 속도 감소 효과 먹음 (= 공기저항)
		hspeed += (0 - hspeed)*0.02;
		vspeed += (0 - vspeed)*0.02;
	}
}