/// @description Insert description here
// You can write your code in this editor
var whole_scale = global.n_camera_zoom/0.7;
var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);

var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);


//뒷 배경 까맣게 칠하기
draw_set_alpha(0.9);
draw_set_color(c_black);
draw_rectangle(xx,yy,xx+xx_w,yy+yy_h,false);



//UI창 그리기
draw_surface_ext(crt_surf,xx,yy,whole_scale,whole_scale,0,c_white,1);






if (play_result_animation <= 1)
{
	//버튼 가이드 드로우
	var img_scale = 1.25*whole_scale;
	var txt_scale = 0.45;
	var tmp_xx = xx+xx_w*0.82;
	var tmp_yy = yy+yy_h*0.68;
	var tmp_yy2 = tmp_yy-52*whole_scale;
	draw_sprite_ext(spr_key_ui,10,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_sprite_ext(spr_key_ui,11,tmp_xx+64*whole_scale,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx+112*whole_scale,tmp_yy2,"주사위 선택",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);
	
	var tmp_xx2 = tmp_xx+48*whole_scale;
	tmp_yy += 96*whole_scale;
	tmp_yy2 = tmp_yy-52*whole_scale;
	draw_sprite_ext(spr_key_ui,7,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx2,tmp_yy2,"레이즈 업",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);

	tmp_yy += 96*whole_scale;
	tmp_yy2 = tmp_yy-52*whole_scale;
	draw_sprite_ext(spr_key_ui,8,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx2,tmp_yy2,"드롭",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);

	tmp_yy += 96*whole_scale;
	tmp_yy2 = tmp_yy-52*whole_scale;
	draw_sprite_ext(spr_key_ui,0,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx2,tmp_yy2,"베팅",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);

	tmp_yy += 96*whole_scale;
	tmp_yy2 = tmp_yy-52*whole_scale;
	tmp_xx2 += 32*whole_scale;
	draw_sprite_ext(spr_key_ui,9,tmp_xx+16*whole_scale,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx2,tmp_yy2,"나가기",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);
}


