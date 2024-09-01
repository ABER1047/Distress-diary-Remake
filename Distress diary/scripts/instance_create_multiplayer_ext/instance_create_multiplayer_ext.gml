// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@param object_index
///@param x
///@param y
///@param obj_id
///@param image_index
///@param DoNotSend
///@param xpos
///@param ypos
///@param variables_name
///@param variables
function instance_create_multiplayer_ext(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9)
{
	var tmp_ins = instance_create_multiplayer(argument0,argument1,argument2,argument3,argument4,true,argument6,argument7);
	if (argument8 != "")
	{
		var tmp_var_name = string_split(argument8,",");
		var tmp_var = string_split(argument9,",");
		for(var i = 0; i < array_length(tmp_var); i++)
		{
			//sprite_index값은 따로 처리
			if (tmp_var_name[i] != "sprite_index")
			{
				try
				{
					tmp_var[i] = real(tmp_var[i]);
				} 
				catch(e) 
				{ 
					var tmp_asset = asset_get_index(tmp_var[i]);
					if (tmp_asset != -1)
					{
						tmp_var[i] = tmp_asset;
					}
				}
				
				//값 적용
				variable_instance_set(tmp_ins,string_trim(tmp_var_name[i]),tmp_var[i]);
			}
			else
			{
				var tmp_spr_asset = asset_get_index(tmp_var[i]);
				
				//값 적용
				tmp_ins.sprite_index = tmp_spr_asset;
			}
		}
	}
	
	//DoNotSend
	if (argument5 == false)
	{
		send_InstanceData(tmp_ins,string(argument8),string(argument9));
	}
	
	return tmp_ins;
}