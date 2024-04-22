// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_invite_code(argument0)
{
	var tmp_alphabet_arr1 = [ "a","c","e","g","i","k","m","o","q","s","u","w","y" ];
	var tmp_alphabet_arr2 = [ "b","d","f","h","j","l","n","p","r","t","v","x","z" ];
	var tmp_result = "";
	for(var i = 0; i < string_length(argument0); i++)
	{
		var tmp_char = string_char_at(argument0,i+1);
		if (tmp_char == ".")
		{
			var rd_alphabet = tmp_alphabet_arr1[irandom_range(0,12)];
			tmp_result = tmp_result + ((percentage_k(50)) ? string_upper(rd_alphabet) : rd_alphabet);
		}
		else
		{
			var tmp_margin = current_day+current_hour*7-floor(current_minute/15);
			var tmp_num = real(tmp_char)-(tmp_margin);
			while(true)
			{
				if (tmp_num < 0)
				{
					tmp_num += 9;
				}
				else if (tmp_num > 9)
				{
					tmp_num -= 9;
				}
				else
				{
					break;
				}
			}
			tmp_result = tmp_result+string(tmp_num);
		}
		
		if (percentage_k(20))
		{
			var rd_alphabet = tmp_alphabet_arr2[irandom_range(0,12)];
			tmp_result = tmp_result + ((percentage_k(50)) ? string_upper(rd_alphabet) : rd_alphabet);
		}
	}

	show_message_log("초대 코드 생성 및 복사 완료!");
	clipboard_set_text(tmp_result);
	return tmp_result;
}