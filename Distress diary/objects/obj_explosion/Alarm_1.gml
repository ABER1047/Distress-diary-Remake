/// @description 효과 적용 


//폭발 관련 충돌 마스크 자동 지정
image_yscale = image_xscale*0.42;


//효과음 재생
play_sound_pos(bomb_sfx,false,0.1,x,y,2600,true,xpos,ypos);


//폭발 데미지
var tmp_my_p = global.my_player_ins_id[global.my_player_id];
if (place_meeting(x,y,tmp_my_p))
{
	var dis_xx = (x-tmp_my_p.x);
	var dis_yy = (y-tmp_my_p.y)*0.42;
	var real_dis = sqrt(power(dis_xx,2)+power(dis_yy,2));
	var tmp_dmg_decrease_dis = image_xscale*96;
	var tmp_dmg = (real_dis > tmp_dmg_decrease_dis) ? explo_dmg/(real_dis-tmp_dmg_decrease_dis) : explo_dmg;
	
	give_damage(tmp_my_p,tmp_dmg,false);
}



//폭발 이펙트 
var rd_val = irandom_range(1,3);
for(var i = 0; i < image_xscale+rd_val; i++)
{
	var tmp_effect_dis = 160*image_xscale;
	var tmp_xx = x+irandom_range(-tmp_effect_dis,tmp_effect_dis);
	var tmp_yy = y+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.42;
	var tmp_dis = point_distance(x,y,tmp_xx,tmp_yy);
	var tmp_ins = create_bubble_effect(tmp_xx,tmp_yy,-1,c_white,c_white,0,irandom_range(-2,2)*0.42,irandom_range(-2,2),0,0.8,true,-9999);
	tmp_ins.image_xscale = 10/((1+tmp_dis/128));
	tmp_ins.image_yscale = 10/((1+tmp_dis/128));
	tmp_ins.sprite_index = spr_explosion;
}





//폭발 이펙트 적용됨 
effect_applied = true;


//화면 흔들림 
view_shake(0.1,16,0.1,0);