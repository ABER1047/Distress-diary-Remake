/// @description Insert description here
// You can write your code in this editor
image_speed = 0;
image_xscale = 2;
image_yscale = 2;


//방향 관련 변수
global.n_dir = 2; //*90하면 바라보는 각도 값 나옴


//이동 관련 변수
global.max_movement_hspeed = 12;
global.max_movement_vspeed = 12;
global.movement_hspeed = 0;
global.movement_vspeed = 0;


//z축
add_z_axis();


//닉네임 (플레이어 구분용)
nickname = -4;



//카메라 타깃 설정
global.camera_target = id;



//멀티플레이 용 버퍼
command_buffer = buffer_create(512,buffer_grow,1);