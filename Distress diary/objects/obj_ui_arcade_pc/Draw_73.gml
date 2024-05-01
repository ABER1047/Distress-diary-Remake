/// @description Insert description here
// You can write your code in this editor

var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);

var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);


//뒷 배경 까맣게 칠하기
draw_set_alpha(0.9);
draw_set_color(c_black);
draw_rectangle(xx,yy,xx+xx_w,yy+yy_h,false);



//UI창 그리기
draw_sprite_ext(sprite_index,0,xx+xx_w*0.5,yy+yy_h*0.5,5.5,5.5,0,c_white,1);

//이모지 얼굴
draw_sprite_ext(spr_pc_ui_state,9+face_img_ind,xx+xx_w*0.5,yy+yy_h*0.3,20,20,0,c_white,1);

//결과창
draw_sprite_ext(spr_pc_ui_state,result_img_ind,xx+xx_w*0.5,yy+yy_h*0.6,15,15,0,c_white,1);


//내 베팅 정보
var tmp_xx = xx+xx_w*0.74;
var tmp_yy = yy+yy_h*0.65;
var txt_scale = 0.4;
draw_text_k_scale(tmp_xx,tmp_yy-52,"선택한 주사위\n\n\n\nx"+string(my_bet_dice+2),64,-1,1,#83E04C,0,0,font_normal,txt_scale*1.25,txt_scale*1.25,0);
draw_sprite_ext(spr_pc_ui_state,4+my_bet_dice,tmp_xx,tmp_yy+128,6,6,0,c_white,1);

tmp_yy += 320;
draw_text_k_scale(tmp_xx,tmp_yy-52,"베팅 금액",64,-1,1,#83E04C,0,0,font_normal,txt_scale*1.25,txt_scale*1.25,0);
draw_text_k_scale(tmp_xx,tmp_yy,string(bet_amount)+"/"+string(global.my_gold),64,-1,1,#83E04C,0,0,font_normal,txt_scale,txt_scale,0);



//확률 표 드로우
var chances = [ "37%", "26%", "20%", "13%", "4%" ];
var tmp_xx = xx+xx_w*0.24;
for(var i = 0; i < 5; i++)
{
	draw_sprite_ext(spr_pc_ui_state,4+i,tmp_xx+64*i,tmp_yy+32,3,3,0,c_white,1);
	draw_text_k_scale(tmp_xx+64*i,tmp_yy-52,string(chances[i]),64,-1,1,#83E04C,0,0,font_normal,txt_scale,txt_scale,0);
}




if (play_result_animation <= 1)
{
	//버튼 가이드 드로우
	var img_scale = 1.25;
	var txt_scale = 0.45;
	var tmp_xx = xx+xx_w*0.82;
	var tmp_yy = yy+yy_h*0.68;
	draw_sprite_ext(spr_key_ui,10,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_sprite_ext(spr_key_ui,11,tmp_xx+64,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx+112,tmp_yy-52,"주사위 선택",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);
	
	tmp_yy += 96;
	draw_sprite_ext(spr_key_ui,7,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx+48,tmp_yy-52,"레이즈 업",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);

	tmp_yy += 96;
	draw_sprite_ext(spr_key_ui,8,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx+48,tmp_yy-52,"드롭",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);

	tmp_yy += 96;
	draw_sprite_ext(spr_key_ui,0,tmp_xx,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx+48,tmp_yy-52,"베팅",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);

	tmp_yy += 96;
	draw_sprite_ext(spr_key_ui,9,tmp_xx+16,tmp_yy,img_scale,img_scale,0,c_white,1);
	draw_text_kl_scale(tmp_xx+82,tmp_yy-52,"나가기",64,-1,1,c_white,0,-1,font_normal,txt_scale,txt_scale,0);
}