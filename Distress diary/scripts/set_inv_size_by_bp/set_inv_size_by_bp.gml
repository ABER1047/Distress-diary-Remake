// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param bp_type
///@param [onlyReturnSize]
function set_inv_size_by_bp(argument0,argument1)
{
	var tmp_width = 3, tmp_height = 1;
	switch(argument0)
	{
		case 0:
			tmp_width = 3;
			tmp_height = 1;
		break;
		
		case 1: //슬링백
			tmp_width = 4;
			tmp_height = 4;
		break;
		
		case 2: //의료 가방
			tmp_width = 5;
			tmp_height = 4;
		break;
		
		case 3: //더플백
			tmp_width = 6;
			tmp_height = 3;
		break;
		
		case 4: //백팩
			tmp_width = 4;
			tmp_height = 6;
		break;
		
		case 5: //여행자 백팩
			tmp_width = 5;
			tmp_height = 6;
		break;
		
		case 6: //대형 의료 가방
			tmp_width = 4;
			tmp_height = 6;
		break;
		
		case 7: //전술용 가방
			tmp_width = 6;
			tmp_height = 6;
		break;
	}
	
	if (argument1 == undefined || argument1 == false)
	{
		set_inv_size(tmp_width,tmp_height);
	}
	return string(tmp_width)+","+string(tmp_height);
}