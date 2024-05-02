/// @description Insert description here
// You can write your code in this editor

if (image_alpha > 0)
{
	//위로 올라가는 포탈인 경우 벽까지 그리기
	if (tp_to == 1)
	{
		var xx = camera_get_view_x(view_camera[0]);
		var yy = camera_get_view_y(view_camera[0]);
		var n_wall_type = global.n_room_tileset;
		//문 안쪽 검은 배경
		draw_sprite_ext(sprite_index,1+n_wall_type*3,x,y-16,image_xscale,image_yscale,0,image_blend,sign(image_alpha));
		
		//문
		draw_surface_ext(door_surf,x-40,y-120,image_xscale,image_yscale,0,c_white,1);
		
		//문 틀
		draw_sprite_ext(sprite_index,2+n_wall_type*3,x,y-16,image_xscale,image_yscale,0,image_blend,sign(image_alpha));
		
		if (global.show_wall_hitbox)
		{
			draw_sprite_ext(spr_arrow_ui,0,x,y,image_xscale,image_yscale,90+90*tp_to,#17111A,1);
		}
	}
	
	//내 자신 그리기
	var tmp_dir = image_angle+270;
	draw_sprite_ext(spr_exit_guide_arrow,floor_arrow_img_ind,x+lengthdir_x(128,tmp_dir),y+lengthdir_y(128,tmp_dir),image_xscale,image_yscale,tmp_dir-90,c_white,image_alpha*1.5);
	
	//바닥 화살표 그리기
	
	
	
	//화살표 인터페이스 그리기
	//var tmp_dis = (arrow_animation_yy/96);
	//var tmp_scale = 0.6+tmp_dis*0.1;
	//draw_sprite_ext(spr_arrow_ui,0,x+lengthdir_x(arrow_animation_yy,tmp_dir),y+lengthdir_y(arrow_animation_yy,tmp_dir),image_xscale*tmp_scale,image_yscale*tmp_scale,tmp_dir-90,c_white,image_alpha*tmp_dis);
}





