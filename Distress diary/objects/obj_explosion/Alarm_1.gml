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
	var tmp_effect_dis = 64*image_xscale;
	var tmp_ins = create_bubble_effect(x+irandom_range(-tmp_effect_dis,tmp_effect_dis),y+irandom_range(-tmp_effect_dis,tmp_effect_dis)*0.42,-1,#3B3447,#222034,0.01,-irandom_range(6,12),irandom_range(-8,8),0.02,0,false);
	tmp_ins.image_xscale = 2*i;
	tmp_ins.image_yscale = 2*i;
}


alarm[2] = 1;



//폭발 이펙트 적용됨 
effect_applied = true;
