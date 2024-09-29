/// @description Insert description here
// You can write your code in this editor

if (global.show_wall_hitbox)
{
	draw_self();
}

var tmp_sqrt_scale = sqrt(image_xscale);
for(var i = 0; i < array_length(xx); i++)
{
	var tmp_distance = 1-point_distance(xx[i],yy[i],x,y)/(256*tmp_sqrt_scale);
	_alpha[i] += (tmp_distance*image_alpha - _alpha[i])*0.1;
	
	if (_alpha[i] > 0)
	{
		var tmp_scale = tmp_distance*tmp_sqrt_scale;
		xx[i] += lengthdir_x(_speed[i],_dir[i]);
		yy[i] += lengthdir_y(_speed[i],_dir[i]);
		draw_sprite_ext(spr_circle,0,xx[i],yy[i],tmp_scale,tmp_scale,0,image_blend,_alpha[i]*0.05);
	}
	else
	{
		xx[i] = x+irandom_range(-16,16)*tmp_sqrt_scale;
		yy[i] = y+irandom_range(-16,16)*tmp_sqrt_scale;
		_speed[i] = irandom_range(20,80)/100*choose(-1,1);
		_dir[i] = irandom_range(0,359);
	}
}


