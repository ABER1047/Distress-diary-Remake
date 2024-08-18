// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


//아이템 정보창 표기
///@param item_name
///@param item_name_translated
///@param item_effect_desc
///@param item_desc
///@param tmp_bg_color
///@param item_value
///@param stack_num
///@param item_weight
///@param startag
function show_item_info_window(item_name,item_name_translated,item_effect_desc,item_desc,tmp_bg_color,item_value,stack_num,item_weight,startag)
{
	//뒷 배경 그리기
	var h_yy = camera_get_view_height(view_camera[0]);
	var c_yy_h = camera_get_view_y(view_camera[0])+h_yy;
	var text_ratio = global.reversed_ratio_by_camera;
	var tmp_name_to_draw = string(item_name); //아이템명
	var tmp_txt_width = string_width(tmp_name_to_draw)*2;
	tmp_txt_width = (tmp_txt_width > 640) ? tmp_txt_width : 640;
	var item_info = string(item_effect_desc)+string(item_desc);
	var tmp_info_length = 2+floor(string_length(item_info)/(tmp_txt_width/32));
	var tmp_win_width = (tmp_txt_width*0.3+8)*text_ratio;
	var tmp_win_height = (84+24*tmp_info_length)*text_ratio;
	var tmp_cal = mouse_y+tmp_win_height;
	var window_ystart = (tmp_cal > c_yy_h) ? mouse_y-tmp_win_height : mouse_y;
	var reversed_y = (tmp_cal <= c_yy_h) ? tmp_win_height : 0;
	draw_set_alpha(0.9);
	draw_set_color(c_black);
	draw_rectangle(mouse_x,mouse_y,mouse_x+tmp_win_width,window_ystart+reversed_y,false);
		
		
		
	//아이템명 그리기
	var tmp_text_startx = mouse_x+4*text_ratio;
	var tmp_text_starty = window_ystart-8*text_ratio;
	if (item_name != item_name_translated)
	{
		tmp_name_to_draw = tmp_name_to_draw+" ("+string(item_name_translated)+")";
	}
	draw_text_kl_scale(tmp_text_startx,tmp_text_starty-(16*text_ratio),string(tmp_name_to_draw),64,-1,1,tmp_bg_color,0,-1,font_normal,0.33,0.33,0,true);
		
		
	//아이템 정보 그리기
	draw_text_kl_scale(tmp_text_startx,tmp_text_starty+(24*text_ratio),string(item_effect_desc),64,tmp_txt_width,1,c_white,0,-1,font_normal,0.26,0.26,0,true);
	draw_text_kl_scale(tmp_text_startx,tmp_text_starty+(24*text_ratio)+string_height_ext(item_effect_desc,64,9999),string(item_desc),64,tmp_txt_width,1,merge_color(c_white,c_black,0.3),0,-1,font_normal,0.26,0.26,0,true);
		
		
	//아이템명-아이템 정보 사이의 라인 그리기
	var tmp_name_width = string_width(item_name)*0.5+48;
	var tmp_line_length = tmp_name_width-96;
	if (tmp_line_length < 48)
	{
		tmp_line_length = 48;
	}
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_line_width(tmp_text_startx,tmp_text_starty+(36*text_ratio),tmp_text_startx+tmp_line_length*text_ratio,tmp_text_starty+(36*text_ratio),1.5*text_ratio);
		
		
	var tmp_txt_col = merge_color(c_white,c_black,0.3);
	var tmp_txt_str = "";
	var tmp_txt_size = 0.25;
	var tmp_icon_size = text_ratio*0.3;
	var tmp_slot_size_txt_yy = tmp_text_starty+48+tmp_info_length*24*text_ratio;
	var tmp_weight_txt_yy = tmp_slot_size_txt_yy+24*text_ratio;
		
	//가방 칸수
	if (sprite_index == spr_backpack)
	{
		switch(image_index)
		{
			case 0:
				tmp_txt_str = "4x4 사이즈";
			break;
				
			case 1:
				tmp_txt_str = "5x4 사이즈";
			break;
				
			case 2:
				tmp_txt_str = "6x3 사이즈";
			break;
				
			case 3:
				tmp_txt_str = "4x6 사이즈";
			break;
				
			case 4:
				tmp_txt_str = "5x6 사이즈";
			break;
				
			case 5:
				tmp_txt_str = "4x6 사이즈";
			break;
				
			case 6:
				tmp_txt_str = "6x6 사이즈";
			break;
		}
			
		tmp_txt_size = 0.25;
			
		//가방 칸수 (아이콘)
		draw_sprite_ext(spr_ui,0,tmp_text_startx+8*text_ratio,tmp_slot_size_txt_yy+28*text_ratio,tmp_icon_size*1.05,tmp_icon_size*1.05,0,tmp_txt_col,1);
		//칸수 텍스트
		draw_text_kl_scale(tmp_text_startx+18*text_ratio,tmp_slot_size_txt_yy,string(tmp_txt_str),64,480,1,tmp_txt_col,-1,-1,font_normal,tmp_txt_size,tmp_txt_size,0,true);
	}
		
	//아이템 가치
	var additional_value_by_startag = item_value;
	if (startag == 1)
	{
		additional_value_by_startag = string(additional_value_by_startag)+"(+"+string(floor(item_value*0.2))+")";
	}
	else if (startag == 2)
	{
		additional_value_by_startag = string(additional_value_by_startag)+"(+"+string(floor(item_value*0.5))+")";
	}
	else if (startag == 3)
	{
		additional_value_by_startag = string(additional_value_by_startag)+"(+"+string(item_value)+")";
	}
	else if (startag == 4)
	{
		additional_value_by_startag = string(additional_value_by_startag)+"(+"+string(item_value*2)+")";
	}
	draw_text_kl_scale(tmp_text_startx+tmp_win_width-8*text_ratio,tmp_slot_size_txt_yy+28*text_ratio,"가치 : "+string(additional_value_by_startag),64,480,1,tmp_txt_col,-1,1,font_normal,tmp_txt_size,tmp_txt_size,0,true);

		
	//아이템 무게 (아이콘)
	draw_sprite_ext(spr_ui,10,tmp_text_startx+8*text_ratio,tmp_weight_txt_yy+28*text_ratio,tmp_icon_size,tmp_icon_size,0,tmp_txt_col,1);
		
	//아이템 무게
	var tmp_cal_weight = (stack_num != -4) ? stack_num*item_weight : item_weight;
	draw_text_kl_scale(tmp_text_startx+18*text_ratio,tmp_weight_txt_yy,string(tmp_cal_weight)+"kg",64,480,1,tmp_txt_col,0,-1,font_normal,tmp_txt_size,tmp_txt_size,0,true);
}