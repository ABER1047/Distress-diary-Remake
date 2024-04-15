// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information



///@param item_name
///@param obj_inv_item
function set_item_value(argument0,argument1)
{
	with(argument1)
	{
		switch(argument0)
		{
			//음식류
			case "Coke":
				item_name_translated = "콜라";
				return 10;
			break;
		
			case "Grape Juice":
				item_name_translated = "포도 주스";
				return 8;
			break;
			
			case "Orange Juice":
				item_name_translated = "오랜지 주스";
				return 8;
			break;
		
			case "Bottle of Water":
				item_name_translated = "물병";
				return 6;
			break;
		
			case "Green tea":
				item_name_translated = "그린티";
				return 7;
			break;
		
			case "Condensed Milk":
				item_name_translated = "연유";
				return 13;
			break;
		
			case "Milk":
				item_name_translated = "우유";
				return 11;
			break;
		
			case "Orange Soda":
				item_name_translated = "오랜지 소다";
				return 10;
			break;
		
			case "Grape Soda":
				item_name_translated = "포도 소다";
				return 10;
			break;
		
			case "Energy Drink":
				item_name_translated = "에너지 드링크";
				return 11;
			break;
		
			case "Bottle of Honey":
				item_name_translated = "꿀병";
				return 13;
			break;
		
			case "Suspicious liquid":
				item_name_translated = "수상한 액체";
				return 3;
			break;
		
			case "Purified Water":
				item_name_translated = "정제된 물";
				return 9;
			break;
		
			case "Energy Bar":
				item_name_translated = "에너지바";
				return 8;
			break;
			
			case "Chocolate bar":
				item_name_translated = "초콜릿 바";
				return 8;
			break;
		
			case "Chips":
				item_name_translated = "감자칩";
				return 6;
			break;
		
			case "Sausage":
				item_name_translated = "소세지";
				return 7;
			break;
		
			case "Can of Fish":
				item_name_translated = "생선 통조림";
				return 10;
			break;
		
			case "Can of Beef stew":
				item_name_translated = "비프 스튜 통조림";
				return 11;
			break;
		
			case "Pack of Sugar":
				item_name_translated = "설탕팩";
				return 16;
			break;
		
		
			//컴포넌트류
			case "Bolt":
				item_name_translated = "볼트";
				return 12;
			break;
		
			case "Nut":
				item_name_translated = "너트";
				return 11;
			break;
		
			case "Crude Oil":
				item_name_translated = "원유";
				return 40;
			break;
		
			case "Refined Oil":
				item_name_translated = "정제된 기름";
				return 53;
			break;
		
			case "RAM":
				item_name_translated = "RAM";
				return 13;
			break;
		
			case "CPU":
				item_name_translated = "CPU";
				return 15;
			break;
		
			case "Circuit Board":
				item_name_translated = "회로기판";
				return 14;
			break;
		
			case "Wire":
				item_name_translated = "전선";
				return 13;
			break;
		
			case "GPU":
				item_name_translated = "GPU";
				return 42;
			break;
		
			case "SSD":
				item_name_translated = "SSD";
				return 18;
			break;
		
			case "Sewing kit":
				item_name_translated = "바느질 키트";
				return 2;
			break;
		
			case "Cloth":
				item_name_translated = "천 조각";
				return 7;
			break;
		
			case "Soap":
				item_name_translated = "비누";
				return 5;
			break;
		
			case "Plastic lump":
				item_name_translated = "플라스틱 덩어리";
				return 4;
			break;
		
			case "White Paint":
				item_name_translated = "흰색 페인트";
				return 11;
			break;
		
			case "Red Paint":
				item_name_translated = "붉은색 페인트";
				return 13;
			break;
		
			case "Metal ingot":
				item_name_translated = "금속 주괴";
				return 11;
			break;
		
			case "High Quality Metal ingot":
				item_name_translated = "고품질 금속 주괴";
				return 13;
			break;
		
			case "Syringe":
				item_name_translated = "주사기";
				return 9;
			break;
		
			case "Metal Pipe":
				item_name_translated = "금속 파이프";
				return 9;
			break;
		
			case "Wooden Stick":
				item_name_translated = "나무 막대";
				return 3;
			break;
		
			case "Empty Bottle":
				item_name_translated = "빈 병";
				return 3;
			break;
		
			case "PSU":
				item_name_translated = "파워서플라이어";
				return 11;
			break;
		
		
			//귀중품류
			case "Skull Statue":
				item_name_translated = "해골 동상";
				return 13;
			break;
		
			case "Star Statue":
				item_name_translated = "별 동상";
				return 18;
			break;
		
			case "Pack of Cards":
				item_name_translated = "카드팩";
				return 11;
			break;
		
			case "Golden Bar":
				item_name_translated = "골드 바";
				return 34;
			break;
		
			case "Metal Cross":
				item_name_translated = "금속 십자가";
				return 8;
			break;
		
			case "Golden Cross":
				item_name_translated = "골든 십자가";
				return 16;
			break;
		
			case "Golden skull":
				item_name_translated = "골든 해골";
				return 16;
			break;
		
			case "Golden Coin":
				item_name_translated = "골든 코인";
				return 1;
			break;
			
			case "Golden ring":
				item_name_translated = "골든 링";
				return 20;
			break;
		
		
			//열쇠류
			case "Paper Clip":
				item_name_translated = "종이 클립";
				return 1;
			break;
		
			case "Keycard":
				item_name_translated = "키카드";
				return 35;
			break;
		
			case "Key":
				item_name_translated = "열쇠";
				return 3;
			break;
		
		
			//힐템류
			case "Bandage":
				item_name_translated = "붕대";
				return 4;
			break;
		
			case "Handmade Immobilizing Splint":
				item_name_translated = "수제 부목";
				return 2;
			break;
		
			case "Immobilizing Splint":
				item_name_translated = "부목";
				return 8;
			break;
		
			case "Anti-Radiation Pills":
				item_name_translated = "방사능 약";
				return 9;
			break;
		
			case "Anti-Poisoning Pills":
				item_name_translated = "해독약";
				return 9;
			break;
		
			case "Alcohol":
				item_name_translated = "알코올";
				return 10;
			break;
		
			case "Medical Syringe":
				item_name_translated = "의료 주사기";
				return 11;
			break;
		
		
			//가방류
			case "Sling bag":
				item_name_translated = "슬링백";
				return 10;
			break;
		
			case "Med bag":
				item_name_translated = "의료 가방";
				return 13;
			break;
		
			case "Duffle bag":
				item_name_translated = "더플백";
				return 11;
			break;
		
			case "Backpack":
				item_name_translated = "백팩";
				return 15;
			break;
		
			case "Tourist backpack":
				item_name_translated = "여행자 백팩";
				return 20;
			break;
		
			case "Large Med Pack":
				item_name_translated = "대형 의료 가방";
				return 15;
			break;
		
			case "Tactical backpack":
				item_name_translated = "전술용 가방";
				return 20;
			break;
		}
	}
}