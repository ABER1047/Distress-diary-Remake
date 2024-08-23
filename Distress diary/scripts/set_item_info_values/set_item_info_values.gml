// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param spr_ind
///@param img_ind
///@param [returnOnly]
///@param [StarTag]
function set_item_info_values(argument0,argument1,argument2,argument3)
{
	var max_stack_num = -4;
	var tmp_name = "Unknown";
	var tmp_coin_value = 0;
	var tmp_short_name = "";
	var item_weight = 0;
	var item_width = 1;
	var item_height = 1;
	var item_name_translated = "";
	var item_value = 0;
	var item_desc = "";
	var item_effect_desc = "";
	if (argument0 == spr_backpack)
	{
		switch(argument1)
		{
			case 0:
				tmp_name = "Sling bag";
				item_weight = 1;
				item_width = 3;
				item_height = 4;
				item_name_translated = "슬링백";
				item_value = 10;
			break;
			
			case 1:
				tmp_name = "Med bag";
				item_weight = 1.6;
				item_width = 3;
				item_height = 4;
				item_name_translated = "의료 가방";
				item_value = 13;
			break;
			
			case 2:
				tmp_name = "Duffle bag";
				item_weight = 1.3;
				item_width = 4;
				item_height = 3;
				item_name_translated = "더플백";
				item_value = 11;
			break;
			
			case 3:
				tmp_name = "Backpack";
				item_weight = 1.6;
				item_width = 3;
				item_height = 4;
				item_name_translated = "백팩";
				item_value = 15;
			break;
			
			case 4:
				tmp_name = "Tourist backpack";
				item_weight = 2;
				item_width = 3;
				item_height = 4;
				item_name_translated = "여행자 백팩";
				item_value = 20;
			break;
			
			case 5:
				tmp_name = "Large Med Pack";
				item_weight = 1.7;
				item_width = 3;
				item_height = 4;
				item_name_translated = "대형 의료 가방";
				item_value = 15;
			break;
			
			case 6:
				tmp_name = "Tactical backpack";
				item_weight = 2;
				item_width = 3;
				item_height = 4;
				item_name_translated = "전술용 가방";
				item_value = 20;
			break;
		}
	}
	else if (argument0 == spr_comp)
	{
		switch(argument1)
		{
			case 0:
				tmp_name = "Bolt";
				item_weight = 0.1;
				item_name_translated = "볼트";
				item_value = 12;
			break;
			
			case 1:
				tmp_name = "Nut";
				item_weight = 0.1;
				item_name_translated = "너트";
				item_value = 11;
			break;
			
			case 2:
				tmp_name = "Crude Oil";
				item_weight = 15;
				item_width = 2;
				item_height = 3;
				item_name_translated = "원유";
				item_value = 40;
			break;
			
			case 3:
				tmp_name = "Refined Oil";
				item_weight = 15;
				item_width = 2;
				item_height = 3;
				item_name_translated = "정제된 기름";
				item_value = 53;
			break;
			
			case 4:
				tmp_name = "RAM";
				item_weight = 0.05;
				item_name_translated = "RAM";
				item_value = 13;
			break;
			
			case 5:
				tmp_name = "CPU";
				item_weight = 0.1;
				item_name_translated = "CPU";
				item_value = 15;
			break;
			
			case 6:
				tmp_short_name = "Board";
				tmp_name = "Circuit Board";
				item_weight = 0.1;
				item_name_translated = "회로기판";
				item_value = 14;
			break;
			
			case 7:
				tmp_name = "Wire";
				item_weight = 3;
				item_width = 2;
				item_name_translated = "전선";
				item_value = 13;
			break;
			
			case 8:
				tmp_name = "GPU";
				item_weight = 1.6;
				item_width = 2;
				item_name_translated = "GPU";
				item_value = 42;
			break;
			
			case 9:
				tmp_name = "SSD";
				item_weight = 0.3;
				item_name_translated = "SSD";
				item_value = 18;
			break;
			
			case 10:
				tmp_short_name = "Kit";
				tmp_name = "Sewing kit";
				item_weight = 0.05;
				item_name_translated = "바느질 키트";
				item_value = 2;
			break;
			
			case 11:
				tmp_name = "Cloth";
				item_weight = 0.1;
				item_width = 2;
				item_name_translated = "천 조각";
				item_value = 7;
			break;
			
			case 12:
				tmp_name = "Soap";
				item_weight = 0.1;
				item_name_translated = "비누";
				item_value = 5;
			break;
			
			case 13:
				tmp_short_name = "Plastic";
				tmp_name = "Plastic lump";
				item_weight = 0.5;
				item_height = 2;
				item_name_translated = "플라스틱 덩어리";
				item_value = 4;
			break;
			
			case 14:
				tmp_short_name = "Statue";
				tmp_name = "Skull Statue";
				item_weight = 1;
				item_width = 2;
				item_name_translated = "해골 동상";
				item_value = 13;
			break;
			
			case 15:
				tmp_short_name = "Statue";
				tmp_name = "Star Statue";
				item_weight = 1;
				item_width = 2;
				item_name_translated = "별 동상";
				item_value = 18;
			break;
			
			case 16:
				tmp_short_name = "Paint";
				tmp_name = "White Paint";
				item_weight = 10;
				item_width = 2;
				item_height = 2;
				item_name_translated = "흰색 페인트";
				item_value = 11;
			break;
			
			case 17:
				tmp_short_name = "Paint";
				tmp_name = "Red Paint";
				item_weight = 10;
				item_width = 2;
				item_height = 2;
				item_name_translated = "붉은색 페인트";
				item_value = 13;
			break;
			
			case 18:
				tmp_short_name = "Metal";
				tmp_name = "Metal ingot";
				item_weight = 5;
				item_width = 2;
				item_name_translated = "금속 주괴";
				item_value = 11;
			break;
			
			case 19:
				tmp_short_name = "HQM";
				tmp_name = "High Quality Metal ingot";
				item_weight = 5;
				item_width = 2;
				item_name_translated = "고품질 금속 주괴";
				item_value = 13;
			break;
			
			case 20:
				tmp_short_name = "Gold";
				tmp_name = "Golden Bar";
				item_weight = 3;
				item_width = 2;
				item_name_translated = "골드 바";
				item_value = 34;
			break;
			
			case 21:
				tmp_name = "Syringe";
				item_weight = 0.05;
				item_name_translated = "주사기";
				item_value = 9;
			break;
			
			case 22:
				tmp_short_name = "Pipe";
				tmp_name = "Metal Pipe";
				item_weight = 3;
				item_height = 2;
				item_name_translated = "금속 파이프";
				item_value = 9;
			break;
			
			case 23:
				tmp_short_name = "Wood";
				tmp_name = "Wooden Stick";
				item_weight = 0.7;
				item_height = 2;
				item_name_translated = "나무 막대";
				item_value = 3;
			break;
			
			case 24:
				tmp_short_name = "Bottle";
				tmp_name = "Empty Bottle";
				item_weight = 0.1;
				item_height = 2;
				item_name_translated = "빈 병";
				item_value = 3;
			break;
			
			case 25:
				tmp_name = "PSU";
				item_weight = 2;
				item_width = 2;
				item_height = 2;
				item_name_translated = "파워서플라이어";
				item_value = 11;
			break;
		}
	}
	else if (argument0 == spr_drink)
	{
		switch(argument1)
		{
			case 0:
				tmp_name = "Coke";
				item_weight = 0.58;
				item_name_translated = "콜라";
				item_value = 10;
			break;
			
			case 1:
				tmp_short_name = "Juice";
				tmp_name = "Grape Juice";
				item_weight = 0.58;
				item_name_translated = "포도 주스";
				item_value = 8;
			break;
			
			case 2:
				tmp_short_name = "Juice";
				tmp_name = "Orange Juice";
				item_weight = 0.58;
				item_name_translated = "오랜지 주스";
				item_value = 8;
			break;
			
			case 3:
				tmp_short_name = "Water";
				tmp_name = "Bottle of Water";
				item_weight = 0.61;
				item_height = 2;
				item_name_translated = "물병";
				item_value = 6;
			break;
			
			case 4:
				tmp_short_name = "Tea";
				tmp_name = "Green tea";
				item_weight = 0.58;
				item_name_translated = "그린티";
				item_value = 7;
			break;
			
			case 5:
				tmp_short_name = "Cond";
				tmp_name = "Condensed Milk";
				item_weight = 1;
				item_name_translated = "연유";
				item_value = 13;
			break;
			
			case 6:
				tmp_name = "Milk";
				item_weight = 0.9;
				item_height = 2;
				item_name_translated = "우유";
				item_value = 11;
			break;
			
			case 7:
				tmp_short_name = "Soda";
				tmp_name = "Orange Soda";
				item_weight = 0.58;
				item_name_translated = "오랜지 소다";
				item_value = 10;
			break;
			
			case 8:
				tmp_short_name = "Soda";
				tmp_name = "Grape Soda";
				item_weight = 0.58;
				item_name_translated = "포도 소다";
				item_value = 10;
			break;
			
			case 9:
				tmp_short_name = "EDrink";
				tmp_name = "Energy Drink";
				item_weight = 0.58;
				item_name_translated = "에너지 드링크";
				item_value = 11;
			break;
			
			case 10:
				tmp_short_name = "Honey";
				tmp_name = "Bottle of Honey";
				item_weight = 0.7;
				item_height = 2;
				item_name_translated = "꿀병";
				item_value = 13;
			break;
			
			case 11:
				tmp_short_name = "Liquid";
				tmp_name = "Suspicious liquid";
				item_weight = 0.61;
				item_height = 2;
				item_name_translated = "수상한 액체";
				item_value = 3;
			break;
			
			case 12:
				tmp_short_name = "Water";
				tmp_name = "Purified Water";
				item_weight = 0.4;
				item_name_translated = "정제된 물";
				item_value = 9;
			break;
			
			case 13:
				tmp_short_name = "Poison";
				tmp_name = "Poison";
				item_weight = 0.4;
				item_name_translated = "독극물";
				item_value = 3;
			break;
		}
	}
	else if (argument0 == spr_healings)
	{
		switch(argument1)
		{
			case 0:
				tmp_name = "Bandage";
				tmp_short_name = "Band"
				item_name_translated = "붕대";
				item_value = 4;
			break;
			
			case 1:
				tmp_short_name = "Splint";
				tmp_name = "Handmade Immobilizing Splint";
				item_name_translated = "수제 부목";
				item_value = 2;
			break;
			
			case 2:
				tmp_short_name = "Splint";
				tmp_name = "Immobilizing Splint";
				item_name_translated = "부목";
				item_value = 8;
			break;
			
			case 3:
				tmp_short_name = "Pills";
				tmp_name = "Anti-Radiation Pills";
				item_name_translated = "방사능 약";
				item_value = 9;
			break;
			
			case 4:
				tmp_short_name = "Pills";
				tmp_name = "Anti-Poisoning Pills";
				item_name_translated = "해독약";
				item_value = 9;
			break;
			
			case 5:
				tmp_short_name = "C2H6O";
				tmp_name = "Alcohol";
				item_name_translated = "알코올";
				item_value = 10;
			break;
			
			case 6:
				tmp_short_name = "Syringe";
				tmp_name = "Medical Syringe";
				item_name_translated = "의료 주사기";
				item_value = 11;
			break;
		}
	}
	else if (argument0 == spr_stackables)
	{
		switch(argument1)
		{
			case 0:
				tmp_short_name = "Coin";
				tmp_name = "Golden Coin";
				max_stack_num = 9999;
				item_weight = 0.002;
				item_name_translated = "골든 코인";
				item_desc = "황금으로 이루어진 코인";
				item_value = 1;
			break;
			
			case 1:
				tmp_name = "Bomb";
				max_stack_num = 4;
				item_weight = 1;
			break;
			
			case 2:
				tmp_short_name = "Clip";
				tmp_name = "Paper Clip";
				max_stack_num = 99;
				item_weight = 0.001;
				item_name_translated = "종이 클립";
				item_value = 1;
			break;
			
			case 3:
				tmp_short_name = "Card";
				tmp_name = "Keycard";
				max_stack_num = 5;
				item_weight = 0.001;
				item_name_translated = "키카드";
				item_value = 35;
			break;
			
			case 4:
				tmp_name = "Key";
				max_stack_num = 5;
				item_weight = 0.002;
				item_name_translated = "열쇠";
				item_value = 3;
			break;
			
			case 5:
				tmp_short_name = "Bomb";
				tmp_name = "Cherry Bomb";
				max_stack_num = 8;
				item_weight = 0.45;
			break;
		}
	}
	else if (argument0 == spr_foods)
	{
		switch(argument1)
		{
			case 0:
				tmp_short_name = "Energy";
				tmp_name = "Energy bar";
				item_weight = 0.2;
				item_width = 2;
				item_name_translated = "에너지바";
				item_value = 8;
			break;
			
			case 1:
				tmp_short_name = "Choco";
				tmp_name = "Chocolate Bar";
				item_weight = 0.2;
				item_height = 2;
				item_name_translated = "초콜릿 바";
				item_value = 8;
			break;
			
			case 2:
				tmp_name = "Chips";
				item_weight = 0.007;
				item_name_translated = "감자칩";
				item_value = 6;
			break;
			
			case 3:
				tmp_short_name = "Meat";
				tmp_name = "Sausage";
				item_weight = 0.25;
				item_height = 2;
				item_name_translated = "소세지";
				item_value = 7;
			break;
			
			case 4:
				tmp_short_name = "Fish";
				tmp_name = "Can of Fish";
				item_weight = 0.58;
				item_name_translated = "생선 통조림";
				item_value = 10;
			break;
			
			case 5:
				tmp_short_name = "Beef";
				tmp_name = "Can of Beef stew";
				item_weight = 0.58;
				item_name_translated = "비프 스튜 통조림";
				item_value = 11;
			break;
			
			case 6:
				tmp_short_name = "Sugar";
				tmp_name = "Pack of Sugar";
				item_weight = 0.2;
				item_name_translated = "설탕팩";
				item_value = 16;
			break;
		}
	}
	else if (argument0 == spr_weapon)
	{
		switch(argument1)
		{
			case 0:
				tmp_short_name = "Sword";
				tmp_name = "Copper Sword";
				item_weight = 2.3;
				item_height = 3;
				item_name_translated = "구리 검";
				item_value = 2;
			break;
			
			case 1:
				tmp_short_name = "Dagger";
				tmp_name = "Copper Dagger";
				item_weight = 1.2;
				item_height = 2;
				item_name_translated = "구리 단검";
				item_value = 2;
			break;
			
			case 2:
				tmp_short_name = "Hammer";
				tmp_name = "Copper Hammer";
				item_weight = 4;
				item_width = 2;
				item_height = 3;
				item_name_translated = "구리 망치";
				item_value = 2;
			break;
			
			case 3:
				tmp_short_name = "Sword";
				tmp_name = "Iron Sword";
				item_weight = 2.3;
				item_height = 3;
				item_name_translated = "철 검";
				item_value = 2;
			break;
			
			case 4:
				tmp_short_name = "Dagger";
				tmp_name = "Iron Dagger";
				item_weight = 1.2;
				item_height = 2;
				item_name_translated = "철 단검";
				item_value = 2;
			break;
			
			case 5:
				tmp_short_name = "Hammer";
				tmp_name = "Iron Hammer";
				item_weight = 4;
				item_width = 2;
				item_height = 3;
				item_name_translated = "철 망치";
				item_value = 2;
			break;
			
			case 6:
				tmp_short_name = "Knife";
				tmp_name = "Poisoned Throwing Knife";
				item_weight = 0.2;
				max_stack_num = 10;
				item_name_translated = "독 발린 투척용 단검";
				item_value = 1;
			break;
			
			case 7:
				tmp_short_name = "Knife";
				tmp_name = "Throwing Knife";
				item_weight = 0.2;
				max_stack_num = 10;
				item_name_translated = "투척용 단검";
				item_value = 1;
			break;
			
			case 8:
				tmp_short_name = "Sword";
				tmp_name = "High Quality Metal Sword";
				item_weight = 2.3;
				item_height = 3;
				item_name_translated = "고품질 철 검";
				item_value = 3;
			break;
			
			case 9:
				tmp_short_name = "Dagger";
				tmp_name = "High Quality Metal Dagger";
				item_weight = 1.2;
				item_height = 2;
				item_name_translated = "고품질 철 단검";
				item_value = 3;
			break;
			
			case 10:
				tmp_short_name = "Hammer";
				tmp_name = "High Quality Metal Hammer";
				item_weight = 4;
				item_width = 2;
				item_height = 3;
				item_name_translated = "고품질 철 망치";
				item_value = 3;
			break;
			
			case 11:
				tmp_short_name = "Sword";
				tmp_name = "Slime Sword";
				item_weight = 1.3;
				item_height = 3;
				item_name_translated = "슬라임 검";
				item_value = 4;
			break;
			
			case 12:
				tmp_short_name = "Dagger";
				tmp_name = "Slime Dagger";
				item_weight = 0.2;
				item_height = 2;
				item_name_translated = "슬라임 단검";
				item_value = 4;
			break;
			
			case 13:
				tmp_short_name = "Hammer";
				tmp_name = "Slime Hammer";
				item_weight = 2;
				item_width = 2;
				item_height = 3;
				item_name_translated = "슬라임 망치";
				item_value = 4;
			break;
			
			case 14:
				tmp_short_name = "Sword";
				tmp_name = "Bone Sword";
				item_weight = 1.3;
				item_height = 3;
				item_name_translated = "뼈 칼";
				item_value = 4;
			break;
			
			case 15:
				tmp_short_name = "Dagger";
				tmp_name = "Bone Dagger";
				item_weight = 0.2;
				item_height = 2;
				item_name_translated = "뼈 단검";
				item_value = 4;
			break;
		}
	}
	else if (argument0 == spr_pickaxe)
	{
		switch(argument1)
		{
			case 0:
				tmp_short_name = "Pickaxe";
				tmp_name = "Copper Pickaxe";
				item_weight = 2.3;
				item_height = 2;
				item_name_translated = "구리 곡괭이";
				item_value = 2;
			break;
			
			case 1:
				tmp_short_name = "Pickaxe";
				tmp_name = "Iron Pickaxe";
				item_weight = 1.2;
				item_height = 2;
				item_name_translated = "철 곡괭이";
				item_value = 2;
			break;
			
			case 2:
				tmp_short_name = "Pickaxe";
				tmp_name = "Slime Pickaxe";
				item_weight = 2;
				item_height = 2;
				item_name_translated = "슬라임 곡괭이";
				item_value = 3;
			break;
			
			case 3:
				tmp_short_name = "Pickaxe";
				tmp_name = "Bone Pickaxe";
				item_weight = 0.8;
				item_height = 2;
				item_name_translated = "뼈 곡괭이";
				item_value = 3;
			break;
		}
	}
	else if (argument0 == spr_equipments)
	{
		switch(argument1)
		{
			case 0:
				tmp_short_name = "Cards";
				tmp_name = "Pack of Cards";
				item_weight = 0.1;
				item_name_translated = "카드팩";
				item_value = 11;
			break;
			
			case 1:
				tmp_short_name = "Cross";
				tmp_name = "Metal Cross";
				item_weight = 0.1;
				item_name_translated = "금속 십자가";
				item_value = 8;
				
			break;
			
			case 2:
				tmp_short_name = "Cross";
				tmp_name = "Golden Cross";
				item_weight = 0.1;
				item_name_translated = "골든 십자가";
				item_value = 16;
			break;
			
			case 3:
				tmp_short_name = "Skull";
				tmp_name = "Golden skull";
				item_weight = 0.4;
				item_name_translated = "골든 해골";
				item_value = 16;
			break;
			
			case 4:
				tmp_short_name = "Skull";
				tmp_name = "Metal skull";
				item_weight = 0.4;
			break;
			
			case 5:
				tmp_short_name = "Ring";
				tmp_name = "Golden Ruby ring";
				item_weight = 0.002;
				item_name_translated = "골든 루비 링";
				item_value = 20;
			break;
			
			case 6:
				tmp_short_name = "Ring";
				tmp_name = "Metal Ruby ring";
				item_weight = 0.002;
			break;
			
			case 7:
				tmp_short_name = "Ring";
				tmp_name = "Golden Lapis ring";
				item_weight = 0.002;
			break;
			
			case 8:
				tmp_short_name = "Ring";
				tmp_name = "Metal Lapis ring";
				item_weight = 0.002;
			break;
			
			case 9:
				tmp_short_name = "Ring";
				tmp_name = "Golden ring";
				item_weight = 0.002;
			break;
			
			case 10:
				tmp_short_name = "Ring";
				tmp_name = "Metal ring";
				item_weight = 0.002;
			break;
			
			case 11:
				tmp_short_name = "Ring";
				tmp_name = "Frozen ring";
				item_weight = 0.002;
			break;
			
			case 12:
				tmp_short_name = "Ring";
				tmp_name = "Volcano ring";
				item_weight = 0.002;
			break;
			
			case 13:
				tmp_short_name = "Ring";
				tmp_name = "Corruption ring";
				item_weight = 0.002;
			break;
			
			case 14:
				tmp_short_name = "Ring";
				tmp_name = "Aqua ring";
				item_weight = 0.002;
			break;
			
			case 15:
				tmp_short_name = "Ring";
				tmp_name = "Aqua ring";
				item_weight = 0.002;
			break;
			
			case 16:
				tmp_short_name = "Gloves";
				tmp_name = "Work Gloves";
				item_weight = 0.002;
			break;
			
			case 17:
				tmp_short_name = "Clover";
				tmp_name = "Clover";
				item_weight = 0.002;
			break;
			
			case 18:
				tmp_short_name = "Holy water";
				tmp_name = "Holy water";
				item_weight = 0.002;
			break;
			
			case 19:
				tmp_short_name = "Crystal ball";
				tmp_name = "Crystal ball";
				item_weight = 0.002;
			break;
		}
	}
	
	
	//무기-장비류 아이템의 경우, 아이템 효과 설명 추가
	var tmp_str = string_split(set_status_by_weapon(argument0,argument1,true),",");
	if (tmp_str[1] != 0 && tmp_str[0] != "")
	{
		if (tmp_str[0] >= 0)
		{
			if (tmp_str[5] == 3)
			{
				item_effect_desc = string(tmp_str[0])+"-"+string(real(tmp_str[0])*3)+" 데미지\n";
			}
			else if (tmp_str[5] == 0)
			{
				item_effect_desc = string(tmp_str[0])+"-"+string(real(tmp_str[0])*2)+" 데미지\n";
			}
			else
			{
				item_effect_desc = string(tmp_str[0])+" 데미지\n";
			}
		}
		else
		{
			if (argument3 == undefined || argument3 == 0)
			{
				item_effect_desc = string(abs(real(tmp_str[0])))+" 곡괭이 파워\n";
			}
			else
			{
				item_effect_desc = string(abs(real(tmp_str[0])))+"(+"+string(argument3*1.5)+") 곡괭이 파워\n";
			}
		}
		
		if (tmp_str[2] != 0)
		{
			if (argument3 == undefined || argument3 == 0)
			{
				item_effect_desc = string(item_effect_desc)+string(tmp_str[2])+"% 크리티컬 찬스\n";
			}
			else
			{
				var tmp_additional = 5+argument3*2;
				item_effect_desc = string(item_effect_desc)+string(tmp_str[2])+"% (+"+string(tmp_additional)+"%) 크리티컬 찬스\n";
			}
		}
		
		if (tmp_str[3] != 0)
		{
			item_effect_desc = string(item_effect_desc)+string(tmp_str[3])+" 넉백\n";
		}
		
		if (tmp_str[6] != 0)
		{
			item_effect_desc = string(item_effect_desc)+string(tmp_str[6])+"% 정확도\n";
		}
	}
	
	if (argument2 == undefined || argument2 == false)
	{
		global.short_name = (tmp_short_name == "") ? tmp_name : tmp_short_name;
		global.item_max_stack_num = max_stack_num;
		global.item_weight = item_weight;
		global.item_width = item_width;
		global.item_height = item_height;
		global.item_translated_name = item_name_translated;
		global.item_value = item_value;
		global.item_description = item_desc;
		global.item_ef_desc = item_effect_desc;
	
		return tmp_name;
	}
	else
	{
		return [ tmp_name, tmp_short_name, max_stack_num, item_weight, item_width, item_height, item_name_translated, item_value, item_desc, item_effect_desc ];
	}
}