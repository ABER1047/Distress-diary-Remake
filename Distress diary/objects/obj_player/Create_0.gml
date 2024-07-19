/// @description Insert description here
// You can write your code in this editor
image_speed = 0;
image_xscale = 2;
image_yscale = 2;


//속도 관련 변수
add_speed_valuables();


//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();
my_pos_xx = -4;
my_pos_yy = -4;


//방향 관련 변수
my_n_dir = 0;
b_n_dir = 2;
my_backpack = 0;
b_my_backpack = -4;


//이동키 안먹히도록 설정 (UI같은거 열려있을때)
b_prohibit_movement_input = false;


//z축
add_z_axis();


//닉네임 (플레이어 구분용)
nickname = -4;



//image_alpha값이랑 똑같은데 draw_sprite에서만 드로우 되지 않게 해주는 alpha값
draw_alpha = 1;

//쿨타임 게이지 바 번쩍거림 효과
global.gage_bar_shine_animation = 0;


//카메라 타깃 설정
global.camera_target = (global.camera_target == -4) ? id : global.camera_target;



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

set_inv_variable(id,0,0,spr_stackables,0,irandom_range(60,99),0,0);
set_inv_variable(id,1,0,spr_stackables,3,irandom_range(3,4),0,0);
set_inv_variable(id,2,0,spr_drink,0,-4,0,0);

set_inv_variable(id,0,1,spr_backpack,0,-4,0,0);
set_inv_variable(id,3,1,spr_comp,8,-4,0,0);
set_inv_variable(id,4,0,spr_comp,23,-4,0,0);

set_quickslot_variable(0,spr_weapon,0,-4,0,0);
set_quickslot_variable(1,spr_weapon,1,-4,0,1);
set_quickslot_variable(2,spr_weapon,2,-4,0,2);
set_quickslot_variable(3,spr_weapon,3,6,0,3);
set_quickslot_variable(4,spr_weapon,4,99,0,4);




//체력
hp = 100;
b_hp = -4;

//스테미나
stamina = 100;
stamina_cooltime = 0;


//무게
speed_by_weight = 0;



//인터렉션 키 드로우 용
interaction_name_for_draw = "";
interaction_key_real_ind_for_draw = 0;
show_interaction_key = 0; // 0일때 드로우 안함


//다른 사람 시체 루팅
n_looting_inv_id = -4;
loots_name = string(nickname)+"'의 인벤토리";


//다른사람이 내 인벤을 루팅중인지 체크
is_opened = -4; //-4 = 안 열림, -3 = 다른사람이 열고 있음, ins ref (숫자) = 내 자신이 열고 있으며 열려있는 인벤토리 id값을 반환
b_is_opened = -4;


//인터렉트 메세지
interaction_message = "루팅";


//발소리 효과음
played_footstep_sfx = false;
played_jump_sfx = false;


//데미지 애니메이션 관련 변수
dmg_cooltime = 0;



//맵 이동 화면전환 애니메이션
move_to_other_room = -4;


//인스턴스 아이디 저장 
if (instance_number(obj_player) == 1)
{
	global.my_player_ins_id[0] = id;
	x = room_width*0.5;
	y = room_height*0.5;
}

//공격 이펙트 방향 저장용
b_attack_ins = -4;
a_timer = 0;



//게이지 바 차징 정도
gage_bar_charged = 0;
tmp_dmg_cal = 0; //데미지 계산용 임시 변수