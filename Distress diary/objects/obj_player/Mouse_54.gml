/// @description Insert description here
// You can write your code in this editor


if (global.my_player_id == obj_id_player_only)
{
	var tmp_ins = instance_create_multiplayer(obj_arrow,x,y,global.object_id_ind,0,false,-4,-4);
	tmp_ins.direction = point_direction(x,y,mouse_x,mouse_y);
	tmp_ins._speed = 48;
	tmp_ins.parents_obj_ind = "obj_player";
	tmp_ins.parents = id;
	tmp_ins.attack_dmg = 22;
	tmp_ins.z = 32+z;
}