// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param x
///@param y
///@param img_ind
///@param obj_id
///@param DoNotSend
function create_randomized_loots(argument0,argument1,argument2,argument3,argument4)
{
	var tmp_arr_ind = floor(argument2/2);
	var tmp_inv_width = [ 3, 4, 4, 4, 4, 3, 4, 6, 3, 4, 0, 0, 8, 3 ];
	var tmp_inv_height = [ 6, 4, 4, 4, 4, 3, 4, 3, 3, 7, 0, 0, 5, 3 ];
	var tmp_chest_name = [ "버려진 철제 서랍", "버려진 백팩", "버려진 의료 가방", "버려진 PC", "버려진 PC", "나무 상자", "철제 상자", "대형 철제 상자", "공구 상자", "버려진 캐비넷", "", "", "대형 나무 상자", "금고" ];
	var tmp_ins = create_loots(argument0,argument1,argument2,tmp_inv_width[tmp_arr_ind],tmp_inv_height[tmp_arr_ind],tmp_chest_name[tmp_arr_ind],argument3,argument4);
	tmp_ins.alarm[0] = 1;
	
	
	//상자 종류에 따른 아이템 생성
	/*var item_num_to_create = choose(0,1,1,2,2,2,2,3,3,3,3,4); //상자 안에 생성될 아이템 갯수
	repeat(item_num_to_create)
	{
		var tmp_spr_ind = -4; //생성할 아이템 sprite_index
		var tmp_img_ind = -4; //생성할 아이템 image_index
		var tmp_width = 1; //생성할 아이템 width
		var tmp_height = 1; //생성할 아이템 height
		var tmp_stack = -4; //생성할 아이템 stack
		var tmp_max_stack = -4; //생성할 아이템 max_stack
		var tmp_name = -4; //생성할 아이템 name
		var tmp_weight = 0; //생성할 아이템 name
		var tmp_name_compressed = -4; //생성할 아이템 name_compressed
		var tmp_chances = irandom_range(0,9999); //아이템 종류 설정 확률용 임시 변수
		show_message_log("- 랜덤 아이템 생성 : "+string(tmp_chances));
	
		switch(argument2)
		{
			case 0: //버려진 철제 서랍
				if (tmp_chances < 1500) //15%확률로 볼트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Bolt"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 1500 && tmp_chances < 3000) //15%확률로 너트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 1; //생성할 아이템 image_index
					tmp_name = "Nut"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 3000 && tmp_chances < 3250) //2.5%확률로 RAM
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 4; //생성할 아이템 image_index
					tmp_name = "RAM"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 3250 && tmp_chances < 3500) //2.5%확률로 CPU
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 5; //생성할 아이템 image_index
					tmp_name = "CPU"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 3500 && tmp_chances < 4000) //5%확률로 회로기판
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 6; //생성할 아이템 image_index
					tmp_name = "Circuit Board"; //생성할 아이템 name
					tmp_name_compressed = "Board"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 4000 && tmp_chances < 4500) //5%확률로 전선
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 7; //생성할 아이템 image_index
					tmp_name = "Wire"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 4500 && tmp_chances < 4600) //1%확률로 SSD
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 9; //생성할 아이템 image_index
					tmp_name = "SSD"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 4600 && tmp_chances < 4610) //0.1%확률로 GPU
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 8; //생성할 아이템 image_index
					tmp_name = "GPU"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 4610 && tmp_chances < 5410) //8%확률로 바느질 키트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 10; //생성할 아이템 image_index
					tmp_name = "Sewing kit"; //생성할 아이템 name
					tmp_name_compressed = "Kit"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 5410 && tmp_chances < 5510) //1%확률로 골든 해골
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 29; //생성할 아이템 image_index
					tmp_name = "Golden skull"; //생성할 아이템 name
					tmp_name_compressed = "Skull"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 5510 && tmp_chances < 6010) //5%확률로 골든 코인 (1~15개)
				{
					tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Golden Coin"; //생성할 아이템 name
					tmp_name_compressed = "Coin"; //생성할 아이템 name_compressed
					tmp_stack = irandom_range(1,15); //생성할 아이템 stack
					tmp_max_stack = 99; //생성할 아이템 max_stack
				}
				else if (tmp_chances >= 6010 && tmp_chances < 6110) //1%확률로 골든 십자가
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 27; //생성할 아이템 image_index
					tmp_name = "Golden Cross"; //생성할 아이템 name
					tmp_name_compressed = "Cross"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 6110 && tmp_chances < 6610) //5%확률로 주사기
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 22; //생성할 아이템 image_index
					tmp_name = "Sylinge"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 6610 && tmp_chances < 7110) //5%확률로 플라스틱 덩어리
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 13; //생성할 아이템 image_index
					tmp_name = "Plastic lump"; //생성할 아이템 name
					tmp_name_compressed = "Plastic"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 7110 && tmp_chances < 7510) //4%확률로 천 조각
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 11; //생성할 아이템 image_index
					tmp_name = "Cloth"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 7510 && tmp_chances < 7910) //4%확률로 빈 병
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 25; //생성할 아이템 image_index
					tmp_name = "Empty Bottle"; //생성할 아이템 name
					tmp_name_compressed = "Bottle"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 7910 && tmp_chances < 8210) //3%확률로 파워서플라이어
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 28; //생성할 아이템 image_index
					tmp_name = "PSU"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 8210 && tmp_chances < 9010) //8%확률로 종이 클립
				{
					tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Paper Clip"; //생성할 아이템 name
					tmp_name_compressed = "Clip"; //생성할 아이템 name_compressed
					tmp_stack = irandom_range(1,3); //생성할 아이템 stack
					tmp_max_stack = 10; //생성할 아이템 max_stack
				}
				else if (tmp_chances >= 9010 && tmp_chances < 9110) //1%확률로 키카드
				{
					tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Keycard"; //생성할 아이템 name
					tmp_name_compressed = "Card"; //생성할 아이템 name_compressed
					tmp_stack = 1; //생성할 아이템 stack
					tmp_max_stack = 5; //생성할 아이템 max_stack
				}
				else if (tmp_chances >= 9110 && tmp_chances < 9610) //5%확률로 열쇠
				{
					tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
					tmp_img_ind = 4; //생성할 아이템 image_index
					tmp_name = "Key"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_stack = irandom_range(1,3); //생성할 아이템 stack
					tmp_max_stack = 3; //생성할 아이템 max_stack
				}
				else if (tmp_chances >= 9610 && tmp_chances < 9710) //1%확률로 해골 동상
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 14; //생성할 아이템 image_index
					tmp_name = "Skull Statue"; //생성할 아이템 name
					tmp_name_compressed = "Statue"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 9710 && tmp_chances < 9810) //1%확률로 별 동상
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 15; //생성할 아이템 image_index
					tmp_name = "Star Statue"; //생성할 아이템 name
					tmp_name_compressed = "Statue"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 9810 && tmp_chances < 9970) //1.6%확률로 카드팩
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 16; //생성할 아이템 image_index
					tmp_name = "Pack of Cards"; //생성할 아이템 name
					tmp_name_compressed = "Cards"; //생성할 아이템 name_compressed
				}
				else //0.3%확률로 골드 바
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 21; //생성할 아이템 image_index
					tmp_name = "Golden Bar"; //생성할 아이템 name
					tmp_name_compressed = "Gold"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
			break;
		
			case 2: //버려진 백팩
				if (tmp_chances < 1200) //12%확률로 나무 막대
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 24; //생성할 아이템 image_index
					tmp_name = "Wooden Stick"; //생성할 아이템 name
					tmp_name_compressed = "Wood"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 1200 && tmp_chances < 2300) //11%확률로 빈 병
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 25; //생성할 아이템 image_index
					tmp_name = "Empty Bottle"; //생성할 아이템 name
					tmp_name_compressed = "Bottle"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 2300 && tmp_chances < 2700) //4%확률로 콜라
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Coke"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 2700 && tmp_chances < 3100) //4%확률로 포도 주스
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 1; //생성할 아이템 image_index
					tmp_name = "Grape Juice"; //생성할 아이템 name
					tmp_name_compressed = "Juice"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 3100 && tmp_chances < 3500) //4%확률로 오랜지 주스
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Orange Juice"; //생성할 아이템 name
					tmp_name_compressed = "Juice"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 3500 && tmp_chances < 3900) //4%확률로 물병
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Bottle of Water"; //생성할 아이템 name
					tmp_name_compressed = "Water"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 3900 && tmp_chances < 4300) //4%확률로 그린티
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 4; //생성할 아이템 image_index
					tmp_name = "Green tea"; //생성할 아이템 name
					tmp_name_compressed = "Tea"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 4300 && tmp_chances < 4700) //4%확률로 연유
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 5; //생성할 아이템 image_index
					tmp_name = "Condensed Milk"; //생성할 아이템 name
					tmp_name_compressed = "Cond"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 4700 && tmp_chances < 5100) //4%확률로 우유
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 6; //생성할 아이템 image_index
					tmp_name = "Milk"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 5100 && tmp_chances < 5500) //4%확률로 오랜지 소다
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 7; //생성할 아이템 image_index
					tmp_name = "Orange Soda"; //생성할 아이템 name
					tmp_name_compressed = "Soda"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 5500 && tmp_chances < 5900) //4%확률로 포도 소다
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 8; //생성할 아이템 image_index
					tmp_name = "Grape Soda"; //생성할 아이템 name
					tmp_name_compressed = "Soda"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 5900 && tmp_chances < 6300) //4%확률로 에너지 드링크
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 9; //생성할 아이템 image_index
					tmp_name = "Energy Drink"; //생성할 아이템 name
					tmp_name_compressed = "Energy"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 6300 && tmp_chances < 6350) //0.5%확률로 꿀병
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 10; //생성할 아이템 image_index
					tmp_name = "Bottle of Honey"; //생성할 아이템 name
					tmp_name_compressed = "Honey"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 6350 && tmp_chances < 6550) //2%확률로 수상한 액체
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 11; //생성할 아이템 image_index
					tmp_name = "Suspicious liquid"; //생성할 아이템 name
					tmp_name_compressed = "Liquid"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 6550 && tmp_chances < 6750) //2%확률로 정제된 물
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 12; //생성할 아이템 image_index
					tmp_name = "Purified Water"; //생성할 아이템 name
					tmp_name_compressed = "Water"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 6750 && tmp_chances < 7150) //4%확률로 에너지바
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Energy bar"; //생성할 아이템 name
					tmp_name_compressed = "Bar"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 7150 && tmp_chances < 7550) //4%확률로 초콜릿바
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 1; //생성할 아이템 image_index
					tmp_name = "Chocolate bar"; //생성할 아이템 name
					tmp_name_compressed = "Choco"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 7550 && tmp_chances < 7950) //4%확률로 감자칩
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Chips"; //생성할 아이템 name
					tmp_name_compressed = "Chips"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 7950 && tmp_chances < 8350) //4%확률로 소세지
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Sausage"; //생성할 아이템 name
					tmp_name_compressed = "Saus"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 8350 && tmp_chances < 8750) //4%확률로 생선 통조림
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 4; //생성할 아이템 image_index
					tmp_name = "Can of Fish"; //생성할 아이템 name
					tmp_name_compressed = "Fish"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 8750 && tmp_chances < 9150) //4%확률로 비프 스튜 통조림
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 5; //생성할 아이템 image_index
					tmp_name = "Can of Beef stew"; //생성할 아이템 name
					tmp_name_compressed = "Beef"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 9150 && tmp_chances < 9250) //1%확률로 설탕 팩
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 6; //생성할 아이템 image_index
					tmp_name = "Pack of Sugar"; //생성할 아이템 name
					tmp_name_compressed = "Sugar"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 9250 && tmp_chances < 9650) //4%확률로 종이 클립
				{
					tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Paper Clip"; //생성할 아이템 name
					tmp_name_compressed = "Clip"; //생성할 아이템 name_compressed
					tmp_stack = irandom_range(1,3); //생성할 아이템 stack
					tmp_max_stack = 10; //생성할 아이템 max_stack
				}
				else if (tmp_chances >= 9650 && tmp_chances < 9651) //0.01%확률로 키카드
				{
					tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Keycard"; //생성할 아이템 name
					tmp_name_compressed = "Card"; //생성할 아이템 name_compressed
					tmp_stack = 1; //생성할 아이템 stack
					tmp_max_stack = 5; //생성할 아이템 max_stack
				}
				else //3.49%확률로 열쇠
				{
					tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
					tmp_img_ind = 4; //생성할 아이템 image_index
					tmp_name = "Key"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_stack = irandom_range(1,3); //생성할 아이템 stack
					tmp_max_stack = 3; //생성할 아이템 max_stack
				}
			break;
		
			case 4: //버려진 의료 가방
				if (tmp_chances < 3500) //35%확률로 붕대
				{
					tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Bandage"; //생성할 아이템 name
					tmp_name_compressed = "Band"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 3500 && tmp_chances < 5000) //15%확률로 수제 부목
				{
					tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
					tmp_img_ind = 1; //생성할 아이템 image_index
					tmp_name = "Handmade Immobilizing Splint"; //생성할 아이템 name
					tmp_name_compressed = "Splint"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 5000 && tmp_chances < 6000) //10%확률로 부목
				{
					tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Immobilizing Splint"; //생성할 아이템 name
					tmp_name_compressed = "Splint"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 6000 && tmp_chances < 6500) //5%확률로 방사능약
				{
					tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Anti-Radiation Pills"; //생성할 아이템 name
					tmp_name_compressed = "Rad"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 6500 && tmp_chances < 7000) //5%확률로 해독약
				{
					tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
					tmp_img_ind = 4; //생성할 아이템 image_index
					tmp_name = "Anti-Poisoning Pills"; //생성할 아이템 name
					tmp_name_compressed = "Poison"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 7000 && tmp_chances < 8000) //10%확률로 알코올
				{
					tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
					tmp_img_ind = 5; //생성할 아이템 image_index
					tmp_name = "Alcohol"; //생성할 아이템 name
					tmp_name_compressed = "C2H6O"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 8000 && tmp_chances < 8500) //5%확률로 의료 주사기
				{
					tmp_spr_ind = spr_healings; //생성할 아이템 sprite_index
					tmp_img_ind = 6; //생성할 아이템 image_index
					tmp_name = "Medical Sylinge"; //생성할 아이템 name
					tmp_name_compressed = "Medkit"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 8500 && tmp_chances < 9500) //10%확률로 주사기
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 22; //생성할 아이템 image_index
					tmp_name = "Sylinge"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 9500 && tmp_chances < 9800) //3%확률로 수상한 액체
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 11; //생성할 아이템 image_index
					tmp_name = "Suspicious liquid"; //생성할 아이템 name
					tmp_name_compressed = "Liquid"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else //2%확률로 정제된 물
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Purified Water"; //생성할 아이템 name
					tmp_name_compressed = "Water"; //생성할 아이템 name_compressed
				}
			break;
		
			case 6: //버려진 비트코인 채굴기
			case 8: //버려진 비트코인 채굴기
				if (tmp_chances < 2400) //24%확률로 RAM
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 4; //생성할 아이템 image_index
					tmp_name = "RAM"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 2400 && tmp_chances < 4800) //24%확률로 CPU
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 5; //생성할 아이템 image_index
					tmp_name = "CPU"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 4800 && tmp_chances < 7300) //25%확률로 회로기판
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 6; //생성할 아이템 image_index
					tmp_name = "Circuit Board"; //생성할 아이템 name
					tmp_name_compressed = "Board"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 7300 && tmp_chances < 9800) //25%확률로 전선
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 7; //생성할 아이템 image_index
					tmp_name = "Wire"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 9800 && tmp_chances < 9850) //0.5%확률로 GPU
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 8; //생성할 아이템 image_index
					tmp_name = "GPU"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else //1.5%확률로 SSD
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 9; //생성할 아이템 image_index
					tmp_name = "SSD"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
			break;
		
			case 10: //나무 상자
				if (tmp_chances < 500) //5%확률로 콜라
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Coke"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 500 && tmp_chances < 1100) //6%확률로 포도 주스
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 1; //생성할 아이템 image_index
					tmp_name = "Grape Juice"; //생성할 아이템 name
					tmp_name_compressed = "Juice"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 1100 && tmp_chances < 1700) //6%확률로 오랜지 주스
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Orange Juice"; //생성할 아이템 name
					tmp_name_compressed = "Juice"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 1700 && tmp_chances < 2300) //6%확률로 물병
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Bottle of Water"; //생성할 아이템 name
					tmp_name_compressed = "Water"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 2300 && tmp_chances < 2900) //6%확률로 그린티
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 4; //생성할 아이템 image_index
					tmp_name = "Green tea"; //생성할 아이템 name
					tmp_name_compressed = "Tea"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 2900 && tmp_chances < 3200) //3%확률로 연유
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 5; //생성할 아이템 image_index
					tmp_name = "Condensed Milk"; //생성할 아이템 name
					tmp_name_compressed = "Cond"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 3200 && tmp_chances < 3800) //6%확률로 우유
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 6; //생성할 아이템 image_index
					tmp_name = "Milk"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 3800 && tmp_chances < 4400) //6%확률로 오랜지 소다
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 7; //생성할 아이템 image_index
					tmp_name = "Orange Soda"; //생성할 아이템 name
					tmp_name_compressed = "Soda"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 4400 && tmp_chances < 5000) //6%확률로 포도 소다
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 8; //생성할 아이템 image_index
					tmp_name = "Grape Soda"; //생성할 아이템 name
					tmp_name_compressed = "Soda"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 5000 && tmp_chances < 5600) //6%확률로 에너지 드링크
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 9; //생성할 아이템 image_index
					tmp_name = "Energy Drink"; //생성할 아이템 name
					tmp_name_compressed = "Energy"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 5600 && tmp_chances < 5700) //1%확률로 꿀병
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 10; //생성할 아이템 image_index
					tmp_name = "Bottle of Honey"; //생성할 아이템 name
					tmp_name_compressed = "Honey"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 5700 && tmp_chances < 6000) //3%확률로 수상한 액체
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 11; //생성할 아이템 image_index
					tmp_name = "Suspicious liquid"; //생성할 아이템 name
					tmp_name_compressed = "Liquid"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 6000 && tmp_chances < 6300) //3%확률로 정제된 물
				{
					tmp_spr_ind = spr_drink; //생성할 아이템 sprite_index
					tmp_img_ind = 12; //생성할 아이템 image_index
					tmp_name = "Purified Water"; //생성할 아이템 name
					tmp_name_compressed = "Water"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 6300 && tmp_chances < 6900) //6%확률로 에너지바
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Energy bar"; //생성할 아이템 name
					tmp_name_compressed = "Bar"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 6900 && tmp_chances < 7400) //5%확률로 초콜릿바
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 1; //생성할 아이템 image_index
					tmp_name = "Chocolate bar"; //생성할 아이템 name
					tmp_name_compressed = "Choco"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 7400 && tmp_chances < 8000) //6%확률로 감자칩
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Chips"; //생성할 아이템 name
					tmp_name_compressed = "Chips"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 8000 && tmp_chances < 8600) //6%확률로 소세지
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Sausage"; //생성할 아이템 name
					tmp_name_compressed = "Saus"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 8600 && tmp_chances < 9200) //6%확률로 생선 통조림
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 4; //생성할 아이템 image_index
					tmp_name = "Can of Fish"; //생성할 아이템 name
					tmp_name_compressed = "Fish"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 9200 && tmp_chances < 9700) //5%확률로 비프 스튜 통조림
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 5; //생성할 아이템 image_index
					tmp_name = "Can of Beef stew"; //생성할 아이템 name
					tmp_name_compressed = "Beef"; //생성할 아이템 name_compressed
				}
				else //3%확률로 설탕 팩
				{
					tmp_spr_ind = spr_foods; //생성할 아이템 sprite_index
					tmp_img_ind = 6; //생성할 아이템 image_index
					tmp_name = "Pack of Sugar"; //생성할 아이템 name
					tmp_name_compressed = "Sugar"; //생성할 아이템 name_compressed
				}
			break;
		
			case 12: //잠긴 상자
				if (tmp_chances < 2500) //25%확률로 금속 주괴
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 19; //생성할 아이템 image_index
					tmp_name = "Metal ingot"; //생성할 아이템 name
					tmp_name_compressed = "Metal"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 2500 && tmp_chances < 3500) //10%확률로 고품질 금속 주괴
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 20; //생성할 아이템 image_index
					tmp_name = "High Quality Metal ingot"; //생성할 아이템 name
					tmp_name_compressed = "HQMetal"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 3500 && tmp_chances < 6000) //25%확률로 전선
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 7; //생성할 아이템 image_index
					tmp_name = "Wire"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 6000 && tmp_chances < 8000) //20%확률로 플라스틱 덩어리
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 13; //생성할 아이템 image_index
					tmp_name = "Plastic lump"; //생성할 아이템 name
					tmp_name_compressed = "Plastic"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 8000 && tmp_chances < 8300) //3%확률로 천 조각
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 11; //생성할 아이템 image_index
					tmp_name = "Cloth"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else //17%확률로 금속 파이프
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 23; //생성할 아이템 image_index
					tmp_name = "Metal Pipe"; //생성할 아이템 name
					tmp_name_compressed = "Pipe"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
			break;
		
			case 14: //대형 잠긴 상자
				if (tmp_chances < 2000) //20%확률로 볼트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Bolt"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 2000 && tmp_chances < 4000) //20%확률로 너트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 1; //생성할 아이템 image_index
					tmp_name = "Nut"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 4000 && tmp_chances < 4500) //5%확률로 원유
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Crude Oil"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 4500 && tmp_chances < 5000) //5%확률로 정제된 기름
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Refined Oil"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 5000 && tmp_chances < 7000) //20%확률로 전선
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 7; //생성할 아이템 image_index
					tmp_name = "Wire"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 7000 && tmp_chances < 8000) //10%확률로 플라스틱 덩어리
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 13; //생성할 아이템 image_index
					tmp_name = "Plastic lump"; //생성할 아이템 name
					tmp_name_compressed = "Plastic"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 8000 && tmp_chances < 9000) //10%확률로 금속 주괴
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 19; //생성할 아이템 image_index
					tmp_name = "Metal ingot"; //생성할 아이템 name
					tmp_name_compressed = "Metal"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 9000 && tmp_chances < 9500) //5%확률로 고품질 금속 주괴
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 20; //생성할 아이템 image_index
					tmp_name = "High Quality Metal ingot"; //생성할 아이템 name
					tmp_name_compressed = "HQMetal"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 9500 && tmp_chances < 9600) //1%확률로 천 조각
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 11; //생성할 아이템 image_index
					tmp_name = "Cloth"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else //4%확률로 금속 파이프
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 23; //생성할 아이템 image_index
					tmp_name = "Metal Pipe"; //생성할 아이템 name
					tmp_name_compressed = "Pipe"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
			break;
		
			case 16: //공구 상자
				if (tmp_chances < 2500) //25%확률로 볼트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Bolt"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 2500 && tmp_chances < 5000) //25%확률로 너트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 1; //생성할 아이템 image_index
					tmp_name = "Nut"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 5000 && tmp_chances < 7000) //20%확률로 금속 주괴
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 19; //생성할 아이템 image_index
					tmp_name = "Metal ingot"; //생성할 아이템 name
					tmp_name_compressed = "Metal"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 7000 && tmp_chances < 9500) //25%확률로 종이 클립
				{
					tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Paper Clip"; //생성할 아이템 name
					tmp_name_compressed = "Clip"; //생성할 아이템 name_compressed
					tmp_stack = irandom_range(1,3); //생성할 아이템 stack
					tmp_max_stack = 10; //생성할 아이템 max_stack
				}
				else //4%확률로 금속 파이프
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 23; //생성할 아이템 image_index
					tmp_name = "Metal Pipe"; //생성할 아이템 name
					tmp_name_compressed = "Pipe"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
			break;
		
			case 18: //버려진 캐비넷
				if (tmp_chances < 1500) //15%확률로 슬링백
				{
					tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Sling bag"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 3; //생성할 아이템 width
					tmp_height = 4; //생성할 아이템 height
				}
				else if (tmp_chances >= 1500 && tmp_chances < 2800) //13%확률로 의료 가방
				{
					tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
					tmp_img_ind = 1; //생성할 아이템 image_index
					tmp_name = "Med bag"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 3; //생성할 아이템 width
					tmp_height = 3; //생성할 아이템 height
				}
				else if (tmp_chances >= 2800 && tmp_chances < 3900) //11%확률로 더플백
				{
					tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Duffle bag"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 4; //생성할 아이템 width
					tmp_height = 3; //생성할 아이템 height
				}
				else if (tmp_chances >= 3900 && tmp_chances < 4800) //9%확률로 백팩
				{
					tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Backpack"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 3; //생성할 아이템 width
					tmp_height = 4; //생성할 아이템 height
				}
				else if (tmp_chances >= 4800 && tmp_chances < 5500) //7%확률로 여행자 백팩
				{
					tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
					tmp_img_ind = 4; //생성할 아이템 image_index
					tmp_name = "Tourist backpack"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 3; //생성할 아이템 width
					tmp_height = 4; //생성할 아이템 height
				}
				else if (tmp_chances >= 5500 && tmp_chances < 6400) //9%확률로 대형 의료 가방
				{
					tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
					tmp_img_ind = 5; //생성할 아이템 image_index
					tmp_name = "Large Med Pack"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 3; //생성할 아이템 width
					tmp_height = 4; //생성할 아이템 height
				}
				else if (tmp_chances >= 6400 && tmp_chances < 6700) //3%확률로 전술용 가방
				{
					tmp_spr_ind = spr_backpack; //생성할 아이템 sprite_index
					tmp_img_ind = 6; //생성할 아이템 image_index
					tmp_name = "Tactical backpack"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 3; //생성할 아이템 width
					tmp_height = 4; //생성할 아이템 height
				}
				else if (tmp_chances >= 6700 && tmp_chances < 8500) //18%확률로 흰색 페인트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 17; //생성할 아이템 image_index
					tmp_name = "White Paint"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 8500 && tmp_chances < 9000) //5%확률로 붉은색 페인트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 18; //생성할 아이템 image_index
					tmp_name = "Red Paint"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
					tmp_height = 2; //생성할 아이템 height
				}
				else //10%확률로 비누
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 12; //생성할 아이템 image_index
					tmp_name = "Soap"; //생성할 아이템 name
					tmp_name_compressed = "Soap"; //생성할 아이템 name_compressed
				}
			break;
		
			case 24: //대형 나무 상자
				if (tmp_chances < 3000) //30%확률로 흰색 페인트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 17; //생성할 아이템 image_index
					tmp_name = "White Paint"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 3000 && tmp_chances < 3800) //8%확률로 붉은색 페인트
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 18; //생성할 아이템 image_index
					tmp_name = "Red Paint"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 3800 && tmp_chances < 4800) //10%확률로 금속 주괴
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 19; //생성할 아이템 image_index
					tmp_name = "Metal ingot"; //생성할 아이템 name
					tmp_name_compressed = "Metal"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 4800 && tmp_chances < 7300) //25%확률로 나무 막대
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 24; //생성할 아이템 image_index
					tmp_name = "Wooden Stick"; //생성할 아이템 name
					tmp_name_compressed = "Wood"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 7300 && tmp_chances < 8300) //10%확률로 금속 파이프
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 23; //생성할 아이템 image_index
					tmp_name = "Metal Pipe"; //생성할 아이템 name
					tmp_name_compressed = "Pipe"; //생성할 아이템 name_compressed
					tmp_height = 2; //생성할 아이템 height
				}
				else if (tmp_chances >= 8300 && tmp_chances < 9300) //10%확률로 원유
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 2; //생성할 아이템 image_index
					tmp_name = "Crude Oil"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
					tmp_height = 2; //생성할 아이템 height
				}
				else //7%확률로 정제된 기름
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Refined Oil"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
					tmp_height = 2; //생성할 아이템 height
				}
			break;
		
			case 26: //금고
				if (tmp_chances < 1000) //10%확률로 금속 주괴
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 19; //생성할 아이템 image_index
					tmp_name = "Metal ingot"; //생성할 아이템 name
					tmp_name_compressed = "Metal"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 1000 && tmp_chances < 3000) //20%확률로 고품질 금속 주괴
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 20; //생성할 아이템 image_index
					tmp_name = "High Quality Metal ingot"; //생성할 아이템 name
					tmp_name_compressed = "HQMetal"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 3000 && tmp_chances < 3700) //7%확률로 해골 동상
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 14; //생성할 아이템 image_index
					tmp_name = "Skull Statue"; //생성할 아이템 name
					tmp_name_compressed = "Statue"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 3700 && tmp_chances < 4400) //7%확률로 별 동상
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 15; //생성할 아이템 image_index
					tmp_name = "Star Statue"; //생성할 아이템 name
					tmp_name_compressed = "Statue"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 4400 && tmp_chances < 4900) //5%확률로 골드 바
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 21; //생성할 아이템 image_index
					tmp_name = "Golden Bar"; //생성할 아이템 name
					tmp_name_compressed = "Gold"; //생성할 아이템 name_compressed
					tmp_width = 2; //생성할 아이템 width
				}
				else if (tmp_chances >= 4900 && tmp_chances < 5900) //10%확률로 금속 십자가
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 26; //생성할 아이템 image_index
					tmp_name = "Metal Cross"; //생성할 아이템 name
					tmp_name_compressed = "Cross"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 5900 && tmp_chances < 6600) //7%확률로 골든 십자가
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 27; //생성할 아이템 image_index
					tmp_name = "Golden Cross"; //생성할 아이템 name
					tmp_name_compressed = "Cross"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 6600 && tmp_chances < 7300) //7%확률로 골든 해골
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 29; //생성할 아이템 image_index
					tmp_name = "Golden skull"; //생성할 아이템 name
					tmp_name_compressed = "Skull"; //생성할 아이템 name_compressed
				}
				else if (tmp_chances >= 7300 && tmp_chances < 9100) //18%확률로 골든 코인 (1~15개)
				{
					tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
					tmp_img_ind = 0; //생성할 아이템 image_index
					tmp_name = "Golden Coin"; //생성할 아이템 name
					tmp_name_compressed = "Coin"; //생성할 아이템 name_compressed
					tmp_stack = irandom_range(1,15); //생성할 아이템 stack
					tmp_max_stack = 99; //생성할 아이템 max_stack
				}
				else if (tmp_chances >= 9100 && tmp_chances < 9900) //8%확률로 SSD
				{
					tmp_spr_ind = spr_comp; //생성할 아이템 sprite_index
					tmp_img_ind = 9; //생성할 아이템 image_index
					tmp_name = "SSD"; //생성할 아이템 name
					tmp_name_compressed = tmp_name; //생성할 아이템 name_compressed
				}
				else //1%확률로 키카드
				{
					tmp_spr_ind = spr_stackables; //생성할 아이템 sprite_index
					tmp_img_ind = 3; //생성할 아이템 image_index
					tmp_name = "Keycard"; //생성할 아이템 name
					tmp_name_compressed = "Card"; //생성할 아이템 name_compressed
					tmp_stack = 1; //생성할 아이템 stack
					tmp_max_stack = 5; //생성할 아이템 max_stack
				}
			break;
		}
	
	
		var has_empty_pos = find_empty_pos(tmp_spr_ind,tmp_img_ind,tmp_width,tmp_height,tmp_stack,tmp_max_stack,tmp_name,tmp_ins); //상자 안의 빈자리 찾기
		if (has_empty_pos == true)
		{
			set_inv_variable(tmp_ins,global.inv_empty_xpos,global.inv_empty_ypos,tmp_spr_ind,tmp_img_ind,tmp_name,tmp_name_compressed,tmp_stack,tmp_max_stack,tmp_width,tmp_height,0,tmp_weight,0);
		}
	}*/
	
	return tmp_ins;
}