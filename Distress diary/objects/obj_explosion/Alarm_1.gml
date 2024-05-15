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