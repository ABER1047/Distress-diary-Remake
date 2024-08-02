/// @description Insert description here
// You can write your code in this editor



//스프라이트 이미지 각도가 실제 direction값과 다르니 보정해줌
image_angle = direction-45+angle_comp;
	
	

if (global.graphics_quality > 0)
{
	//화살 궤적 애니메이션
	if (xx[0] != xx[7])
	{
		if (animation_timer%2 == 0)
		{
			xx[0] = x;
			yy[0] = y-z;
			for(var i = 7; i > 0; i--)
			{
				xx[i] = xx[i-1];
				yy[i] = yy[i-1];
			}
		}
		

		if (animation_timer >= 8*2)
		{
			animation_timer = 0;
		}
		else
		{
			animation_timer ++;
		}
	}
	
	
	
	//화살 꽂힘 효과
	if (is_on_mob != -4)
	{
		if (instance_exists(is_on_mob))
		{
			var tmp_comp_yy = is_on_mob.y - is_on_mob.z;
			var tmp_scale = sign(is_on_mob.image_xscale);
			x = is_on_mob.x;
			y = tmp_comp_yy;
			z = 0.5*(is_on_mob.bbox_bottom - is_on_mob.bbox_top);
			
			depth = is_on_mob.depth+8;
			
			if (saved_xscale == tmp_scale)
			{
				angle_comp = 0;
			}
			else
			{
				//화살이 꽂힌 방향에 따라서 몹이 방향을 틀 경우 똑같이 화살도 방향 적용
				angle_comp = 180-direction*2;
			}
			
			visible = is_on_mob.visible;
		}
		else
		{
			instance_destroy();
		}
	}
	else
	{
		//깊이 설정
		var tmp_depth = y+lengthdir_y(40,direction+180);
		depth = (y > tmp_depth) ? -floor(y) : -tmp_depth;
	}
}
