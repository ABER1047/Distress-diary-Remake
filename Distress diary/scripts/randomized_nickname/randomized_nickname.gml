// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param length
function randomized_nickname(argument0)
{
	var _random_alphabet_fir = [ "a","e","i","o","u" ];
	var _random_alphabet_sec = [ "b","c","d","f","g","h","j","k","l","m","n","p","r","s","t","v","w","x","y","z" ];
	var tmp_str = "";
	
	var start_letter = choose(0,1);
	var random_length = ceil(argument0*0.5);
	for(var i = 1; i <= random_length; i++)
	{
		if (start_letter == 1)
		{
			repeat(1+percentage_k(30))
			{
				var rd_ind = irandom_range(0,array_length(_random_alphabet_fir)-1);
				var tmp_char = _random_alphabet_fir[rd_ind];
				tmp_str = (i == 1) ? string_upper(tmp_char) : tmp_str + tmp_char;
			}
			
			if ((i == random_length && percentage_k((string_length(tmp_str) == 1) ? 100 : 50)) || i != random_length)
			{
				var rd_ind, tmp_char;
				
				while(true)
				{
					rd_ind = irandom_range(0,array_length(_random_alphabet_sec)-1);
					tmp_char = _random_alphabet_sec[rd_ind];
					if (i == random_length && tmp_char != "p" && tmp_char != "j" && tmp_char != "z" && tmp_char != "w")
					{
						break;
					}
					else if (i > 1 && i < random_length && tmp_char != "j" && tmp_char != "w" && tmp_char != "x" && tmp_char != "v")
					{
						break;
					}
					else if (i == 1 && tmp_char != "x" && tmp_char != "w" && tmp_char != "v")
					{
						break;
					}
				}
				
				tmp_str = tmp_str + tmp_char;
			}
		}
		else
		{
			var rd_ind, tmp_char;
				
			while(true)
			{
				rd_ind = irandom_range(0,array_length(_random_alphabet_sec)-1);
				tmp_char = _random_alphabet_sec[rd_ind];
				if (i == random_length && tmp_char != "p" && tmp_char != "j" && tmp_char != "z" && tmp_char != "w")
				{
					break;
				}
				else if (i > 1 && i < random_length && tmp_char != "j" && tmp_char != "w" && tmp_char != "x" && tmp_char != "v")
				{
					break;
				}
				else if (i == 1 && tmp_char != "x" && tmp_char != "w" && tmp_char != "v")
				{
					break;
				}
			}
				

			tmp_str = (i == 1) ? string_upper(tmp_char) : tmp_str + tmp_char;
			
			if ((i == random_length && percentage_k((string_length(tmp_str) == 1) ? 100 : 50)) || i != random_length)
			{
				repeat(1+percentage_k(30))
				{
					var rd_ind = irandom_range(0,array_length(_random_alphabet_fir)-1);
					var tmp_char = _random_alphabet_fir[rd_ind];
					tmp_str = (i == 1) ? string_upper(tmp_char) : tmp_str + tmp_char;
				}
			}
		}
	}
	
	

	return (string_length(tmp_str) >= argument0) ? tmp_str : randomized_nickname(argument0);
}