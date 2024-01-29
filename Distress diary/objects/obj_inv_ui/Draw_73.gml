/// @description Insert description here
// You can write your code in this editor

//인벤토리 관련 변수를 가진 인스턴스 (= variable_owner) 가 존재하는 경우
if (instance_exists(variable_owner))
{
	var xx = camera_get_view_x(view_camera[0]);
	var yy = camera_get_view_y(view_camera[0]);

	var xx_w = camera_get_view_width(view_camera[0]);
	var yy_h = camera_get_view_height(view_camera[0]);

	var slot_size = 160*global.n_camera_zoom; //1칸당 픽셀 사이즈
	var window_weight = 64*global.n_camera_zoom; //윈도우 창 두께 (드래그 클릭으로 옮기는 그 윈도우 창)
	var outline_weight = 3*global.n_camera_zoom; //테두리 두께

	//해당 인벤토리 변수를 가진 인스턴스한테서 width, height 받아오기
	var inv_width = variable_owner.inv_width;
	var inv_height = variable_owner.inv_height;

	//인벤토리 첫번째 칸 시작 위치
	var startx = xx+x_pos;
	var starty = yy+y_pos;

	//인벤토리 마지막 칸 위치
	var endx = startx+inv_width*slot_size;
	var endy = starty+inv_height*slot_size;


	//인벤토리 윈도우 젤 왼쪽 상단 시작 위치
	var w_starty = starty-window_weight;
	
	
	
	
	//창 위치 옮기기 기능
	var is_mouse_on_XButton = is_inside_rectangle(mouse_x,mouse_y,endx-window_weight,w_starty,endx,starty);
	if (is_dragging)
	{
		if (relative_x_pos == -4)
		{
			//창 위치 옮기기 기능
			if (is_inside_rectangle(mouse_x,mouse_y,startx,w_starty,endx-window_weight,starty))
			{
				relative_x_pos = xx+x_pos-mouse_x;
				relative_y_pos = yy+y_pos-mouse_y;
			}
			else if (is_mouse_on_XButton) //닫기 버튼
			{
				instance_destroy();
			}
		}
		else
		{
			x_pos = mouse_x+relative_x_pos-xx;
			y_pos = mouse_y+relative_y_pos-yy;
		}
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
		draw_line(startx+(i*slot_size),starty,startx+(i*slot_size),endy);
	}

	for(var i = 1; i < inv_height; i++)
	{
		draw_line(startx,starty+(i*slot_size),endx,starty+(i*slot_size));
	}
	

	


	//흰색 테두리 그리기
	draw_set_alpha(image_alpha);
	draw_set_color(c_white);
	for(var i = 0; i < outline_weight; i++)
	{
		//닫기 버튼 그리기 (테두리 구분선)
		draw_line(endx-i-window_weight,w_starty,endx-i-window_weight,starty);
		
		//닫기 버튼 그리기 (X버튼 테두리)
		/*draw_sprite_ext(spr_X,0,endx-window_weight*0.5-i,w_starty+window_weight*0.5,0.15*global.n_camera_zoom,0.15*global.n_camera_zoom,0,c_white,image_alpha*0.7);
		draw_sprite_ext(spr_X,0,endx-window_weight*0.5,w_starty+window_weight*0.5-i,0.15*global.n_camera_zoom,0.15*global.n_camera_zoom,0,c_white,image_alpha*0.7);
		draw_sprite_ext(spr_X,0,endx-window_weight*0.5+i,w_starty+window_weight*0.5,0.15*global.n_camera_zoom,0.15*global.n_camera_zoom,0,c_white,image_alpha*0.7);
		draw_sprite_ext(spr_X,0,endx-window_weight*0.5,w_starty+window_weight*0.5+i,0.15*global.n_camera_zoom,0.15*global.n_camera_zoom,0,c_white,image_alpha*0.7);*/
		
		//흰색 테두리 그리기
		draw_line(startx,starty,endx,starty);
		draw_rectangle(startx-i,w_starty-i,endx+i,endy+i,true);
	}
	

	//닫기 버튼 그리기 (X 이미지)
	draw_sprite_ext(spr_X,0,endx-window_weight*0.5,w_starty+window_weight*0.5,0.15*global.n_camera_zoom,0.15*global.n_camera_zoom,0,merge_color(#E64A4A,c_black,is_mouse_on_XButton*0.35),image_alpha*0.7);
	
	

	//인벤토리 이름
	draw_text_kl_scale(startx+8,w_starty-24*global.n_camera_zoom,string(inv_name),64,-1,image_alpha,c_white,0,-1,font_normal,0.64*global.n_camera_zoom,0.64*global.n_camera_zoom,0);
}
else
{
	instance_destroy();
}









