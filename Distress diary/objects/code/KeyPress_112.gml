/// @description Insert description here
// You can write your code in this editor
var tmp_xx = room_width*0.5+round((mouse_x-room_width*0.5)/96)*96;
var tmp_yy = room_height*0.5+round((mouse_y-room_height*0.5)/96)*96;
var tmp_ins = instance_create_depth(tmp_xx,tmp_yy,-1,obj_transfer_portal);
tmp_ins.image_index = choose(0,1);