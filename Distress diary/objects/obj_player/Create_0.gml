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
inv_width = 4;
inv_height = 6;
for(var i = 0; i < inv_height; i++)
{
	for(var ii = 0; ii < inv_width; ii++)
	{
		//inv_info_spr_ind가
		//-4일때 = 비어있음
		//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
		inv_info_spr_ind[i][ii] = -4;//spr_ind값 보유
		
		
		inv_info_img_ind[i][ii] = -4;//img_ind값 보유
		inv_info_name[i][ii] = -4;//아이템의 이름 값 보유
		inv_info_stack_num[i][ii] = -4;//아이템의 갯수 값 보유
	}
}

inv_info_spr_ind[3][3] = spr_stackables;
inv_info_img_ind[3][3] = 0;
inv_info_name[3][3] = "Coin";
inv_info_stack_num[3][3] = 1;




//체력
hp = 0;



//인터렉션 키 드로우 용
interaction_key_for_draw = -4;
interaction_name_for_draw = "";
interaction_key_real_ind_for_draw = 0;
show_interaction_key = 0; // 0일때 드로우 안함


//다른 사람 시체 루팅
n_looting_player_ins = -4;