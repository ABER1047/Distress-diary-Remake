/// @description Insert description here

var tmp_room_w_center = room_width*0.5, tmp_room_h_center = room_height*0.5;

global.view_angle_ += (0 - global.view_angle_)*0.1;
var tmp_v_w = floor(v_x*global.n_camera_zoom*global.w_ratio_by_window), tmp_v_h = floor(v_y*global.n_camera_zoom*global.h_ratio_by_window);
camera_set_view_size(view_camera[0],tmp_v_w,tmp_v_h);



//카메라 줌 사이즈에 반비례하여 값도 바뀌는 변수 (특정값*global.ratio_by_camera => 1로 보정됨)
global.ratio_by_camera = camera_get_view_width(view_camera[0])/1280;
if (global.ratio_by_camera <= 0.1 || global.ratio_by_camera == infinity)
{
	global.ratio_by_camera = 1;
}

//카메라 줌 사이즈에 비례하여 값도 변수
//[화면 사이즈가 작아져도 실제 사람 눈에 보이는 크기는 전체화면일때랑 똑같은 사이즈로 조정하는 용도]
global.reversed_ratio_by_camera = (1920/window_get_width())*global.ratio_by_camera;
if (global.reversed_ratio_by_camera == infinity || global.reversed_ratio_by_camera <= 0.1)
{
	global.reversed_ratio_by_camera = 1;
}



global.w_ratio_by_window = floor(sqrt(window_get_width()/1280)*10)/10;
global.h_ratio_by_window = floor(sqrt(window_get_height()/720)*10)/10;



//카메라 관련
v_x += (tv_x - v_x)*0.1;
v_y += (tv_y - v_y)*0.1;


if (instance_exists(global.camera_target))
{
	global.camera_target_x = global.camera_target.x;
	global.camera_target_y = global.camera_target.y;
}


if (global.camera_target_x == -4)
{
	x += (tmp_room_w_center - x)*0.15;
	y += (tmp_room_h_center - y)*0.15;
}
else
{
	x += (global.camera_target_x - x)*0.15;
	y += (global.camera_target_y - y)*0.15;
}





if (global.n_camera_zoom < 0.5)
{
	global.n_camera_zoom = 0.5;
}
else if (global.n_camera_zoom > 1.15)
{
	global.n_camera_zoom = 1.15;
}








if (global.t_shake_x <= 0.01)
{
	global.t_shake_x = 0;
}
	
if (global.t_shake_y <= 0.01)
{
	global.t_shake_y = 0;
}
global.t_shake_x += (0 - global.t_shake_x)*0.15;
global.t_shake_y += (0 - global.t_shake_y)*0.15;
global.real_shake_x = global.t_shake_x*global.shake_x;
global.real_shake_y = global.t_shake_y*global.shake_y;
global.shake_time ++;

if (global.shake_time > 1)
{
	global.shake_x = -global.shake_x;
	global.shake_y = -global.shake_y;
	global.shake_time = 0;
}










x += global.real_shake_x*0.3;
y += global.real_shake_y*0.3;
camera_set_view_angle(view_camera[0],global.view_angle_);


x = floor(x)
y = floor(y)











//화면 흰색으로 덮기
global.w_alpha += (global.t_w_alpha - global.w_alpha)*0.3;










//체력, 스테미나 UI관련
if (array_length(global.my_player_ins_id) > global.my_player_id)
{
	var my_p = global.my_player_ins_id[global.my_player_id];
	if (instance_exists(my_p))
	{
		hp_for_draw += (my_p.hp - hp_for_draw)*0.2;
		stamina_for_draw += (my_p.stamina - stamina_for_draw)*0.1;
		max_hp = my_p.max_hp;
		max_stamina = my_p.max_stamina;
	}
}


//버프-디버프 UI 드로우 관련 변수
weight_for_draw += (global.my_weight - weight_for_draw)*0.1;
hydro_for_draw += (global.hydration - hydro_for_draw)*0.1;
hunger_for_draw += (global.hunger - hunger_for_draw)*0.1;