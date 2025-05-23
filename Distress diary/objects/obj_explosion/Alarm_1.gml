/// @description 효과 적용 


//폭발 관련 충돌 마스크 자동 지정
image_yscale = image_xscale*0.42;

//데미지 값 전송 
send_InstanceVariableData(id,"explo_dmg",explo_dmg);
send_ImgData(obj_id,id,sprite_index,image_index,x,y,z,image_xscale,image_yscale,0,0,1);





//폭발 데미지
with(obj_mob_parents)
{
	if (!stop_cal_by_pos_statement && place_meeting(x,y,other.id))
	{
		var tmp_real_dmg = other.explo_dmg;
		var dis_xx = (other.x-x);
		var dis_yy = (other.y-y)*0.42;
		var real_dis = sqrt(power(dis_xx,2)+power(dis_yy,2));
		var tmp_dmg_decrease_dis = other.image_xscale*96;
		var tmp_dmg = (real_dis > tmp_dmg_decrease_dis) ? tmp_real_dmg/((real_dis-tmp_dmg_decrease_dis)/32) : tmp_real_dmg;
	
		var knockback_speed = (real_dis > tmp_dmg_decrease_dis) ? 32/(real_dis-tmp_dmg_decrease_dis) : 32;
		give_damage(id,(tmp_real_dmg > tmp_dmg) ? tmp_dmg : tmp_real_dmg,false,knockback_speed,other.x,other.y,60);
	}
}



//폭발 이펙트
if (global.graphics_quality > 1)
{
	var rd_val = irandom_range(1,3);
	for(var i = 0; i < image_xscale*0.7+rd_val; i++)
	{
		var tmp_effect_dis = 96*image_xscale;
		var tmp_xx = x+irandom_range(-tmp_effect_dis,tmp_effect_dis);
		var tmp_yy = y+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.42;
		var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
		var tmp_ins = create_bubble_effect(tmp_xx,tmp_yy,-1,c_white,c_white,0,irandom_range(-2,2)*0.42,irandom_range(-2,2),0,0.8,true,-9999);
		tmp_ins.sprite_index = spr_explosion;
		tmp_ins.image_xscale = 10/((1+tmp_dis/128));
		tmp_ins.image_yscale = 10/((1+tmp_dis/128));
	}
}


if (global.graphics_quality > 0)
{
	var tmp_effect_dis = 128*image_xscale;
	effect_ins_arr = array_create(256,-4);
	var rd_val = irandom_range(1,3);
	for(var i = 0; i < image_xscale*4+rd_val; i++)
	{
		if (global.graphics_quality > 1)
		{
			//폭발 스모크 이펙트 
			var tmp_xx = x+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.1;
			var tmp_yy = y+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.042;
			var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
			var tmp_scale = irandom_range(10,20)*0.06;
			effect_ins_arr[effect_ins_arr_ind] = create_bubble_effect(tmp_xx,tmp_yy,-1,#3B3447,#222034,0,-irandom_range(8,16),irandom_range(-15,15),0.02,0,false,-tmp_yy,20+irandom_range(0,20));
			effect_ins_arr[effect_ins_arr_ind].image_xscale = tmp_scale/((1+tmp_dis/64));
			effect_ins_arr[effect_ins_arr_ind].image_yscale = tmp_scale/((1+tmp_dis/64));
			effect_ins_arr[effect_ins_arr_ind].gravity = irandom_range(30,45)/100;
			effect_ins_arr[effect_ins_arr_ind].gravity_direction = 270;
			effect_ins_arr[effect_ins_arr_ind].z = tmp_yy+irandom_range(-64,64);
			effect_ins_arr_ind ++;
		

			//스모크 생성 
			var tmp_xx = x+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.3;
			var tmp_yy = y+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.42*0.3;
			var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
			var tmp_ins = create_bubble_effect(tmp_xx,tmp_yy,-1,c_white,#FFAC4B,0.3,irandom_range(-2,2)*0.42,irandom_range(-2,2),0.02,0,false,-tmp_yy);
			tmp_ins.image_xscale = 17/((1+tmp_dis/96));
			tmp_ins.image_yscale = 17/((1+tmp_dis/96));
		}
	
		//폭발 잔해 이펙트 
		var tmp_xx = x+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.1;
		var tmp_yy = y+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.1;
		var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
		var tmp_scale = irandom_range(10,20)*0.1;
		effect_ins_arr[effect_ins_arr_ind] = create_bounce_object(tmp_xx,tmp_yy,irandom_range(0,64),irandom_range(0,16),irandom_range(0,359),-irandom_range(4,16),spr_stone_flake,irandom_range(0,3),tmp_scale,irandom_range(120,240));
		effect_ins_arr_ind ++;
	
	
		//바닥 이펙트 생성
		var tmp_ins = instance_create_multiplayer(obj_explosion_effect_on_ground,x,y,global.object_id_ind,0,true,-4,-4);
		tmp_ins.image_xscale = image_xscale*0.4;
	}
}

//그래픽 퀄리티 값이 최상이 아닌 경우, 폭발 이펙트 대신 화면 전체를 흰색으로 덮는 효과로 대체
if (global.graphics_quality <= 1)
{
	global.w_alpha = 1;
}






//폭발 이펙트 적용됨 
effect_applied = true;

