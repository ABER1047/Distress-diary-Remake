/// @description 랜덤 아이템 생성

//상자 종류에 따른 아이템 생성
item_num_to_create = (item_num_to_create == -4) ? choose(0,1,1,2,2,2,2,3,3,3,3,4) : item_num_to_create-1; //상자 안에 생성될 아이템 갯수

var tmp_spr_ind = -4; //생성할 아이템 sprite_index
var tmp_img_ind = -4; //생성할 아이템 image_index
var tmp_stack = -4; //생성할 아이템 stack
var tmp_chances = irandom_range(0,9999); //아이템 종류 설정 확률용 임시 변수
show_message_log("- 랜덤 아이템 생성 : "+string(tmp_chances));
	
switch(loots_name)
{
	case "버려진 철제 서랍": //버려진 철제 서랍
		if (tmp_chances < 1500) //15%확률로 볼트
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3000) //15%확률로 너트
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 1; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3250) //2.5%확률로 RAM
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3500) //2.5%확률로 CPU
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 5; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4000) //5%확률로 회로기판
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 6; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4500) //5%확률로 전선
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 7; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4600) //1%확률로 SSD
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 9; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4610) //0.1%확률로 GPU
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 8; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5410) //8%확률로 바느질 키트
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 10; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5510) //1%확률로 골든 해골
		{
			tmp_spr_ind = spr_equipments; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6010) //5%확률로 골든 코인 (1~15개)
		{
			tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
			tmp_stack = irandom_range(1,15); //생성할 아이템 stack
		}
		else if (tmp_chances < 6110) //1%확률로 골든 십자가
		{
			tmp_spr_ind = spr_equipments; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6610) //5%확률로 주사기
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 21; //생성할 아이템 image_index
		}
		else if (tmp_chances < 7110) //5%확률로 플라스틱 덩어리
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 13; //생성할 아이템 image_index
		}
		else if (tmp_chances < 7510) //4%확률로 천 조각
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 11; //생성할 아이템 image_index
		}
		else if (tmp_chances < 7910) //4%확률로 빈 병
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 24; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8210) //3%확률로 파워서플라이어
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 25; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9010) //8%확률로 종이 클립
		{
			tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
			tmp_stack = irandom_range(1,3); //생성할 아이템 stack
		}
		else if (tmp_chances < 9110) //1%확률로 키카드
		{
			tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
			tmp_stack = 1; //생성할 아이템 stack
		}
		else if (tmp_chances < 9610) //5%확률로 열쇠
		{
			tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
			tmp_stack = irandom_range(1,3); //생성할 아이템 stack
		}
		else if (tmp_chances < 9710) //1%확률로 해골 동상
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 14; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9810) //1%확률로 별 동상
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 15; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9970) //1.6%확률로 카드팩
		{
			tmp_spr_ind = spr_equipments; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
		}
		else //0.3%확률로 골드 바
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 20; //생성할 아이템 image_index
		}
	break;
		
	case "버려진 백팩": //버려진 백팩
		if (tmp_chances < 1200) //12%확률로 나무 막대
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 23; //생성할 아이템 image_index
		}
		else if (tmp_chances < 2300) //11%확률로 빈 병
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 24; //생성할 아이템 image_index
		}
		else if (tmp_chances < 2700) //4%확률로 콜라
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3100) //4%확률로 포도 주스
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 1; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3500) //4%확률로 오랜지 주스
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3900) //4%확률로 물병
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4300) //4%확률로 그린티
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4700) //4%확률로 연유
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 5; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5100) //4%확률로 우유
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 6; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5500) //4%확률로 오랜지 소다
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 7; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5900) //4%확률로 포도 소다
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 8; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6300) //4%확률로 에너지 드링크
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 9; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6350) //0.5%확률로 꿀병
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 10; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6550) //2%확률로 수상한 액체
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 11; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6750) //2%확률로 정제된 물
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 12; //생성할 아이템 image_index
		}
		else if (tmp_chances < 7150) //4%확률로 에너지바
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
		}
		else if (tmp_chances < 7550) //4%확률로 초콜릿바
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 1; //생성할 아이템 image_index
		}
		else if (tmp_chances < 7950) //4%확률로 감자칩
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8350) //4%확률로 소세지
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8750) //4%확률로 생선 통조림
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9150) //4%확률로 비프 스튜 통조림
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 5; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9250) //1%확률로 설탕 팩
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 6; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9650) //4%확률로 종이 클립
		{
			tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
			tmp_stack = irandom_range(1,3); //생성할 아이템 stack
		}
		else if (tmp_chances < 9651) //0.01%확률로 키카드
		{
			tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
			tmp_stack = 1; //생성할 아이템 stack
		}
		else //3.49%확률로 열쇠
		{
			tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
			tmp_stack = irandom_range(1,3); //생성할 아이템 stack
		}
	break;
		
	case "버려진 의료 가방": //버려진 의료 가방
		if (tmp_chances < 3500) //35%확률로 붕대
		{
			tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5000) //15%확률로 수제 부목
		{
			tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
			tmp_img_ind = 1; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6000) //10%확률로 부목
		{
			tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6500) //5%확률로 방사능약
		{
			tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
		}
		else if (tmp_chances < 7000) //5%확률로 해독약
		{
			tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8000) //10%확률로 알코올
		{
			tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
			tmp_img_ind = 5; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8500) //5%확률로 의료 주사기
		{
			tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
			tmp_img_ind = 6; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9500) //10%확률로 주사기
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 21; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9800) //3%확률로 수상한 액체
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 11; //생성할 아이템 image_index
		}
		else //2%확률로 정제된 물
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
		}
	break;
		
	case "버려진 PC": //버려진 PC
		if (tmp_chances < 2400) //24%확률로 RAM
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4800) //24%확률로 CPU
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 5; //생성할 아이템 image_index
		}
		else if (tmp_chances < 7300) //25%확률로 회로기판
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 6; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9800) //25%확률로 전선
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 7; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9850) //0.5%확률로 GPU
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 8; //생성할 아이템 image_index
		}
		else //1.5%확률로 SSD
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 9; //생성할 아이템 image_index
		}
	break;
		
	case "나무 상자": //나무 상자
		if (tmp_chances < 500) //5%확률로 콜라
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
		}
		else if (tmp_chances < 1100) //6%확률로 포도 주스
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 1; //생성할 아이템 image_index
		}
		else if (tmp_chances < 1700) //6%확률로 오랜지 주스
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
		}
		else if (tmp_chances < 2300) //6%확률로 물병
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
		}
		else if (tmp_chances < 2900) //6%확률로 그린티
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3200) //3%확률로 연유
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 5; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3800) //6%확률로 우유
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 6; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4400) //6%확률로 오랜지 소다
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 7; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5000) //6%확률로 포도 소다
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 8; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5600) //6%확률로 에너지 드링크
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 9; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5700) //1%확률로 꿀병
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 10; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6000) //3%확률로 수상한 액체
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 11; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6300) //3%확률로 정제된 물
		{
			tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
			tmp_img_ind = 12; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6900) //6%확률로 에너지바
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
		}
		else if (tmp_chances < 7400) //5%확률로 초콜릿바
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 1; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8000) //6%확률로 감자칩
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8600) //6%확률로 소세지
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9200) //6%확률로 생선 통조림
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9700) //5%확률로 비프 스튜 통조림
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 5; //생성할 아이템 image_index
		}
		else //3%확률로 설탕 팩
		{
			tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
			tmp_img_ind = 6; //생성할 아이템 image_index
		}
	break;
		
	case "황금 나무 상자": //황금 나무 상자
		if (tmp_chances < 2500) //25%확률로 금속 주괴
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 18; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3500) //10%확률로 고품질 금속 주괴
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 19; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6000) //25%확률로 전선
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 7; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8000) //20%확률로 플라스틱 덩어리
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 13; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8300) //3%확률로 천 조각
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 11; //생성할 아이템 image_index
		}
		else //17%확률로 금속 막대
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 22; //생성할 아이템 image_index
		}
	break;
		
	case "버려진 캐비넷": //대형 잠긴 상자
		if (tmp_chances < 2000) //20%확률로 볼트
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4000) //20%확률로 너트
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 1; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4500) //5%확률로 원유
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5000) //5%확률로 정제된 기름
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
		}
		else if (tmp_chances < 7000) //20%확률로 전선
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 7; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8000) //10%확률로 플라스틱 덩어리
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 13; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9000) //10%확률로 금속 주괴
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 19; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9500) //5%확률로 고품질 금속 주괴
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 19; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9600) //1%확률로 천 조각
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 11; //생성할 아이템 image_index
		}
		else //4%확률로 금속 막대
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 22; //생성할 아이템 image_index
		}
	break;
		
	case "엘리트 상자": //엘리트 상자
		if (tmp_chances < 1500) //15%확률로 슬링백
		{
			tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
		}
		else if (tmp_chances < 2800) //13%확률로 의료 가방
		{
			tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
			tmp_img_ind = 1; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3900) //11%확률로 더플백
		{
			tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4800) //9%확률로 백팩
		{
			tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5500) //7%확률로 여행자 백팩
		{
			tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6400) //9%확률로 대형 의료 가방
		{
			tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
			tmp_img_ind = 5; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6700) //3%확률로 전술용 가방
		{
			tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
			tmp_img_ind = 6; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8500) //18%확률로 흰색 페인트
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 16; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9000) //5%확률로 붉은색 페인트
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 17; //생성할 아이템 image_index
		}
		else //10%확률로 열쇠
		{
			tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
			tmp_stack = irandom_range(1,3); //생성할 아이템 stack
		}
	break;
		
	case "금고": //금고
		if (tmp_chances < 1000) //10%확률로 금속 주괴
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 18; //생성할 아이템 image_index
		}
		else if (tmp_chances < 2500) //20%확률로 고품질 금속 주괴
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 19; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3200) //7%확률로 해골 동상
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 14; //생성할 아이템 image_index
		}
		else if (tmp_chances < 3900) //7%확률로 별 동상
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 15; //생성할 아이템 image_index
		}
		else if (tmp_chances < 4400) //5%확률로 골드 바
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 20; //생성할 아이템 image_index
		}
		else if (tmp_chances < 5400) //10%확률로 금속 십자가
		{
			tmp_spr_ind = spr_equipments; //생성할 아이템 sprite_index
			tmp_img_ind = 1; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6100) //7%확률로 골든 십자가
		{
			tmp_spr_ind = spr_equipments; //생성할 아이템 sprite_index
			tmp_img_ind = 2; //생성할 아이템 image_index
		}
		else if (tmp_chances < 6800) //7%확률로 골든 해골
		{
			tmp_spr_ind = spr_equipments; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
		}
		else if (tmp_chances < 8600) //18%확률로 골든 코인 (1~15개)
		{
			tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
			tmp_img_ind = 0; //생성할 아이템 image_index
			tmp_stack = irandom_range(1,15); //생성할 아이템 stack
		}
		else if (tmp_chances < 9400) //8%확률로 SSD
		{
			tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
			tmp_img_ind = 9; //생성할 아이템 image_index
		}
		else if (tmp_chances < 9500) //1%확률로 키카드
		{
			tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
			tmp_img_ind = 3; //생성할 아이템 image_index
			tmp_stack = 1; //생성할 아이템 stack
		}
		else //5%확률로 골든 링
		{
			tmp_spr_ind = spr_equipments; //생성할 아이템 sprite_index
			tmp_img_ind = 4; //생성할 아이템 image_index
		}
	break;
}


var tmp_name = set_item_info_values(tmp_spr_ind,tmp_img_ind); //생성할 아이템 name
var tmp_max_stack = global.item_max_stack_num; //생성할 아이템 max_stack
var tmp_weight = global.item_weight; //생성할 아이템 name
var tmp_name_compressed = global.short_name; //생성할 아이템 name_compressed
var tmp_width = global.item_width; //생성할 아이템 width
var tmp_height = global.item_height; //생성할 아이템 height
	
var has_empty_pos = find_empty_pos(tmp_spr_ind,tmp_img_ind,tmp_width,tmp_height,tmp_stack,id); //상자 안의 빈자리 찾기
if (has_empty_pos != false)
{
	set_inv_variable(id,global.inv_empty_xpos,global.inv_empty_ypos,tmp_spr_ind,tmp_img_ind,tmp_stack,global.inv_empty_rotated,0);
	if (item_num_to_create > 0)
	{
		if (tmp_width*tmp_height >= 4)
		{
			item_num_to_create -= 2;
		}
		alarm[0] = 1;
	}
	else
	{
		//모든 인벤토리 정보를 상대에게 보내기
		send_InventoryDataAll(obj_id,object_index);
	}
}


