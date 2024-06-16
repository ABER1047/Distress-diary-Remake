/// @description Insert description here
// You can write your code in this editor
image_speed = 0;
image_index = 0;
depth = obj_camera.depth - 16;
global.prohibit_movement_input = true;


face_img_ind = 1;
play_face_animation = 3; //이모지 얼굴 애니메이션 플레이 (해당 값 만큼 반복)
face_animation_timer = 0;


result_img_ind = 1;
tmp_result_img_ind = 0;
play_result_animation = 1; //결과 애니메이션 플레이 (값에 따라 다른 애니메이션 재생)
result_animation_timer = 0;

result_animation_playtime = -4; //애니메이션 재생 시간 (프레임 단위)
result_animation_timer_sec = 0;



//베팅할 골드
bet_amount = 5;

//베팅한 주사위
my_bet_dice = 0;

//효과음 재생
alarm[0] = 1;


//인벤토리 UI강제 닫기
instance_destroy(obj_inv_ui);


//CRT효과 서피스
event_user(2);
crt_yy = 0;


//임시 변수
i = 0;
ii = 0;