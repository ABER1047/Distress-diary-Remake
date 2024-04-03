// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param bp_type
function set_inv_size_by_bp(argument0)
{
	switch(argument0)
	{
		case 0:
			set_inv_size(3,1);
		break;
		
		case 1: //슬링백
			set_inv_size(4,4);
		break;
		
		case 2: //의료 가방
			set_inv_size(5,4);
		break;
		
		case 3: //더플백
			set_inv_size(6,3);
		break;
		
		case 4: //백팩
			set_inv_size(4,6);
		break;
		
		case 5: //여행자 백팩
			set_inv_size(5,6);
		break;
		
		case 6: //대형 의료 가방
			set_inv_size(4,6);
		break;
		
		case 7: //전술용 가방
			set_inv_size(6,6);
		break;
	}
}