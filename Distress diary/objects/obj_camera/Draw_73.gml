/// @description Insert description here
// You can write your code in this editor

var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);

var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);


var tmp_my_p = global.my_player_ins_id[global.my_player_id];

//UI창이 열려있을때 뒷 배경 까맣게 칠하기
if (instance_exists(obj_ui_parents))
{
	draw_set_alpha(0.9);
	draw_set_color(c_black);
	draw_rectangle(xx,yy,xx+xx_w,yy+yy_h,false);
}


//임시 체력바 및 스태미나 바 그리기
var text_ratio = global.reversed_ratio_by_camera;
var scale = text_ratio*0.5;

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


//플레이어 현재 스테이터스 창 (공격력, 방어력 등등)
var tmp_xx = xx+text_ratio*16;
var tmp_values = [ valToStrWithPoint(global.attack_damage), valToStrWithPoint(global.critical_dmg_magnification*global.attack_damage), valToStrWithPoint(60/global.attack_speed), valToStrWithPoint(global.critical_chance), valToStrWithPoint(global.max_movement_speed/7*100), valToStrWithPoint(global.defence_power), valToStrWithPoint(global.luck) ];
var to_draw_values = [ string(tmp_values[0])+"(+"+string(tmp_values[1])+")", tmp_values[2], string(tmp_values[3])+"%", string(tmp_values[4])+"%", string(tmp_values[5])+"%", tmp_values[6] ];
for(var i = 0; i < 6; i++)
{
	var tmp_yy = yy+(256+i*24)*text_ratio;
	draw_sprite_ext(spr_status_ui,i,tmp_xx,tmp_yy,scale,scale,0,c_white,0.5);
	draw_text_kl_scale(tmp_xx+text_ratio*16,tmp_yy-text_ratio*28,to_draw_values[i],64,-1,0.5,c_white,0,-1,font_normal,0.25,0.25,0,true);
}




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
	if (global.graphics_quality > 1)
	{
		draw_circular_bar(xx+(scale*(48+78*i)),yy+yy_h-(144*scale),tmp_values[i],tmp_values_max[i],tmp_color[i],32*scale,1,scale*6,0,#17111A);
	}
	draw_sprite_ext(spr_ui,i,xx+(scale*(48+78*i)),yy+yy_h-(144*scale),scale*0.9,scale*0.9,0,c_white,1);
	
	draw_text_kl_scale(xx+(scale*(48+78*i)),yy+yy_h-(172*scale),string(tmp_values_for_display[i])+string(tmp_unit[i]),64,-1,1,c_white,0,0,font_normal,0.25,0.25,0,true);
}


// 버프/디버프 UI
var tmp_icon_scale = 0.4*global.ratio_by_camera;
var tmp_buff_name = [ "Slowness", "Speed", "Weakness", "Strength", "Overweight", "Fractured", "Bleeding", "Starving", "Dehydrated", "Resistance", "Powerless", "Muscular", "Recovery", "Unlucky", "Lucky", "Poisoning", "Search", "Fear", "Smite" ];
var tmp_buff_name_translated = [ "느림", "빠름", "나약함", "강인함", "과적", "골절", "출혈", "굶주림", "탈수", "저항", "무력함", "근력", "재생", "불운", "행운", "중독", "탐색", "두려움", "강타" ];
var tmp_buff_info = [ "이동 속도 저하", "이동 속도 증가", "공격력 25% 감소", "공격력 25% 증가", "이동 속도 및 점프력 "+string((1-tmp_my_p.speed_by_weight)*100)+"% 감소", "달리거나 점프 시 -3 HP 감소 및 이동 속도 저하", "3초마다 -1.5 HP 감소", "10초마다 -"+string(6-global.hunger*0.5)+" HP 감소", "10초마다 -"+string(2-global.hydration*0.1)+" HP 감소", "방어력 25% 증가", "방어력 25% 감소", "최대 중량 10kg 증가", "5초마다 +2 HP 회복", "행운 -2 감소", "행운 +2 증가", "3초마다 -1 HP 감소", "아이템 서칭 속도 30% 증가", "누군가가 쫒아오는 느낌이 듭니다...", "크리티컬 데미지 200%" ];
var tmp_info_length = 1;
var tmp_real_width = tmp_icon_scale*20;
var tmp_win_height = 60*text_ratio;
var tmp_txt_size = 0.25;

for(var i = 0, tmp_index = 0; i < array_length(global.buff_left_time); i++)
{
	if (global.buff_left_time[i] > 0)
	{
		var tmp_ui_xx = xx+xx_w-32*(global.ratio_by_camera+tmp_index*1.5), tmp_ui_yy = yy+196*global.ratio_by_camera;
		var tmp_cal = 63*tmp_icon_scale*0.5;
		var tmp_buff_timer_line_xx = tmp_ui_xx-tmp_cal, tmp_buff_timer_line_yy = tmp_ui_yy+30*tmp_icon_scale+1;
		
		//남은 시간 게이지 바 그리기
		draw_line_width(tmp_buff_timer_line_xx,tmp_buff_timer_line_yy,tmp_buff_timer_line_xx+tmp_cal*2*(global.buff_left_time[i]/global.buff_max_left_time[i]),tmp_buff_timer_line_yy,tmp_icon_scale*4);
		
		//아이콘 그리기
		draw_sprite_ext(spr_buff_ui,i,tmp_ui_xx,tmp_ui_yy,tmp_icon_scale,tmp_icon_scale,0,c_white,1);
		tmp_index ++;
	}
}

//버프 정보창 표기
for(var i = 0, tmp_index = 0; i < array_length(global.buff_left_time); i++)
{
	if (global.buff_left_time[i] > 0)
	{
		var tmp_ui_xx = xx+xx_w-32*(global.ratio_by_camera+tmp_index*1.5), tmp_ui_yy = yy+196*global.ratio_by_camera;
		if (point_in_rectangle(mouse_x,mouse_y,tmp_ui_xx-tmp_real_width,tmp_ui_yy-tmp_real_width,tmp_ui_xx+tmp_real_width,tmp_ui_yy+tmp_real_width))
		{
			//뒷 배경 그리기
			var tmp_name_to_draw = string(tmp_buff_name[i]); //아이템명
			if (tmp_buff_name[i] != tmp_buff_name_translated[i])
			{
				tmp_name_to_draw = tmp_name_to_draw+" ("+string(tmp_buff_name_translated[i])+")";
			}
			var tmp_txt_width = max(string_width(tmp_buff_info[i]),string_width(tmp_name_to_draw))+2;
			var tmp_win_width = (tmp_txt_width*0.3+8)*text_ratio;
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
			var tmp_name_width = (string_width(tmp_buff_name[i])*0.5-48);
			draw_set_color(c_white);
			draw_set_alpha(1);
			draw_line_width(tmp_text_startx,tmp_text_starty+(23*text_ratio),tmp_text_startx+((tmp_name_width < 32) ? 32*text_ratio : tmp_name_width*text_ratio),tmp_text_starty+(23*text_ratio),text_ratio);
		
		
			var tmp_txt_col = merge_color(c_white,c_black,0.3);
			var tmp_icon_size = text_ratio*0.25;
			var tmp_slot_size_txt_yy = tmp_text_starty+tmp_info_length*28*text_ratio;

			//남은 시간 (아이콘)
			draw_sprite_ext(spr_ui,15,tmp_text_startx+8*text_ratio,tmp_slot_size_txt_yy+29*text_ratio,tmp_icon_size,tmp_icon_size,0,tmp_txt_col,1);
		
			//남은 시간
			draw_text_kl_scale(tmp_text_startx+20*text_ratio,tmp_slot_size_txt_yy,convert_to_time(floor(global.buff_left_time[i]/60)),64,480,1,tmp_txt_col,0,-1,font_normal,tmp_txt_size,tmp_txt_size,0,true);
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
			
			set_status_by_weapon((global.quickslot_spr_ind[global.quickslot_index] == spr_weapon) ? global.quickslot_img_ind[global.quickslot_index] : -1);
		}
	}
	else if ((global.is_moving_item_now == -4 && (mouse_check_button_released(mb_left) || mouse_check_button_pressed(mb_left))) || (global.is_moving_item_now != -4 && mouse_check_button(mb_left))) //퀵 슬롯 클릭 선택 판정
	{
		tmp_slot_half_width = ui_scale*282;
		tmp_slot_half_height = ui_scale*31.5;
		var is_mouse_inside_quickslot = false;
		if (abs(mouse_y-tmp_ui_yy-tmp_slot_half_height) < tmp_slot_half_height)
		{
			for(var i = 0; i < 9; i++)
			{
				var tmp_slot_xx = (tmp_ui_xx-tmp_slot_half_width) + tmp_slot_half_height+(i*tmp_slot_half_height*2);
				if (abs(mouse_x-tmp_slot_xx) < tmp_slot_half_height)
				{
					if (mouse_check_button(mb_left))
					{
						//인벤에 있는 아이템 퀵 슬롯으로 옮기기
						global.is_mouse_on_quickslot = i;
						is_mouse_inside_quickslot = true;
					}
					
					if (global.is_moving_item_now == -4)
					{
						var tmp_quickslot_spr = global.quickslot_spr_ind[i];
						if (tmp_quickslot_spr != -4 && mouse_check_button_pressed(mb_left) && instance_exists(global.showing_inv))
						{
							//퀵 슬롯에 있는 아이템 인벤으로 옮기기
							var tmp_quickslot_img = global.quickslot_img_ind[i], tmp_quickslot_stacks = global.quickslot_stack_num[i], tmp_quickslot_startag = global.quickslot_startag[i];
							var tmp_item_name = set_item_info_values(tmp_quickslot_spr,tmp_quickslot_img);
							var has_empty_pos = find_empty_pos(tmp_quickslot_spr,tmp_quickslot_img,global.item_width,global.item_height,tmp_quickslot_stacks,tmp_my_p);
							
							if (has_empty_pos == true) //인벤에 칸이 있는 경우
							{
								set_inv_variable(global.my_player_ins_id[global.my_player_id],global.inv_empty_xpos,global.inv_empty_ypos,tmp_quickslot_spr,tmp_quickslot_img,tmp_quickslot_stacks,global.inv_empty_rotated,1,tmp_quickslot_startag);
								
								with(obj_inv_ui)
								{
									reload_inv = 1;
								}
							}
							else
							{
								//아이템 떨구기
								drop_item(tmp_quickslot_spr,tmp_quickslot_img,tmp_quickslot_stacks,global.item_width,global.item_height,tmp_quickslot_startag);
							}
							
							//퀵 슬롯 아이템 삭제
							global.quickslot_spr_ind[i] = -4;
							show_message_log("item_destroyed");
								
							//효과음
							play_sound(draging_item,false,0.03);
								
							//후 처리
							global.quickslot_index = i;
							global.is_mouse_on_quickslot = -4;	
						}
						else if (mouse_check_button_released(mb_left))
						{
							//인벤토리 아이템을 드래그 중 아닐때
							global.quickslot_index = i;
							global.is_mouse_on_quickslot = -4;	
						}
					}
				}
			}
		}
		
		if (!is_mouse_inside_quickslot)
		{
			global.is_mouse_on_quickslot = -4;
		}
	}
	else if (mouse_wheel_down())
	{
		//마우스 휠로 제어
		global.quickslot_index ++;
		if (global.quickslot_index > 8)
		{
			global.quickslot_index = 0;
		}
	}
	else if (mouse_wheel_up())
	{
		//마우스 휠로 제어
		global.quickslot_index --
		if (global.quickslot_index < 0)
		{
			global.quickslot_index = 8;
		}
	}
}

//인벤토리 아이템을 드래그 중일때/아닐때 구분
var tmp_img_ind = (global.is_moving_item_now == -4) ? global.quickslot_index : global.is_mouse_on_quickslot;
draw_sprite_ext(spr_quickslot,(tmp_img_ind >= 0) ? tmp_img_ind : 9,tmp_ui_xx,tmp_ui_yy,ui_scale,ui_scale,0,c_white,1);





for(var i = 0; i < 9; i++)
{
	if (sprite_exists(global.quickslot_spr_ind[i]))
	{
		tmp_slot_half_width = (tmp_slot_half_width == -4) ? ui_scale*282 : tmp_slot_half_width;
		tmp_slot_half_height = (tmp_slot_half_height == -4) ? ui_scale*31.5 : tmp_slot_half_height;
		var tmp_slot_xx = (tmp_ui_xx-tmp_slot_half_width) + tmp_slot_half_height+(i*tmp_slot_half_height*2);
		
		var tmp_check = (global.quickslot_stack_num[i] == -4);
		if (tmp_check || global.quickslot_stack_num[i] > 0)
		{
			//아이템 아이콘 그리기
			draw_sprite_ext(global.quickslot_spr_ind[i],global.quickslot_img_ind[i],tmp_slot_xx,tmp_ui_yy+tmp_slot_half_height,ui_scale,ui_scale,0,c_white,1);
			
			//스타 태그 그리기
			if (global.quickslot_startag[i] > 0)
			{
				draw_sprite_ext(spr_rare_tag,global.quickslot_startag[i]-1,tmp_slot_xx-tmp_slot_half_height*0.6,tmp_ui_yy+tmp_slot_half_height*1.6,ui_scale*0.5,ui_scale*0.5,0,c_white,1);
			}
			
			//퀵 슬롯 창 테두리 그리기
			if (i != tmp_img_ind && global.quickslot_rare[i] > 0)
			{
				draw_sprite_ext(spr_quickslot_outline,global.quickslot_rare[i]-1.5,tmp_slot_xx-1,tmp_ui_yy,ui_scale,ui_scale,0,c_white,0.6);
			}
			
			//아이템 갯수 그리기
			if (!tmp_check)
			{
				draw_text_k_scale(tmp_slot_xx+ui_scale*24,tmp_ui_yy-ui_scale*8,string(global.quickslot_stack_num[i]),64,-1,1,c_white,0,1,font_normal,0.25,0.25,0,true);
			}
		}
	}
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