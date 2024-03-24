/// @description Insert description here
// You can write your code in this editor
image_speed = 0;
image_xscale = 2;
image_yscale = 2;


//방향 관련 변수
my_n_dir = 0;
b_n_dir = 2;
global.n_dir = 2; //*90하면 바라보는 각도 값 나옴
my_backpack = 0;
b_my_backpack = -4;

//플레이어가 바라보는 방향을 마우스 방향으로 고정
global.fixed_dir = 1;

//이동 관련 변수
global.max_movement_speed = 8;
global.movement_hspeed = 0;
global.movement_vspeed = 0;

global.n_running = false;

//이전에 있던 내 룸 포지션
my_room_pos_xx = -4;
my_room_pos_yy = -4;


//z축
add_z_axis();


//닉네임 (플레이어 구분용)
nickname = -4;



//image_alpha값이랑 똑같은데 draw_sprite에서만 드로우 되지 않게 해주는 alpha값
draw_alpha = 1;


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





//인벤토리 시스템
inv_width = 12;
inv_height = 12;
for(var i = 0; i < inv_height; i++)
{
	for(var ii = 0; ii < inv_width; ii++)
	{
		//inv_info_spr_ind가
		//-4일때 = 비어있음
		//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
		reset_inv_variable(ii,i);
	}
}

set_inv_variable(id,0,0,spr_stackables,0,"Coin",1,99,1,1,0,0.002);
set_inv_variable(id,1,0,spr_stackables,3,"KeyCard",irandom_range(3,4),5,1,1,0,0.001);
set_inv_variable(id,2,0,spr_drink,0,"Coke",-4,-4,1,1,0,0.58);

set_inv_variable(id,0,1,spr_backpack,0,"Backpack",-4,-4,2,3,0,3);
set_inv_variable(id,2,1,spr_comp,8,"GPU",-4,-4,2,1,1,1);
set_inv_variable(id,3,0,spr_comp,23,"Iron Stick",-4,-4,1,2,0,6);





//체력
hp = 100;
max_hp = 100;
b_hp = -4;

//스테미나
stamina = 100;
max_stamina = 100;
stamina_cooltime = 0;

//내 무게
global.my_weight = 0;
speed_by_weight = 0;


//인터렉션 키 드로우 용
interaction_name_for_draw = "";
interaction_key_real_ind_for_draw = 0;
show_interaction_key = 0; // 0일때 드로우 안함


//다른 사람 시체 루팅
n_looting_inv_id = -4;


//다른사람이 내 인벤을 루팅중인지 체크
is_opened = -4; //-4 = 안 열림, -3 = 다른사람이 열고 있음, ins ref (숫자) = 내 자신이 열고 있으며 열려있는 인벤토리 id값을 반환
b_is_opened = -4;
