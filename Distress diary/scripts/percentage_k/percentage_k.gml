///@desc percentage_k(percentage)
///@param percentage
function percentage_k(argument0) 
{

	var get_random_percentage = irandom_range(0,100000)

	if !(argument0 < 0) && (argument0*1000 <= 100000)
	{
		if get_random_percentage <= argument0*1000
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	else if (argument0*1000 > 100000)
	{
		return true;
	}


}
