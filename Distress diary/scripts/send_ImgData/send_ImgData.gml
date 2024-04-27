// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@desc send_ImgData(obj_id,id,sprite_index,image_index,x,y,z,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
///@param obj_id
///@param id
///@param sprite_index
///@param image_index
///@param x
///@param y
///@param z
///@param image_xscale
///@param image_yscale
///@param image_angle
///@param image_blend
///@param image_alpha

function send_ImgData(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11)
{
	var args = [ argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11 ];
	buffer_seek(command_buffer, buffer_seek_start, 0);
	buffer_write(command_buffer, buffer_u8, global.DATA_IMG_DATA);
	buffer_write(command_buffer, buffer_string, global.my_player_id); // my_player_id
	
	//데이터 압축
	var tmp_str = string(floor(args[0]))+"#"+string(object_get_name(args[1].object_index))+"#"+string(sprite_get_name(args[2]))+"#"+string(floor(args[3]*100))+"#"+string(floor(args[4]*100))+"#"+string(floor(args[5]*100))+"#"+string(floor(args[6]*100))+"#"+string(floor(args[7]*100))+"#"+string(floor(args[8]*100))+"#"+string(floor(args[9]*100))+"#"+string(floor(args[10]*100))+"#"+string(floor(args[11]*100));
	buffer_write(command_buffer, buffer_string, tmp_str);
	send_all(command_buffer);
}