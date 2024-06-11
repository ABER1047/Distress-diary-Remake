/// @description Insert description here
// You can write your code in this editor

//이미지 설정
image_speed = 0;


//투사체 타입 (몬스터 별로 타입 지정해서 해당 움직임 재생)
//type = 0;


//부모 인스턴스
//parents = id;


//각 타입별로 사용하는 임시 변수값 (각 타입별로 다른 용도로 활용됨)
tmp_value1 = -4;
tmp_value2 = -4;
tmp_value3 = -4;
tmp_value4 = 0;

//z축
add_z_axis();

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();


//버블 이펙트 외곽선 효과용 오브젝트
bubble_ef_ins = -4;