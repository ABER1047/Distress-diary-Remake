

///@param x
///@param y
///@param dmg
///@param size
///@param xpos
///@param ypos
function create_explosion_effect(argument0,argument1,argument2,argument3,argument4,argument5)
{
	var tmp_ins = instance_create_multiplayer(obj_explosion,argument0,argument1,global.object_id_ind,0,false,argument4,argument5);
	tmp_ins.explo_dmg = argument2;
	tmp_ins.image_xscale = argument3;
	
	return tmp_ins
}