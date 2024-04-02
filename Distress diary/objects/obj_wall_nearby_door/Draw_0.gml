/// @description Insert description here
// You can write your code in this editor
var tmp_room_xx = room_width*0.5;
var tmp_room_yy = room_height*0.5;
var tmp_wall_scale = image_xscale;
var tmp_wall_sprite_size = tmp_wall_scale*48;
var n_wall_type = 0;


var tmp_spr_ind = n_wall_type*3+3;
draw_sprite_ext(sprite_index,tmp_spr_ind,x,y,tmp_wall_scale,tmp_wall_scale,0,c_white,1);
