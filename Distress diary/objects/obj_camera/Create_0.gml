/// @description Insert description here
// You can write your code in this editor
image_speed = 0;
v_x = 1280
v_y = 720
tv_x = 3584
tv_y = 2016
view_shake_xx = 0
view_shake_yy = 0

global.is_mouse_inside_quickslot = false;
global.w_alpha = 0;
global.t_w_alpha = -0.01;
global.view_angle_ = 0
global.shake_x = 0
global.shake_y = 0
global.t_shake_x = 0
global.t_shake_y = 0
global.shake_time = 0
global.real_shake_x = 0
global.real_shake_y = 0

global.camera_target_x = -4
global.camera_target_y = -4

global.camera_target = -4;

global.n_camera_zoom = 0.7;

//카메라 줌 사이즈에 반비례하여 값도 바뀌는 변수 (특정값*global.ratio_by_camera => 1로 보정됨)
global.ratio_by_camera = 1;

//카메라 줌 사이즈에 비례하여 값도 변수
//[화면 사이즈가 작아져도 실제 사람 눈에 보이는 크기는 전체화면일때랑 똑같은 사이즈로 조정하는 용도]
global.reversed_ratio_by_camera = 1;

//퀵 슬롯 칸에 마우스가 들어가있는 경우
global.is_mouse_on_quickslot = -4;

depth = -99999;


//체력바 및 스테미나 UI 드로우 관련 변수
hp_for_draw = 0;
stamina_for_draw = 0;

//버프-디버프 UI 드로우 관련 변수
weight_for_draw = 0;
hydro_for_draw = 0;
hunger_for_draw = 0;


//setup_circular_bar
setup_circular_bar();