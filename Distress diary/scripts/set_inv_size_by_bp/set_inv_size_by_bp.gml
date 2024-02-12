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
		
		case 1:
			set_inv_size(4,5);
		break;
		
		case 2:
			set_inv_size(5,4);
		break;
		
		case 3:
			set_inv_size(6,3);
		break;
		
		case 4:
			set_inv_size(4,6);
		break;
		
		case 5:
			set_inv_size(4,6);
		break;
		
		case 6:
			set_inv_size(4,6);
		break;
		
		case 7:
			set_inv_size(4,6);
		break;
	}
}