/// @description Insert description here
// You can write your code in this editor

var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);

var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);


//임시 체력바 및 스태미나 바 그리기
var scale = global.reversed_ratio_by_camera*0.5;

//체력바 UI
var hp_bar_ui_xx = xx+(16*scale);
var hp_bar_ui_yy = yy+yy_h-(96*scale);
draw_sprite_ext(spr_hp_bar_remake,0,hp_bar_ui_xx,hp_bar_ui_yy,scale*1.15,scale,0,c_white,1);
draw_sprite_part_ext(spr_hp_bar_remake,1,0,0,(hp_for_draw/global.max_hp)*288,33,hp_bar_ui_xx,hp_bar_ui_yy,scale*1.15,scale,c_white,1);


//스테미나 바 UI
var stamina_bar_ui_end_xx = hp_bar_ui_xx+(288*scale);
var stamina_bar_ui_start_yy = hp_bar_ui_yy+(36*scale);
var stamina_bar_ui_end_yy = stamina_bar_ui_start_yy+(8*scale);
draw_set_alpha(1);
draw_set_color(#17111A);
draw_rectangle(hp_bar_ui_xx,stamina_bar_ui_start_yy,stamina_bar_ui_end_xx,stamina_bar_ui_end_yy,false);
draw_set_color(#494E92);
draw_rectangle(hp_bar_ui_xx,stamina_bar_ui_start_yy,hp_bar_ui_xx+(288*(stamina_for_draw/global.max_stamina)*scale),stamina_bar_ui_end_yy,false);


//HP 및 스테이터스 창
if (global.graphics_quality > 0)
{
	var tmp_values = [ fix_num_inside(weight_for_draw,0,10), hydro_for_draw, hunger_for_draw ];
	var tmp_values_max = [ global.over_weight, 100 ,100 ];
	var tmp_color = [ -4, merge_color(#E14141,c_white,(tmp_values[1] > 10) ? 1 : tmp_values[1]/global.over_weight), merge_color(#E14141,c_white,(tmp_values[2] > 10) ? 1 : tmp_values[2]/10) ];

	if (weight_for_draw < global.over_weight)
	{
		var tmp_cal = global.over_weight*0.5;
		tmp_color[0] = merge_color(c_white,#FFBF36,fix_to_zero(weight_for_draw-tmp_cal)/tmp_cal);
	}
	else
	{
		tmp_color[0] = merge_color(#FFBF36,#E14141,fix_to_zero(weight_for_draw-global.over_weight)/50);
	}
}


var tmp_values_for_display = [ global.my_weight, global.hydration, global.hunger ];
var tmp_unit = [ "kg", "%", "%" ];
for(var i = 0; i < 3; i++)
{
	if (global.graphics_quality > 0)
	{
		//draw_circular_bar(xx+(scale*(48+78*i)),yy+yy_h-(144*scale),1,1,#17111A,32*scale,1,scale*6);
		draw_circular_bar(xx+(scale*(48+78*i)),yy+yy_h-(144*scale),tmp_values[i],tmp_values_max[i],tmp_color[i],32*scale,1,scale*6,#17111A);
	}
	draw_sprite_ext(spr_ui,i,xx+(scale*(48+78*i)),yy+yy_h-(144*scale),scale*0.9,scale*0.9,0,c_white,1);
	
	draw_text_kl_scale(xx+(scale*(48+78*i)),yy+yy_h-(172*scale),string(tmp_values_for_display[i])+string(tmp_unit[i]),64,-1,1,c_white,0,0,font_normal,0.25,0.25,0,true);
}


// 버프/디버프 UI
var tmp_icon_scale = 0.4*global.ratio_by_camera;
for(var i = 0, tmp_index = 0; i < array_length(global.apply_buff_effect); i++)
{
	if (global.apply_buff_effect[i])
	{
		var tmp_ui_xx = xx+xx_w-32*(global.ratio_by_camera+tmp_index*1.5), tmp_ui_yy = yy+196*global.ratio_by_camera;
		draw_sprite_ext(spr_buff_ui,i,tmp_ui_xx,tmp_ui_yy,tmp_icon_scale,tmp_icon_scale,0,c_white,1);
		tmp_index ++;
	}
}

//버프 정보창 표기
for(var i = 0, tmp_index = 0; i < array_length(global.apply_buff_effect); i++)
{
	if (global.apply_buff_effect[i])
	{
		var tmp_ui_xx = xx+xx_w-32*(global.ratio_by_camera+tmp_index*1.5), tmp_ui_yy = yy+196*global.ratio_by_camera;
		var tmp_real_width = tmp_icon_scale*20;
		if (point_in_rectangle(mouse_x,mouse_y,tmp_ui_xx-tmp_real_width,tmp_ui_yy-tmp_real_width,tmp_ui_xx+tmp_real_width,tmp_ui_yy+tmp_real_width))
		{
			//뒷 배경 그리기
			var tmp_buff_name = [ "Slowness", "Speed", "Weakness", "Strength", "Overweight", "Fractured", "Bleeding", "Starving", "Dehydrated", "Resistance", "Disresistance", "Muscular", "Recovery", "Unlucky", "Lucky", "Poisoning" ];
			var tmp_buff_name_translated = [ "느림", "빠름", "나약함", "강인함", "과적", "골절", "출혈", "굶주림", "탈수", "저항", "비저항", "근력", "재생", "불운", "행운", "중독" ];
			var tmp_my_p = global.my_player_ins_id[global.my_player_id];
			var tmp_buff_info = [ "이동 속도 저하", "이동 속도 +2 증가", "공격력 25% 감소", "공격력 25% 증가", "이동 속도 및 점프력"+string((1-tmp_my_p.speed_by_weight)*100)+"% 감소", "달리거나 점프 시 -3 HP 감소 및 이동 속도 저하", "3초마다 -1.5 HP 감소", "10초마다 -"+string(6-global.hunger*0.5)+" HP 감소", "10초마다 -"+string(2-global.hydration*0.1)+" HP 감소", "방어력 25% 증가", "방어력 25% 감소", "최대 중량 10kg 증가", "5초마다 +2 HP 회복", "행운 감소", "행운 증가", "3초마다 -1 HP 감소" ];
			var tmp_buff_time = [ -4, -4, -4, -4, -4, -4, floor((180-code.bleeding_timer)/60), floor((600-code.hunger_timer)/60), floor((600-code.hydration_timer)/60), -4, -4, -4, floor((300-code.hp_recovery_timer)/60), -4, -4, floor((180-code.poisoning_timer)/60) ];
			var tmp_name_to_draw = string(tmp_buff_name[i]); //아이템명
			var text_ratio = global.reversed_ratio_by_camera;
			if (tmp_buff_name[i] != tmp_buff_name_translated[i])
			{
				tmp_name_to_draw = tmp_name_to_draw+" ("+string(tmp_buff_name_translated[i])+")";
			}
			var tmp_txt_width = max(string_width(tmp_buff_info[i]),string_width(tmp_name_to_draw))+2;
			var tmp_info_length = 1;
			var tmp_win_width = (tmp_txt_width*0.3+8)*text_ratio;
			var tmp_win_height = 60*text_ratio;
			var tmp_txt_size = 0.25;
			draw_set_alpha(0.9);
			draw_set_color(c_black);
			draw_rectangle(mouse_x,mouse_y,mouse_x-tmp_win_width,mouse_y+tmp_win_height,false);
			

		
		
		
			//아이템명 그리기
			var tmp_text_startx = mouse_x-tmp_win_width+4*text_ratio;
			var tmp_text_starty = mouse_y-8*text_ratio;
			draw_text_kl_scale(tmp_text_startx,tmp_text_starty-(14*text_ratio),string(tmp_name_to_draw),64,-1,1,c_white,0,-1,font_normal,tmp_txt_size,tmp_txt_size,0,true);
		
		
			//버프 정보 그리기
			draw_text_kl_scale(tmp_text_startx,tmp_text_starty+(4*text_ratio),string(tmp_buff_info[i]),64,tmp_txt_width,1,merge_color(c_white,c_black,0.3),0,-1,font_normal,tmp_txt_size,tmp_txt_size,0,true);

		
			//아이템명-아이템 정보 사이의 라인 그리기
			var tmp_name_width = string_width(tmp_buff_name[i])*0.5+48;
			draw_set_color(c_white);
			draw_set_alpha(1);
			draw_line_width(tmp_text_startx,tmp_text_starty+(23*text_ratio),tmp_text_startx+(tmp_name_width-96)*text_ratio,tmp_text_starty+(23*text_ratio),text_ratio);
		
		
			var tmp_txt_col = merge_color(c_white,c_black,0.3);
			var tmp_icon_size = text_ratio*0.25;
			var tmp_slot_size_txt_yy = tmp_text_starty+tmp_info_length*25*text_ratio;

			//남은 시간 (아이콘)
			draw_sprite_ext(spr_ui,15,tmp_text_startx+8*text_ratio,tmp_slot_size_txt_yy+28*text_ratio,tmp_icon_size,tmp_icon_size,0,tmp_txt_col,1);
		
			//남은 시간
			draw_text_kl_scale(tmp_text_startx+24*text_ratio,tmp_slot_size_txt_yy,convert_to_time(tmp_buff_time[i]),64,480,1,tmp_txt_col,0,-1,font_normal,tmp_txt_size,tmp_txt_size,0,true);
		}
		
		tmp_index ++;
	}
}



//퀵 슬롯 창 그리기
var ui_scale = global.reversed_ratio_by_camera*0.5;
var tmp_ui_xx = xx+xx_w*0.5, tmp_ui_yy = yy+yy_h-global.reversed_ratio_by_camera*48, tmp_slot_half_width = -4, tmp_slot_half_height = -4;
if (!global.prohibit_movement_input)
{
	if (keyboard_check_pressed(vk_anykey)) //퀵 슬롯 키보드 선택 판정
	{
		var tmp_val = string_digits(keyboard_lastchar);
		if (tmp_val != 0 && keyboard_check_pressed(ord(tmp_val)))
		{
			global.quickslot_index = tmp_val-1;
		}
	}
	else if (mouse_check_button_released(mb_left)) //퀵 슬롯 클릭 선택 판정
	{
		tmp_slot_half_width = ui_scale*282;
		tmp_slot_half_height = ui_scale*31.5;
		if (abs(mouse_y-tmp_ui_yy-tmp_slot_half_height) < tmp_slot_half_height)
		{
			for(var i = 0; i < 9; i++)
			{
				var tmp_slot_xx = (tmp_ui_xx-tmp_slot_half_width) + tmp_slot_half_height+(i*tmp_slot_half_height*2);
				if (abs(mouse_x-tmp_slot_xx) < tmp_slot_half_height)
				{
					global.quickslot_index = i;
				}
		
				if (global.show_wall_hitbox)
				{
					draw_set_color(c_red);
					draw_set_alpha(1);
					draw_circle(tmp_slot_xx,tmp_ui_yy-tmp_slot_half_height,4,false);
				}
			}
		}
	}
}


draw_sprite_ext(spr_quickslot,global.quickslot_index,tmp_ui_xx,tmp_ui_yy,ui_scale,ui_scale,0,c_white,1);
for(var i = 0; i < 9; i++)
{
	if (sprite_exists(global.quickslot_spr_ind[i]))
	{
		tmp_slot_half_width = (tmp_slot_half_width == -4) ? ui_scale*282 : tmp_slot_half_width;
		tmp_slot_half_height = (tmp_slot_half_height == -4) ? ui_scale*31.5 : tmp_slot_half_height;
		var tmp_slot_xx = (tmp_ui_xx-tmp_slot_half_width) + tmp_slot_half_height+(i*tmp_slot_half_height*2);
		draw_sprite_ext(global.quickslot_spr_ind[i],global.quickslot_img_ind[i],tmp_slot_xx,tmp_ui_yy+tmp_slot_half_height,ui_scale,ui_scale,0,c_white,1);
	}
}







//UI창이 열려있을때 뒷 배경 까맣게 칠하기
if (instance_exists(obj_ui_parents))
{
	draw_set_alpha(0.9);
	draw_set_color(c_black);
	draw_rectangle(xx,yy,xx+xx_w,yy+yy_h,false);
}

//화면 전체 흰색
if (global.w_alpha > 0)
{
	draw_set_alpha(global.w_alpha);
	draw_set_color(c_white);
	draw_rectangle(xx,yy,xx+xx_w,yy+yy_h,false);
}






if (image_index%2 == 1)
{
	depth = code.depth-9999;
	draw_self();
	
	draw_text(x,y,"x : "+string(x)+" / y : "+string(y))
}