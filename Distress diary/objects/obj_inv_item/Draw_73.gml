/// @description Insert description here
// You can write your code in this editor

if (instance_exists(parents_id))
{
	var xx = camera_get_view_x(view_camera[0]);
	var yy = camera_get_view_y(view_camera[0]);

	var xx_w = camera_get_view_width(view_camera[0]);
	var yy_h = camera_get_view_height(view_camera[0]);

	var slot_size = 160*global.n_camera_zoom; //1칸당 픽셀 사이즈
	
	
	//인벤토리 내에서의 칸
	var real_startx = xx+(parents_id.x_pos);
	var real_starty = yy+(parents_id.y_pos);
	var startx = real_startx+(x_pos*slot_size);
	var starty = real_starty+(y_pos*slot_size);
	
	//해당 인벤토리의 변수들을 보유하고 있는 실제 인스턴스
	var variable_owner_ins = parents_id.variable_owner;


	// 아이템 이미지 뒤의 배경 색 그리기
	draw_set_alpha(parents_id.image_alpha*0.15*(1+mouse_on));
	draw_set_color(c_white);
	draw_rectangle(startx,starty,startx+slot_size,starty+slot_size,false);
	
	
	//마우스가 아이템 위에 올라갔는지 체크
	if (is_inside_rectangle(mouse_x,mouse_y,startx,starty,startx+slot_size,starty+slot_size))
	{
		mouse_on = 1;
	}
	else
	{
		mouse_on = 0;
	}
	

	// 아이템 이미지 그리기
	draw_sprite_ext(sprite_index,image_index,startx+(slot_size*0.5),starty+(slot_size*0.5),image_xscale,image_yscale,image_angle,image_blend,parents_id.image_alpha);


	//아이템 이름
	draw_text_kl_scale(startx+8*global.n_camera_zoom,starty-24*global.n_camera_zoom,string(item_name),64,-1,parents_id.image_alpha,c_white,0,-1,font_normal,0.6*global.n_camera_zoom,0.6*global.n_camera_zoom,0);
	
	//아이템 스택 갯수 표기
	if (max_stack_num > 1)
	{
		draw_text_kl_scale(startx+(slot_size)-(8*global.n_camera_zoom),starty+(slot_size)-(64*global.n_camera_zoom),string(stack_num)+"/"+string(max_stack_num),64,-1,parents_id.image_alpha,c_white,0,1,font_normal,0.5*global.n_camera_zoom,0.5*global.n_camera_zoom,0);
	}
	
	
	//아이템 옮기기 때의 x,y좌표
	if (moving_now == 0)
	{
		x = startx+(slot_size*0.5);
		y = starty+(slot_size*0.5);
	}
	else
	{
		//현재 내 마우스 위치랑 가장 가까운 인벤토리의 첫번째 칸 좌표
		var nearest_inv_startx = xx+(tmp_nearest_inv_ui.x_pos);
		var nearest_inv_starty = yy+(tmp_nearest_inv_ui.y_pos);
		
		//가장 가까운 인벤토리의 변수들을 보유하고 있는 실제 인스턴스
		var nearsest_inv_variable_owner_ins = tmp_nearest_inv_ui.variable_owner;
	
		
		
		x = mouse_x;
		y = mouse_y;
		// 이동 중인 아이템 이미지 뒤의 배경 색 그리기
		moving_item_x_pos = floor((x-nearest_inv_startx)/slot_size);
		moving_item_y_pos = floor((y-nearest_inv_starty)/slot_size);
		
		//만약 이동 중인 아이템이 인벤토리 내의 칸 안에 있는 경우
		if (is_inside_rectangle(moving_item_x_pos,moving_item_y_pos,-1,-1,nearsest_inv_variable_owner_ins.inv_width,nearsest_inv_variable_owner_ins.inv_height))
		{
			var tmp_x = nearest_inv_startx+(moving_item_x_pos*slot_size);
			var tmp_y = nearest_inv_starty+(moving_item_y_pos*slot_size);
			draw_set_alpha(tmp_nearest_inv_ui.image_alpha*0.15*(1+mouse_on));
			var tmp_color = #E14141;
			if (is_moveable_pos == 1)
			{
				tmp_color = c_white;
			}
			else if (is_moveable_pos == 2 || is_moveable_pos == 3)
			{
				tmp_color = #4CD40D;
			}
			draw_set_color(tmp_color);
			draw_rectangle(tmp_x,tmp_y,tmp_x+slot_size,tmp_y+slot_size,false);
			is_moving_item_outside = 0;
		}
		else //인벤토리 내의 칸 밖에 있는 경우
		{
			is_moving_item_outside = 1;
		}
		
		
		// 이동 중인 아이템 그리기
		draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,moving_now*0.7);
	}
}






