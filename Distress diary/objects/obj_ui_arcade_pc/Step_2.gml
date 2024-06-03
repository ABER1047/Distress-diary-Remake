/// @description CRT효과

//CRT효과
var whole_scale = global.n_camera_zoom/0.7;
var xx_w = camera_get_view_width(view_camera[0])/whole_scale;

if (surface_exists(crt_surf))
{
	var yy_h = camera_get_view_height(view_camera[0])/whole_scale;
	surface_set_target(crt_surf);
	draw_clear_alpha(c_black,0);

	//UI창 검은 배경 그리기
	draw_sprite_ext(spr_pc_ui,1,xx_w*0.5,yy_h*0.5,5.5,5.5,0,c_white,1);
		
		
	//이모지 얼굴
	draw_sprite_ext(spr_pc_ui_state,9+face_img_ind,xx_w*0.5,yy_h*0.3,20,20,0,c_white,1);

	//결과창
	draw_sprite_ext(spr_pc_ui_state,result_img_ind,xx_w*0.5,yy_h*0.6,15,15,0,c_white,1);
		
	//내 베팅 정보
	var tmp_xx = xx_w*0.74;
	var tmp_yy = yy_h*0.65;
	var txt_scale = 0.4;
	draw_text_k_scale(tmp_xx,tmp_yy-52,"선택한 주사위",64,-1,1,#83E04C,0,0,font_normal,txt_scale*1.25,txt_scale*1.25,0);
	draw_sprite_ext(spr_pc_ui_state,4+my_bet_dice,tmp_xx,tmp_yy+128*whole_scale,6,6,0,c_white,1);
	draw_text_k_scale(tmp_xx,tmp_yy+160*whole_scale,"x"+string(my_bet_dice+2),64,-1,1,#83E04C,0,0,font_normal,txt_scale*1.25,txt_scale*1.25,0);

	tmp_yy += 320*whole_scale;
	draw_text_k_scale(tmp_xx,tmp_yy-52,"베팅할 골드",64,-1,1,#83E04C,0,0,font_normal,txt_scale*1.25,txt_scale*1.25,0);
	draw_text_k_scale(tmp_xx,tmp_yy,string(bet_amount)+" / "+string(global.my_gold),64,-1,1,#83E04C,0,0,font_normal,txt_scale*1.25,txt_scale*1.25,0);



	//확률 표 드로우
	var chances = [ "37%", "26%", "20%", "13%", "4%" ];
	var tmp_xx = xx_w*0.24;
	for(var i = 0; i < 5; i++)
	{
		draw_sprite_ext(spr_pc_ui_state,4+i,tmp_xx+64*i,tmp_yy+32,3,3,0,c_white,1);
		draw_text_k_scale(tmp_xx+64*i,tmp_yy-52,string(chances[i]),64/power(whole_scale,3),-1,1,#83E04C,0,0,font_normal,txt_scale,txt_scale,0);
	}
	
	
	if (global.graphics_quality >= 2)
	{
		//CRT효과
		var scale = 4;
		var tmp_height = 701.25;
		for(var i = 0; i <= tmp_height*2+32; i += 8*scale)
		{
			draw_sprite_ext(spr_crt_effect,0,xx_w*0.5-880,yy_h*0.5-tmp_height+i-crt_yy,1760,scale,0,c_white,0.1);
		}
	
		
		//포커스 이펙트 그리기
		draw_sprite_ext(spr_focus_effect,0,xx_w*0.5,yy_h*0.5,(5.5*320/3584),(5.5*256/2016),0,c_white,0.035);
		
		crt_yy -= 0.1;
		if (crt_yy <= -8*scale)
		{
			crt_yy = 0;
		}
	}
	
	//UI창 테두리 그리기
	draw_sprite_ext(spr_pc_ui,0,xx_w*0.5,yy_h*0.5,5.5,5.5,0,c_white,1);
	surface_reset_target();
}
else
{
	var tmp_scale = xx_w/1280;
	crt_surf = surf_cre(320*5.5*tmp_scale/whole_scale,256*2.56*tmp_scale/whole_scale);
}
