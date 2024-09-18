// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@param hexColor
function hex_to_color(argument0)
{
	var tmp_hex = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" ];
	var tmp_str = string_replace(string_trim(argument0),"#","");
	var tmp_val = array_create(6,0);
	for(var i = 0; i < 6; i++)
	{
		for(var ii = 0; ii < 16; ii++)
		{
			var tmp_char = string_char_at(tmp_str,1+i);
			if (tmp_char == tmp_hex[ii])
			{
				tmp_val[i] = ii;
				break;
			}
		}
	}
	
	return make_color_rgb(tmp_val[0]*16+tmp_val[1],tmp_val[2]*16+tmp_val[3],+tmp_val[4]*16+tmp_val[5]);
}