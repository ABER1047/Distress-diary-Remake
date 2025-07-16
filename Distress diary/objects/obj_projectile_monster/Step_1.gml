/// @description Insert description here
// You can write your code in this editor

//깊이 설정
depth = -y;




//플레이어한테 충돌한 판정
var tmp_ins = instance_place(x,y,obj_player);
if (instance_exists(tmp_ins))
{
	//불꽃 튀는 이펙트
	if (type > 0)
	{
		var light_col = [ #FFAC4B, #0BE5C4, #E395F8 ];
		var tmp_col = [ #DD4C4C, #FFAC4B, #0BE5C4, #D9FFDE ];
		repeat(irandom_range(3,5))
		{
			if (percentage_k(50))
			{
				var tmp_ins_effect = instance_create_depth(x,y,-1,obj_bright_line_effect);
				tmp_ins_effect.image_blend = light_col[type-1];
				tmp_ins_effect.direction = 90;
				tmp_ins_effect.rd_dir_increasement = direction;
				tmp_ins_effect.start_dir = 90;
				tmp_ins_effect.speed = irandom_range(20,30)/15+abs(global.movement_hspeed*0.1);
				tmp_ins_effect.rd_dir_timer_increasement = 1;
			}
		
			if (percentage_k(50))
			{
				var tmp_ins_effect = create_bubble_effect(x+irandom_range(-16,16),y+(percentage_k(10) ? 10 : -10),-z-32,tmp_col[(type-1)*2],tmp_col[(type-1)*2+1],0.08,-irandom_range(6,12),irandom_range(-2,2),0.03,0,true);
				tmp_ins_effect.image_xscale = 1.3;
				tmp_ins_effect.image_yscale = 1.3;
			}
		}
	}
	
	
	//데미지
	give_damage(tmp_ins,dmg,false,16,x,y,60);
	instance_destroy_multiplayer(id);
}