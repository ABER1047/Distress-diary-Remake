// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function decode_invite_code(argument0)
{
	var tmp_alphabet_arr1 = [ "a","c","e","g","i","k","m","o","q","s","u","w","y" ];
	var tmp_alphabet_arr2 = [ "b","d","f","h","j","l","n","p","r","t","v","x","z" ];
	var tmp_result = "";
	
	for(var i = 0; i < string_length(argument0); i++)
	{
		var tmp_char = string_char_at(argument0,i+1);
		for(var ii = 0; ii < array_length(tmp_alphabet_arr1); ii++)
		{
			if (tmp_char == tmp_alphabet_arr1[ii] || tmp_char == string_upper(tmp_alphabet_arr1[ii]))
			{
				tmp_result = tmp_result+".";
				break;
			}
			else if (tmp_char == string_digits(tmp_char))
			{
				var tmp_margin = current_day+current_hour*7-floor(current_minute/5);
				var tmp_num = real(tmp_char)+(tmp_margin);
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
				break;
			}
		}
	}
	
	return tmp_result;
}