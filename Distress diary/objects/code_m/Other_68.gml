/// @description Insert description here
// You can write your code in this editor
if (type == network_type_connect) 
{
	var socket = async_load[? "socket"];
	var cli_max = ds_list_size(clients)

	index = 0;
	buffer_seek(info_buffer, buffer_seek_start, 0);
	buffer_write(info_buffer, buffer_u8, DATA.INIT_DATA);
	buffer_write(info_buffer, buffer_u8, cli_max);
	buffer_write(info_buffer, buffer_u8, socket);
	
	for(var i = 0; i < cli_max; i++) 
	{
		with(obj_player) 
		{
			if (other.index == playerID) 
			{
				buffer_write(other.info_buffer, buffer_u16, x);
				buffer_write(other.info_buffer, buffer_u16, y);
				buffer_write(other.info_buffer, buffer_string, name);
				buffer_write(other.info_buffer, buffer_u8, soc);
			}
		}
		index++;
	}
	
	network_send_packet(socket, info_buffer, buffer_get_size(info_buffer));
	ds_list_add(clients, socket);
}

else if (type == network_type_disconnect) 
{
	var socket = async_load[? "socket"];//"id"쓰지 말것 무조건 0이 나온다.

	buffer_seek(dis_buffer, buffer_seek_start, 0);
	buffer_write(dis_buffer, buffer_u8, DATA.REMOVE_CLI);
	buffer_write(dis_buffer, buffer_u8, socket);
	
	with(obj_player) 
	{
		if (soc == socket) 
		{
			instance_destroy();
		}
	}
	chat_up("클라이언트가 나갔습니다.");
	
	var pos = ds_list_find_index(clients, socket);
	ds_list_delete(clients, pos);
	
	send_all(dis_buffer);
}

else if (type == network_type_data) 
{
	var buffer = async_load[? "buffer"];
	
	buffer_seek(buffer, buffer_seek_start, 0);
	
	var data = buffer_read(buffer, buffer_u8);
	
	switch(data) 
	{
		case DATA.INIT_DATA:
			my_ID = buffer_read(buffer, buffer_u8);
			var socket = buffer_read(buffer, buffer_u8);
			code_m.cli_num = my_ID;
			player.playerID = my_ID;
			my_instance_id.soc = socket;
			chat_up("채팅방에 들어왔습니다.");
			for(i = 0; i < my_ID; i++)
			{
				var startx = buffer_read(buffer, buffer_u16);
				var starty = buffer_read(buffer, buffer_u16);
				var obj = instance_create_depth(startx,starty,-100,player);
				obj.playerID = i;
				obj.nickname = buffer_read(buffer, buffer_string);
				obj.soc = buffer_read(buffer, buffer_u8);
			}
			buffer_seek(info_buffer, buffer_seek_start, 0);
			buffer_write(info_buffer, buffer_u8, DATA.ADD_CLI);
			buffer_write(info_buffer, buffer_u8, my_ID);
			send_all(info_buffer);
			send_one(buffer_string, "name");
			send_one(buffer_u8, "soc");
		break;
		
		case DATA.CHAT:
			str = buffer_read(buffer, buffer_string);
			chat_up(str);
		break;
		
		case DATA.ONE_DATA:
			var ID = buffer_read(buffer, buffer_u8);
			var type = buffer_read(buffer, buffer_u8);
			var val_name = buffer_read(buffer, buffer_string);
			var val = buffer_read(buffer, type);
			with(obj_player) 
			{
				if (playerID == ID) 
				{
					variable_instance_set(id, val_name, val);
				}
			}
		break;
		
		case DATA.MUCH_DATA:
			var ID = buffer_read(buffer, buffer_u8);
			var size = buffer_read(buffer, buffer_u8);
			for(var i = 0; i < size; i++) 
			{
				var type = buffer_read(buffer, buffer_u8);
				var val_name = buffer_read(buffer, buffer_string);
				var val = buffer_read(buffer, type);
				with(obj_player) 
				{
					if (playerID == ID) 
					{
						variable_instance_set(id, val_name, val);
					}
				}
			}
		break;
		
		case DATA.ADD_CLI:
			var some_ID = buffer_read(buffer, buffer_u8);
			if (my_ID != some_ID) 
			{
				var obj = instance_create_depth(0, 0, -100, obj_nope);
				obj.nickname = "";
				obj.playerID = some_ID;
				obj.soc = 0;
				code_m.cli_num++;
				chat_up("새로운 크라이언트가 왔습니다.");	
			}
		break;
		
		case DATA.REMOVE_CLI:
			var socket = buffer_read(buffer, buffer_u8);
			with(obj_player) 
			{
				if (soc == socket) 
				{
					instance_destroy();
				}
			}
			chat_up("누군가가 나갔습니다.");
			code_m.cli_num--;
		break;
		case DATA.COMMAND:
			var com_ID = buffer_read(buffer, buffer_u8);
			var command = buffer_read(buffer, buffer_u8);
			switch(command) 
			{
				case COMM.INFO:
				with(obj_player)
				{
					if (playerID = com_ID)
					{
						var xx = buffer_read(buffer, buffer_string);
						var yy = buffer_read(buffer, buffer_string);
						var zz = buffer_read(buffer, buffer_string);
						var img_alpha_ = buffer_read(buffer, buffer_string);
						var img_angle_ = buffer_read(buffer, buffer_string);
						var img_ind_ = buffer_read(buffer, buffer_string);
						var img_xscale_ = buffer_read(buffer, buffer_string);
						var img_yscale_ = buffer_read(buffer, buffer_string);
						var img_blend_ = buffer_read(buffer, buffer_string);
						var spr_ind_name_ = buffer_read(buffer, buffer_string);
				
						x = xx/10;
						y = yy/10;
						z = zz/10;
						image_alpha = img_alpha_/100;
						image_angle = img_angle_/10;
						image_index = img_ind_;
						image_xscale = img_xscale_/100;
						image_yscale = img_yscale_/100;
						image_blend = string(img_blend_);
						sprite_index = asset_get_index(string(spr_ind_name_));
					}
				}
				break;
				
				case COMM.DMGED_INFO:
				with(obj_player)
				{
					if (playerID = com_ID)
					{
						for(var i = 0; i <= 25; i++)
						{
							var __arrow_img_ind = buffer_read(buffer, buffer_string);
							var __arrow_xx = buffer_read(buffer, buffer_string);
							var __arrow_yy = buffer_read(buffer, buffer_string);
							var __arrow_angle = buffer_read(buffer, buffer_string);
						
							arrow_img_ind[i] = __arrow_img_ind;
							arrow_xx[i] = __arrow_xx/10;
							arrow_yy[i] = __arrow_yy/10;
							arrow_angle[i] = __arrow_angle/10;
						}
					}
				}
				break;
			}
		break;
	}
	
	if (is_server) 
	{
		send_all(buffer);
	}
}