/// @description Insert description here
// You can write your code in this editor

if (sprite_exists(sprite_index) && instance_exists(parents_id))
{
	var xx = camera_get_view_x(view_camera[0]);
	var yy = camera_get_view_y(view_camera[0]);

	var xx_w = camera_get_view_width(view_camera[0]);
	var yy_h = camera_get_view_height(view_camera[0]);

	var text_ratio = global.reversed_ratio_by_camera;
	var slot_size = 40*text_ratio; //1칸당 픽셀 사이즈
	
	//아이템 회전 적용
	var tmp_item_width = (item_rotated == 0) ? item_width : item_height;
	var tmp_item_height = (item_rotated == 0) ? item_height : item_width;
	
	
	//인벤토리 내에서의 칸
	var real_startx = xx+(parents_id.x_pos);
	var real_starty = yy+(parents_id.y_pos);
	var startx = real_startx+(x_pos*slot_size);
	var starty = real_starty+(y_pos*slot_size), endy = real_starty+(y_pos+tmp_item_height)*slot_size;
	
	//해당 인벤토리의 변수들을 보유하고 있는 실제 인스턴스
	var variable_owner_ins = parents_id.variable_owner;


	//아이템 이미지 뒤의 배경 색 그리기
	var tmp_bg_color = c_white;
	if (item_searched == 1)
	{
		if (item_value < 10)
		{
			tmp_bg_color = c_white;
			rare_rate = 0;
		}
		else if (item_value < 15)
		{
			tmp_bg_color = #3898FF;
			rare_rate = 1;
		}
		else if (item_value < 28)
		{
			tmp_bg_color = #8C52A8;
			rare_rate = 2;
		}
		else
		{
			tmp_bg_color = #FFBF36;
			rare_rate = 3;
		}
	}
	draw_set_alpha(parents_id.image_alpha*0.15*(1+mouse_on));
	draw_set_color(tmp_bg_color);
	draw_rectangle(startx,starty,startx+slot_size*tmp_item_width,starty+slot_size*tmp_item_height,false);
	


	//아이템 이미지 그리기
	if (item_searched == 1)
	{
		//마우스가 아이템 위에 올라갔는지 체크
		if (is_inside_rectangle(mouse_x,mouse_y,startx,starty,startx+slot_size*tmp_item_width,starty+slot_size*tmp_item_height))
		{
			mouse_on = 1;
		}
		else
		{
			mouse_on = 0;
		}
		
		//아이템 이미지 그리기
		var item_icon_xx = startx+(slot_size*tmp_item_width*0.5), item_icon_yy = starty+(slot_size*tmp_item_height*0.5);
		var img_icon_scale = (image_xscale < image_yscale) ? image_xscale : image_yscale;
		draw_sprite_ext(sprite_index,image_index,item_icon_xx,item_icon_yy,img_icon_scale,img_icon_scale,-90*item_rotated,image_blend,parents_id.image_alpha);
		
		//아이템 이름
		var tmp_item_name_xx = startx+4*text_ratio;
		draw_text_kl_scale(tmp_item_name_xx,starty-24*text_ratio,item_name_compressed,64,-1,parents_id.image_alpha,c_white,0,-1,font_normal,0.275,0.275,0,true);
		
		//아이템 스택 갯수 표기
		if (max_stack_num > 1)
		{
			var txt_max_stack = (max_stack_num != 9999) ? "/"+string(max_stack_num) : "";
			draw_text_kl_scale(startx+(slot_size)-(4*text_ratio),starty+(slot_size)-(36*text_ratio),string(stack_num)+string(txt_max_stack),64,-1,parents_id.image_alpha,c_white,0,1,font_normal,0.25,0.25,0,true);
		}
		
		//아이템 스타 태그 표시
		if (startag > 0)
		{
			draw_sprite_ext(spr_rare_tag,startag-1,tmp_item_name_xx+4*text_ratio,endy-6*text_ratio,text_ratio*0.3,text_ratio*0.3,0,c_white,1);
		}
	}
	else
	{
		//서치되지 않은 아이템은 이미지 및 이름, 스택 등등 정보 표기 X
		for(var i = 0; i < tmp_item_width; i++)
		{
			for(var ii = 0; ii < tmp_item_height; ii++)
			{
				draw_sprite_ext(spr_stripe,image_index,startx+(i*slot_size),starty+2+(ii*slot_size),image_xscale/tmp_item_width,image_xscale/tmp_item_width,0,image_blend,parents_id.image_alpha);
			}
		}
	}

	
	
	//아이템 옮기기 때의 x,y좌표
	if (moving_now == 0)
	{
		x = startx+(slot_size*tmp_item_width*0.5);
		y = starty+(slot_size*tmp_item_height*0.5);
	}
	else
	{
		//아이템 회전 적용
		var tmp_item_width = (moving_item_rotation == 0) ? item_width : item_height;
		var tmp_item_height = (moving_item_rotation == 0) ? item_height : item_width;
		
		
		//이동 중인 아이템 좌표 설정
		x = mouse_x-(slot_size*(tmp_item_width-1)*0.5);
		y = mouse_y-(slot_size*(tmp_item_height-1)*0.5);
		
		
		//만약 이동 중인 아이템이 인벤토리 내의 칸 안에 있는 경우
		if (instance_exists(nearsest_inv_variable_owner_ins))
		{
			//현재 내 마우스 위치랑 가장 가까운 인벤토리의 첫번째 칸 좌표
			var nearest_inv_startx = xx+(tmp_nearest_inv_ui.x_pos);
			var nearest_inv_starty = yy+(tmp_nearest_inv_ui.y_pos);
		
			//가장 가까운 인벤토리의 변수들을 보유하고 있는 실제 인스턴스
			//nearsest_inv_variable_owner_ins = tmp_nearest_inv_ui.variable_owner;
	
		
		
			
			// 이동 중인 아이템 이미지 뒤의 배경 색 그리기
			var tmp_moving_item_x_pos = (x-nearest_inv_startx)/slot_size;
			moving_item_x_pos = (tmp_item_width%2 != 0) ? floor(tmp_moving_item_x_pos) : round(tmp_moving_item_x_pos-0.5);
			var tmp_inv_width = nearsest_inv_variable_owner_ins.inv_width;
			if (moving_item_x_pos >= tmp_inv_width)
			{
				moving_item_x_pos = tmp_inv_width-1;
			}
			else if (moving_item_x_pos < 0)
			{
				moving_item_x_pos = 0;
			}
		
			var tmp_moving_item_y_pos = (y-nearest_inv_starty)/slot_size;
			moving_item_y_pos = (tmp_item_height%2 != 0) ? floor(tmp_moving_item_y_pos) : round(tmp_moving_item_y_pos-0.5);
			var tmp_inv_height = nearsest_inv_variable_owner_ins.inv_height;
			if (moving_item_y_pos >= tmp_inv_height)
			{
				moving_item_y_pos = tmp_inv_height-1;
			}
			else if (moving_item_y_pos < 0)
			{
				moving_item_y_pos = 0;
			}
		
			//만약 이동 중인 아이템이 인벤토리 내의 칸 안에 있는 경우
			if (is_inside_rectangle(tmp_moving_item_x_pos,tmp_moving_item_y_pos,-1,-1,tmp_inv_width,tmp_inv_height))
			{
				//아이템 뒤에 배경 그리기 (그린 = 겹치기 가능, 레드 = 불가능, 화이트 = 옮기기 가능)
				var tmp_x = nearest_inv_startx+(moving_item_x_pos*slot_size);
				var tmp_y = nearest_inv_starty+(moving_item_y_pos*slot_size);
				draw_set_alpha(tmp_nearest_inv_ui.image_alpha*0.15*(1+mouse_on));
				var tmp_color = #E14141;
				if (is_moveable_pos == 1)
				{
					tmp_color = c_white;
				}
				else if (is_moveable_pos >= 2 && is_moveable_pos <= 4)
				{
					tmp_color = #4CD40D;
				}
			
				var max_item_width = (moving_item_x_pos+tmp_item_width <= tmp_inv_width) ? tmp_item_width : tmp_inv_width-moving_item_x_pos;
				var max_item_height = (moving_item_y_pos+tmp_item_height <= tmp_inv_height) ? tmp_item_height : tmp_inv_height-moving_item_y_pos;
				draw_set_color(tmp_color);
				draw_rectangle(tmp_x,tmp_y,tmp_x+slot_size*max_item_width,tmp_y+slot_size*max_item_height,false);
				is_moving_item_outside = 0;
			}
			else //인벤토리 내의 칸 밖에 있는 경우
			{
				is_moving_item_outside = 1;
			}
		}
		
		
		
		//서치된 아이템의 경우
		if (item_searched == 1)
		{
			// 이동 중인 아이템 그리기
			var img_icon_scale = (image_xscale < image_yscale) ? image_xscale : image_yscale;
			draw_sprite_ext(sprite_index,image_index,x+slot_size*(tmp_item_width-1)*0.5,y+slot_size*(tmp_item_height-1)*0.5,img_icon_scale,img_icon_scale,-90*moving_item_rotation,image_blend,moving_now*0.7);
		}
	}
	
	
	
	
	
	//아이템 정보창 표기
	if (show_item_info)
	{
		show_item_info_window(item_name,item_name_translated,item_effect_desc,item_desc,tmp_bg_color,item_value,stack_num,item_weight,startag);
	}
}







