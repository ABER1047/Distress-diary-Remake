/// @description Insert description here
// You can write your code in this editor
v_x += (tv_x - v_x)*0.1;
v_y += (tv_y - v_y)*0.1;


if (instance_exists(global.camera_target))
{
	global.camera_target_x = global.camera_target.x;
	global.camera_target_y = global.camera_target.y;
}


if (global.camera_target_x == -4)
{
	x += (room_width*0.5 - x)*0.15;
	y += (room_height*0.5 - y)*0.15;
}
else
{
	x += (global.camera_target_x - x)*0.3;
	y += (global.camera_target_y - y)*0.3;
}


if (global.n_camera_zoom < 0.5)
{
	global.n_camera_zoom = 0.5;
}
else if (global.n_camera_zoom > 1.15)
{
	global.n_camera_zoom = 1.15;
}



global.view_angle_ += (0 - global.view_angle_)*0.1;

global.w_ratio_by_window = sqrt(window_get_width()/1280);
global.h_ratio_by_window = sqrt(window_get_height()/720);
camera_set_view_size(view_camera[0],floor(v_x)*global.n_camera_zoom*global.w_ratio_by_window,floor(v_y)*global.n_camera_zoom*global.h_ratio_by_window);


if (global.t_shake_x <= 0.01)
{
	global.t_shake_x = 0;
}
	
if (global.t_shake_y <= 0.01)
{
	global.t_shake_y = 0;
}
global.t_shake_x += (0 - global.t_shake_x)*0.25;
global.t_shake_y += (0 - global.t_shake_y)*0.25;
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
