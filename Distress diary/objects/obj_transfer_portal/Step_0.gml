/// @description Insert description here
// You can write your code in this editor
timer += 0.01;
var tmp_sin = sin(timer);
var col = [ #87EEF2, #E57272 ];
var tmp_col = col[image_index];
c_light(tmp_col,0.35+tmp_sin*0.06,image_xscale*0.4,x,y,,image_yscale*0.4);
c_light(tmp_col,power(fix_to_zero(tmp_sin)*1.4,2),image_xscale,x,y,sprite_index,image_yscale,image_index);
image_alpha = 0.7+tmp_sin*0.2;


//깊이 설정
depth = obj_map_texture_floor.depth-8;


if (global.graphics_quality >= 1 && tmp_sin > 0.5 && percentage_k(2))
{
	repeat(irandom_range(1,3))
	{
		var rd_dir = irandom_range(1,360), rd_dis = irandom_range(0,image_xscale*64);
		var tmp_xx = lengthdir_x(rd_dis,rd_dir), tmp_yy = lengthdir_y(rd_dis,rd_dir)/1.333;
		var tmp_ins = instance_create_depth(x+tmp_xx,y+tmp_yy,-1,obj_bright_line_effect);
		tmp_ins.image_blend = tmp_col;
		tmp_ins.direction = 90;
		tmp_ins.rd_dir_increasement = 90;
		tmp_ins.start_dir = 90;
		tmp_ins.speed = irandom_range(20,30)/10;
		tmp_ins.rd_dir_timer_increasement = 0;
	}
}