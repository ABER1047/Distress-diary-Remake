// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param spr_ind
///@param img_ind
function set_item_info_values(argument0,argument1)
{
	var max_stack_num = -4;
	var tmp_name = "Unknown";
	var tmp_coin_value = 0;
	var tmp_short_name = "";
	var item_weight = 0;
	var item_width = 1;
	var item_height = 1;
	if (argument0 == spr_backpack)
	{
		switch(argument1)
		{
			case 0:
				tmp_name = "Sling bag";
				item_weight = 1;
				item_width = 3;
				item_height = 4;
			break;
			
			case 1:
				tmp_name = "Med bag";
				item_weight = 1.6;
				item_width = 3;
				item_height = 4;
			break;
			
			case 2:
				tmp_name = "Duffle bag";
				item_weight = 1.3;
				item_width = 4;
				item_height = 3;
			break;
			
			case 3:
				tmp_name = "Backpack";
				item_weight = 1.6;
				item_width = 3;
				item_height = 4;
			break;
			
			case 4:
				tmp_name = "Tourist backpack";
				item_weight = 2;
				item_width = 3;
				item_height = 4;
			break;
			
			case 5:
				tmp_name = "Large Med Pack";
				item_weight = 1.7;
				item_width = 3;
				item_height = 4;
			break;
			
			case 6:
				tmp_name = "Tactical backpack";
				item_weight = 2;
				item_width = 3;
				item_height = 4;
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
			break;
			
			case 1:
				tmp_name = "Nut";
				item_weight = 0.1;
			break;
			
			case 2:
				tmp_name = "Crude Oil";
				item_weight = 15;
				item_width = 2;
				item_height = 3;
			break;
			
			case 3:
				tmp_name = "Refined Oil";
				item_weight = 15;
				item_width = 2;
				item_height = 3;
			break;
			
			case 4:
				tmp_name = "RAM";
				item_weight = 0.05;
			break;
			
			case 5:
				tmp_name = "CPU";
				item_weight = 0.1;
			break;
			
			case 6:
				tmp_short_name = "Board";
				tmp_name = "Circuit Board";
				item_weight = 0.1;
			break;
			
			case 7:
				tmp_name = "Wire";
				item_weight = 3;
				item_width = 2;
			break;
			
			case 8:
				tmp_name = "GPU";
				item_weight = 1.6;
				item_width = 2;
			break;
			
			case 9:
				tmp_name = "SSD";
				item_weight = 0.3;
			break;
			
			case 10:
				tmp_short_name = "Kit";
				tmp_name = "Sewing kit";
				item_weight = 0.05;
			break;
			
			case 11:
				tmp_name = "Cloth";
				item_weight = 0.1;
				item_width = 2;
			break;
			
			case 12:
				tmp_name = "Soap";
				item_weight = 0.1;
			break;
			
			case 13:
				tmp_short_name = "Plastic";
				tmp_name = "Plastic lump";
				item_weight = 0.5;
				item_height = 2;
			break;
			
			case 14:
				tmp_short_name = "Statue";
				tmp_name = "Skull Statue";
				item_weight = 1;
				item_width = 2;
			break;
			
			case 15:
				tmp_short_name = "Statue";
				tmp_name = "Star Statue";
				item_weight = 1;
				item_width = 2;
			break;
			
			case 16:
				tmp_short_name = "Paint";
				tmp_name = "White Paint";
				item_weight = 10;
				item_width = 2;
				item_height = 2;
			break;
			
			case 17:
				tmp_short_name = "Paint";
				tmp_name = "Red Paint";
				item_weight = 10;
				item_width = 2;
				item_height = 2;
			break;
			
			case 18:
				tmp_short_name = "Metal";
				tmp_name = "Metal ingot";
				item_weight = 5;
				item_width = 2;
			break;
			
			case 19:
				tmp_short_name = "HQM";
				tmp_name = "High Quality Metal ingot";
				item_weight = 5;
				item_width = 2;
			break;
			
			case 20:
				tmp_short_name = "Gold";
				tmp_name = "Golden Bar";
				item_weight = 3;
				item_width = 2;
			break;
			
			case 21:
				tmp_name = "Syringe";
				item_weight = 0.05;
			break;
			
			case 22:
				tmp_short_name = "Pipe";
				tmp_name = "Metal Pipe";
				item_weight = 3;
				item_height = 2;
			break;
			
			case 23:
				tmp_short_name = "Wood";
				tmp_name = "Wooden Stick";
				item_weight = 0.7;
				item_height = 2;
			break;
			
			case 24:
				tmp_short_name = "Bottle";
				tmp_name = "Empty Bottle";
				item_weight = 0.1;
				item_height = 2;
			break;
			
			case 25:
				tmp_name = "PSU";
				item_weight = 2;
				item_width = 2;
				item_height = 2;
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
			break;
			
			case 1:
				tmp_short_name = "Juice";
				tmp_name = "Grape Juice";
				item_weight = 0.58;
			break;
			
			case 2:
				tmp_short_name = "Juice";
				tmp_name = "Orange Juice";
				item_weight = 0.58;
			break;
			
			case 3:
				tmp_short_name = "Water";
				tmp_name = "Bottle of Water";
				item_weight = 0.61;
				item_height = 2;
			break;
			
			case 4:
				tmp_short_name = "Tea";
				tmp_name = "Green tea";
				item_weight = 0.58;
			break;
			
			case 5:
				tmp_short_name = "Cond";
				tmp_name = "Condensed Milk";
				item_weight = 1;
			break;
			
			case 6:
				tmp_name = "Milk";
				item_weight = 0.9;
				item_height = 2;
			break;
			
			case 7:
				tmp_short_name = "Soda";
				tmp_name = "Orange Soda";
				item_weight = 0.58;
			break;
			
			case 8:
				tmp_short_name = "Soda";
				tmp_name = "Grape Soda";
				item_weight = 0.58;
			break;
			
			case 9:
				tmp_short_name = "EDrink";
				tmp_name = "Energy Drink";
				item_weight = 0.58;
			break;
			
			case 10:
				tmp_short_name = "Honey";
				tmp_name = "Bottle of Honey";
				item_weight = 0.7;
				item_height = 2;
			break;
			
			case 11:
				tmp_short_name = "Liquid";
				tmp_name = "Suspicious liquid";
				item_weight = 0.61;
				item_height = 2;
			break;
			
			case 12:
				tmp_short_name = "Water";
				tmp_name = "Purified Water";
				item_weight = 0.4;
			break;
			
			case 13:
				tmp_short_name = "Poison";
				tmp_name = "Poison";
				item_weight = 0.4;
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
			break;
			
			case 1:
				tmp_short_name = "Splint";
				tmp_name = "Handmade Immobilizing Splint";
			break;
			
			case 2:
				tmp_short_name = "Splint";
				tmp_name = "Immobilizing Splint";
			break;
			
			case 3:
				tmp_short_name = "Pills";
				tmp_name = "Anti-Radiation Pills";
			break;
			
			case 4:
				tmp_short_name = "Pills";
				tmp_name = "Anti-Poisoning Pills";
			break;
			
			case 5:
				tmp_short_name = "C2H6O";
				tmp_name = "Alcohol";
			break;
			
			case 6:
				tmp_short_name = "Syringe";
				tmp_name = "Medical Syringe";
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
			break;
			
			case 3:
				tmp_short_name = "Card";
				tmp_name = "Keycard";
				max_stack_num = 5;
				item_weight = 0.001;
			break;
			
			case 4:
				tmp_name = "Key";
				max_stack_num = 5;
				item_weight = 0.002;
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
				tmp_name = "Energy Bar";
				item_weight = 0.2;
				item_height = 2;
			break;
			
			case 1:
				tmp_short_name = "Choco";
				tmp_name = "Chocolate Bar";
				item_weight = 0.2;
				item_height = 2;
			break;
			
			case 2:
				tmp_name = "Chips";
				item_weight = 0.007;
			break;
			
			case 3:
				tmp_short_name = "Meat";
				tmp_name = "Sausage";
				item_weight = 0.25;
				item_height = 2;
			break;
			
			case 4:
				tmp_short_name = "Fish";
				tmp_name = "Can of Fish";
				item_weight = 0.58;
			break;
			
			case 5:
				tmp_short_name = "Beef";
				tmp_name = "Can of Beef stew";
				item_weight = 0.58;
			break;
			
			case 6:
				tmp_short_name = "Sugar";
				tmp_name = "Pack of Sugar";
				item_weight = 0.2;
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
				item_height = 2;
			break;
			
			case 1:
				tmp_short_name = "Dagger";
				tmp_name = "Dagger";
				item_weight = 1.2;
			break;
			
			case 2:
				tmp_short_name = "Sword";
				tmp_name = "Golden Sword";
				item_weight = 2;
				item_height = 2;
			break;
			
			case 3:
				tmp_short_name = "Knife";
				tmp_name = "Throwing Knife";
				item_weight = 0.8;
				max_stack_num = 8;
			break;
			
			case 4:
				tmp_short_name = "Knife";
				tmp_name = "Poisoned Throwing Knife";
				item_weight = 0.8;
				max_stack_num = 8;
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
			break;
			
			case 1:
				tmp_short_name = "Cross";
				tmp_name = "Metal Cross";
				item_weight = 0.1;
				
			break;
			
			case 2:
				tmp_short_name = "Cross";
				tmp_name = "Golden Cross";
				item_weight = 0.1;
			break;
			
			case 3:
				tmp_short_name = "Skull";
				tmp_name = "Golden skull";
				item_weight = 0.4;
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
	
	
	global.short_name = (tmp_short_name == "") ? tmp_name : tmp_short_name;
	global.item_max_stack_num = max_stack_num;
	global.item_weight = item_weight;
	global.item_width = item_width;
	global.item_height = item_height;
	return tmp_name;
}