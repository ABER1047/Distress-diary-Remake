/// @description Insert description here
// You can write your code in this editor
var whole_scale = global.reversed_ratio_by_camera;
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);
var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);
var xx_center = xx+xx_w*0.5;
var yy_center = yy+yy_h*0.5;




//UI창 그리기
draw_surface_ext(crt_surf,xx,yy,1,1,0,c_white,1);






if (play_result_animation <= 1)
{
	//버튼 가이드 드로우
	var img_scale = 0.5*whole_scale;
	var txt_scale = 0.3;
	var tmp_xx = xx_center+420*global.ratio_by_camera;
	var tmp_yy = yy_center+128*global.ratio_by_camera;
	var tmp_yy2 = tmp_yy-40*whole_scale;
	draw_sprite_ext(spr_key_ui,10,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_sprite_ext(spr_key_ui,11,tmp_xx+24*whole_scale,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx+44*whole_scale,tmp_yy2,"주사위 선택",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0,true);
	
	var tmp_xx2 = tmp_xx+16*whole_scale;
	tmp_yy += 32*whole_scale;
	tmp_yy2 = tmp_yy-40*whole_scale;
	draw_sprite_ext(spr_key_ui,7,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx2,tmp_yy2,"레이즈 업",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0,true);

	tmp_yy += 32*whole_scale;
	tmp_yy2 = tmp_yy-40*whole_scale;
	draw_sprite_ext(spr_key_ui,8,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx2,tmp_yy2,"드롭",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0,true);

	tmp_yy += 32*whole_scale;
	tmp_yy2 = tmp_yy-40*whole_scale;
	draw_sprite_ext(spr_key_ui,0,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx2,tmp_yy2,"베팅",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0,true);

	tmp_yy += 32*whole_scale;
	tmp_yy2 = tmp_yy-40*whole_scale;
	tmp_xx2 += 16*whole_scale;
	draw_sprite_ext(spr_key_ui,9,tmp_xx+8*whole_scale,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx2,tmp_yy2,"나가기",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0,true);
}


