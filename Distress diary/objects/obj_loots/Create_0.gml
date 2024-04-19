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
image_xscale = 2.5;
image_yscale = 2.5;
image_speed = 0;



//인터렉션 키 드로우 용
interaction_name_for_draw = "";
interaction_key_real_ind_for_draw = 0;
show_interaction_key = 0; // 0일때 드로우 안함


//생성되는 랜덤아이템 갯수
item_num_to_create = -4; //-4으로 고정 후 alarm[0] 이벤트에서 관리


//인터렉트 메세지
interaction_message = "루팅";


//블럭 밀기 시스템
pushing_animation = false;
pushing_timer = 0;
origin_xx = xstart;
origin_yy = ystart;
draw_xx = 0;
draw_yy = 0;
pusher = -4;
