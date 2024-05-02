/// @description Insert description here
// You can write your code in this editor
image_speed = 0;
image_xscale = 2;
image_yscale = 2;
image_alpha = 0.2;
//이동할 방 (0 = 오른쪽부터 시작해서 반시계방향)
//tp_to = 0;

floor_arrow_img_ind = irandom_range(0,2);


//방 이동 가능한지 (문이 잠겨있거나 한 경우 이동 불가능)
can_use_tp = false;
door_yy = 0;



//화살표 애니메이션
arrow_animation_yy = 0;
arrow_animation_timer = 0;

//입구 주변 벽 인스턴스 저장용 변수
ins_wall = [ -4, -4 ];

//문 그리기용 서피스
door_surf = surface_create(128,116);