/// @description Insert description here
// You can write your code in this editor

//기본 이미지 세팅
image_speed = 0;
image_xscale = 2;
image_yscale = 2;
image_alpha = 1;

//z축 추가
add_z_axis();

//속도 관련 변수
add_speed_valuables();

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();


//상자 이름
//loots_name = "";

//오브젝트 아이디
//obj_id = 0;



//상자 열린상태인지 체크
is_opened = -4; //-4 = 안 열림, -3 = 다른사람이 열고 있음, ins ref (숫자) = 내 자신이 열고 있으며 열려있는 인벤토리 id값을 반환
b_is_opened = -4;


//인벤토리 크기 자동 조정
resize_inv = false;



//생성 효과음
play_sound_pos(inventory1_sfx,false,0.1,x,y,160,true,-4,-4);


//인터렉션 키 드로우 용
interaction_name_for_draw = "";
interaction_key_real_ind_for_draw = 0;
show_interaction_key = 0; // 0일때 드로우 안함



//삭제 타이머
des_timer = 0;

//네트워크상으로 위치 전송하기 위한 용도
alarm[1] = 1;


//멀티플레이 용 버퍼
command_buffer = buffer_create(1024,buffer_grow,1);


//인터렉트 메세지
interaction_message = "루팅";