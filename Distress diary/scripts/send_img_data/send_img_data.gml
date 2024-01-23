// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


///@desc send_img_data()
///@param buffer
///@param obj_id
///@param obj_ind
///@param spr_ind
///@param img_ind
///@param x
///@param y
///@param z
///@param img_xscale
///@param img_yscale
///@param img_angle
///@param img_alpha
///@param img_blend
function send_img_data(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11)
{
	buffer_seek(command_buffer, buffer_seek_start, 0);
	buffer_write(command_buffer, buffer_u8, code_m.DATA.COMMAND);
	buffer_write(command_buffer, buffer_u8, code_m.object_id);
	buffer_write(command_buffer, buffer_u8, code_m.COMM.P_INFO);
	send_all(command_buffer);
}