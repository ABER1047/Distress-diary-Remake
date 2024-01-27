/// @description Insert description here
// You can write your code in this editor
image_speed = 0;
image_xscale = 2;
image_yscale = 2;


//방향 관련 변수
my_n_dir = 0;
global.n_dir = 2; //*90하면 바라보는 각도 값 나옴
my_backpack = 0;

//이동 관련 변수
global.max_movement_hspeed = 12;
global.max_movement_vspeed = 12;
global.movement_hspeed = 0;
global.movement_vspeed = 0;

//이전에 있던 내 룸 포지션
my_room_pos_xx = -4;
my_room_pos_yy = -4;


//z축
add_z_axis();


//닉네임 (플레이어 구분용)
nickname = -4;



//카메라 타깃 설정
global.camera_target = id;



//멀티플레이 용 버퍼
command_buffer = buffer_create(1024,buffer_grow,1);


//이미지 정보 보내기 (멀티플레이)
alarm[1] = 1;

//멀티플레이용 틱레이트 포지션
tickrate_x = x;
tickrate_y = y;
tickrate_z = z;
