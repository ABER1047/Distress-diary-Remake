/// @description Insert description here
// You can write your code in this editor
my_instance_id = obj_player.id;
my_instance_id.nickname = global.nickname;
my_instance_id.object_id = 0;
my_instance_id.soc = 0;

if (is_server) 
{
	ds_list_add(clients, -1);
}