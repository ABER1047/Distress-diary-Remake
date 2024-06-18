/// @description CRT효과

//CRT효과
if (surface_exists(crt_surf))
{
	var whole_scale = global.reversed_ratio_by_camera;
	var xx_w = camera_get_view_width(view_camera[0]);
	var yy_h = camera_get_view_height(view_camera[0]);
	var xx_center = xx_w*0.5;
	var yy_center = yy_h*0.5;
	surface_set_target(crt_surf);
	draw_clear_alpha(c_black,0);

	//UI창 검은 배경 그리기
	draw_sprite_ext(spr_pc_ui,1,xx_center,yy_center,2.5*global.ratio_by_camera,2.5*global.ratio_by_camera,0,c_white,1);
		
		
	//이모지 얼굴
	draw_sprite_ext(spr_pc_ui_state,9+face_img_ind,xx_center,yy_h*0.3,10*whole_scale,10*whole_scale,0,c_white,1);

	//결과창
	draw_sprite_ext(spr_pc_ui_state,result_img_ind,xx_center,yy_h*0.6,7*whole_scale,7*whole_scale,0,c_white,1);
		
	//내 베팅 정보
	var tmp_xx = xx_center+320*global.ratio_by_camera;
	var tmp_yy = yy_center+96*global.ratio_by_camera;
	var txt_scale = 0.3;
	draw_text_k_scale(tmp_xx,tmp_yy-52*whole_scale,"선택한 주사위",64,-1,1,#83E04C,0,0,font_normal,txt_scale,txt_scale,0,true);
	draw_sprite_ext(spr_pc_ui_state,4+my_bet_dice,tmp_xx,tmp_yy+24*whole_scale,6,6,0,c_white,1);
	draw_text_k_scale(tmp_xx,tmp_yy+20*whole_scale,"x"+string(my_bet_dice+2),64,-1,1,#83E04C,0,0,font_normal,txt_scale,txt_scale,0,true);

	tmp_yy += 88*whole_scale;
	draw_text_k_scale(tmp_xx,tmp_yy-32*whole_scale,"베팅할 골드",64,-1,1,#83E04C,0,0,font_normal,txt_scale,txt_scale,0,true);
	draw_text_k_scale(tmp_xx,tmp_yy,string(bet_amount)+" / "+string(global.my_gold),64,-1,1,#83E04C,0,0,font_normal,txt_scale,txt_scale,0,true);



	//확률 표 드로우
	var chances = [ "37%", "26%", "20%", "13%", "4%" ];
	var tmp_xx = xx_center-330*global.ratio_by_camera;
	for(var i = 0; i < 5; i++)
	{
		var tmp_x = tmp_xx+32*i*whole_scale;
		draw_sprite_ext(spr_pc_ui_state,4+i,tmp_x,yy_h-80*global.reversed_ratio_by_camera,3,3,0,c_white,1);
		draw_text_k_scale(tmp_x,yy_h-128*global.reversed_ratio_by_camera,string(chances[i]),64,-1,1,#83E04C,0,0,font_normal,txt_scale*0.9,txt_scale*0.9,0,true);
	}
	
	
	if (global.graphics_quality >= 2)
	{
		//CRT효과
		var scale = 4*whole_scale;
		var tmp_height = 256*whole_scale*2.5;
		for(var i = 0; i <= tmp_height; i += 8*whole_scale)
		{
			draw_sprite_ext(spr_crt_effect,0,xx_center-390*global.ratio_by_camera,(i-crt_yy*whole_scale),1750*global.ratio_by_camera,scale,0,c_white,0.1);
		}
	
		
		//포커스 이펙트 그리기
		draw_sprite_ext(spr_focus_effect,0,xx_center,yy_center,(5.6*320/3584),(5.5*256/2016),0,c_white,0.035);
		
		crt_yy -= 0.1;
		if (crt_yy <= -4*scale)
		{
			crt_yy = 0;
		}
	}
	
	//UI창 테두리 그리기
	draw_sprite_ext(spr_pc_ui,0,xx_center,yy_center,2.5*global.ratio_by_camera,2.5*global.ratio_by_camera,0,c_white,1);
	surface_reset_target();
}
else
{
	event_user(2);
}
