/// @description Insert description here
// You can write your code in this editor




//상자 열린상태인지 체크
is_opened = -4; //-4 = 안 열림, -3 = 다른사람이 열고 있음, ins ref (숫자) = 내 자신이 열고 있으며 열려있는 인벤토리 id값을 반환
b_is_opened = -4;

//상자 열리는 애니메이션
opening_animation = 0;


//상자 이름
//loots_name = "";

//오브젝트 아이디
//obj_id = 0;


//인벤토리
//inv_width = 0;
//inv_height = 0;


//이미지 관련 기본 세팅
image_xscale = 2;
image_yscale = 2;
image_speed = 0;



//인터렉션 키 드로우 용
interaction_name_for_draw = "";
interaction_key_real_ind_for_draw = 0;
show_interaction_key = 0; // 0일때 드로우 안함