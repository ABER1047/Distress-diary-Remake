// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param inv_width
///@param inv_height
function set_inv_size(argument0,argument1)
{
	var tmp_width = argument0;
	var tmp_height = argument1;
	
	if (!variable_instance_exists(id,"inv_width"))
	{
		inv_width = 0;
		inv_height = 0;
	}
	
	
	if (inv_width < tmp_width || inv_height < tmp_height)
	{
		for(var i = inv_height; i < tmp_height; i++)
		{
			for(var ii = inv_width; ii < tmp_width; ii++)
			{
				//inv_info_spr_ind가
				//-4일때 = 비어있음
				//-3일때 = 아이템 크기때문에 같은 종류 아이템이 있는 상태 (빈 건 아님)
				reset_inv_variable(ii,i);
			}
		}
	}
	
	inv_width = tmp_width;
	inv_height = tmp_height;
	
	//ui 인스턴스 id값 저장용
	ui_ins = -4;
	
	return true;
}