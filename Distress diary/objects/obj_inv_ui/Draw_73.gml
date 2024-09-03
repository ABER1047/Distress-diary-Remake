/// @description Insert description here
// You can write your code in this editor



//인벤토리 관련 변수를 가진 인스턴스 (= variable_owner) 가 존재하는 경우
if (instance_exists(variable_owner))
{
	var xx = camera_get_view_x(view_camera[0]);
	var yy = camera_get_view_y(view_camera[0]);

	var xx_w = camera_get_view_width(view_camera[0]);
	var yy_h = camera_get_view_height(view_camera[0]);
	
	var text_ratio = global.reversed_ratio_by_camera;
	var slot_size = 40*text_ratio; //1칸당 픽셀 사이즈
	var window_weight = 16*text_ratio; //윈도우 창 두께 (드래그 클릭으로 옮기는 그 윈도우 창)
	var outline_weight = 2*text_ratio; //테두리 두께

	//해당 인벤토리 변수를 가진 인스턴스한테서 width, height 받아오기
	var inv_width = variable_owner.inv_width;
	var inv_height = variable_owner.inv_height;


	//인벤토리 첫번째 칸 시작 위치
	startx = xx+x_pos;
	starty = yy+y_pos;

	//인벤토리 마지막 칸 위치
	endx = startx+inv_width*slot_size;
	endy = starty+inv_height*slot_size;


	//인벤토리 윈도우 젤 왼쪽 상단 시작 위치
	w_starty = starty-window_weight;
	
	//인벤토리 창의 정가운데 위치는 x, y값임 (어차혈흔 드로우 할 때 x, y값 아에 안써서 그럼)
	x = startx+(inv_width*slot_size*0.5);
	y = w_starty+((window_weight+inv_height*slot_size)*0.5);
	
	
	//창끼리 겹치지 못하도록 하는 히트박스 그리기
	//draw_sprite_ext(spr_wall_mask_center,0,x,y,image_xscale,image_yscale,0,c_white,0.2);
	
	
	//창 위치 옮기기 기능
	var is_mouse_on_XButton = is_inside_rectangle(mouse_x,mouse_y,endx-window_weight,w_starty,endx,starty);
	if (is_dragging_window)
	{
		if (relative_x_pos == -4)
		{
			//닫기 버튼
			if (is_mouse_on_XButton)
			{
				instance_destroy();
			}
			else if (is_dragging_window) //창 위치 옮기기 기능
			{
				relative_x_pos = xx+x_pos-mouse_x;
				relative_y_pos = yy+y_pos-mouse_y;
			}
		}
		else
		{
			var tmp_target_xx = mouse_x+relative_x_pos-xx;
			var tmp_target_yy = mouse_y+relative_y_pos-yy;
			x_pos = tmp_target_xx;
			y_pos = tmp_target_yy;
		}
	}
	else if (is_drag_dropped) //창 드래그 후 드롭한 순간에만 위치 값 적용시켜주기 (최적화 때문에)
	{
		//인벤토리 창이 화면 밖을 벗어나지 못하도록 설정
		var tmp_cal_val1 = xx_w-(inv_width*slot_size)-outline_weight;
		if (x_pos < outline_weight)
		{
			x_pos = outline_weight;
		}
		else if (x_pos > tmp_cal_val1)
		{
			x_pos = tmp_cal_val1;
		}

		var tmp_cal_val2 = window_weight+outline_weight;
		var tmp_cal_val3 = yy_h-(inv_height*slot_size)-outline_weight;
		if (y_pos < tmp_cal_val2)
		{
			y_pos = tmp_cal_val2;
		}
		else if (y_pos > tmp_cal_val3)
		{
			y_pos = tmp_cal_val3;
		}
		
		is_drag_dropped = false;
		show_debug_message("preventing out of window");
		event_user(0);
	}
	



	//검은색 뒷 배경 드로우
	draw_set_alpha(image_alpha*0.9);
	draw_set_color(merge_color(#17111A,c_black,0.5));
	draw_rectangle(startx,w_starty,endx,endy,false);


	//내부 칸 구분선 그리기
	draw_set_alpha(image_alpha*0.3);
	draw_set_color(c_white);
	for(var i = 1; i < inv_width; i++)
	{
		draw_line_width(startx+(i*slot_size),starty,startx+(i*slot_size),endy,outline_weight/2.5);
	}

	for(var i = 1; i < inv_height; i++)
	{
		draw_line_width(startx,starty+(i*slot_size),endx,starty+(i*slot_size),outline_weight/2.5);
	}
	

	


	//흰색 테두리 그리기
	draw_set_alpha(image_alpha);
	draw_set_color(c_white);
	var line_correction = 1/(global.graphics_quality*0.25+1);
	for(var i = 0; i < outline_weight; i += line_correction)
	{
		//닫기 버튼 그리기 (테두리 구분선)
		draw_line(endx-i-window_weight,w_starty,endx-i-window_weight,starty);

		//흰색 테두리 그리기
		draw_line(startx,starty,endx,starty);
		draw_rectangle(startx-i,w_starty-i,endx+i,endy+i,true);
	}
	

	//닫기 버튼 그리기 (X 이미지)
	draw_sprite_ext(spr_X,0,endx-window_weight*0.5,w_starty+window_weight*0.5,0.15*global.n_camera_zoom,0.15*global.n_camera_zoom,0,merge_color(#E64A4A,c_black,is_mouse_on_XButton*0.35),image_alpha*0.7);
	
	

	//인벤토리 이름
	draw_text_kl_scale(startx+8,w_starty-27*text_ratio,inv_name,64,-1,image_alpha,c_white,0,-1,font_normal,0.3,0.3,0,true);
}
else
{
	instance_destroy();
}


/*if (global.dev_mode && is_dragging_window)
{
	draw_text_k_scale(startx,w_starty-256,string(x_pos)+", "+string(y_pos),64,-1,1,c_white,0,0,font_normal,0.3,0.3,0,false);
}*/






