/// @description Insert description here
// You can write your code in this editor




draw_primitive_begin(pr_trianglestrip);
for(var i = 0; i < animation_frame; i++)
{
	draw_vertex_texture_color(xx1[i],yy1[i]-z,0,0,c_white,image_alpha);
	draw_vertex_texture_color(xx2[i],yy2[i]-z,1,1,#B2BCC2,image_alpha*2);
}
draw_primitive_end();



if (global.show_wall_hitbox)
{
	draw_self();
	
	draw_set_alpha(image_alpha);
	draw_set_color(c_red);
	for(var i = 0; i < animation_frame; i++)
	{
		draw_circle(xx1[i],yy1[i]-z,3,false)
		draw_circle(xx2[i],yy2[i]-z,3,false)
	}

	draw_text(x,y-32,string(dir)+" / "+string(image_angle))
}