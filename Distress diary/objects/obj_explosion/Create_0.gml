/// @description Insert description here
// You can write your code in this editor



//xpos = -4;
//ypos = -4;


//폭발 범위
//image_xscale = 0;

//폭발 데미지 
//explo_dmg = 0;


//효과 적용 
effect_applied = false;
alarm[1] = 1;


//버블 이펙트 외곽선 효과용 오브젝트
bubble_ef_ins = instance_create_depth(x,y,0,tmp_bubble_outline_effect);
bubble_ef_ins.parent_id = id;

//해당 서피스를 이용중인 다른 오브젝트들 갯수
child_num = 0;