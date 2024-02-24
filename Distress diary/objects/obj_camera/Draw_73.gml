/// @description Insert description here
// You can write your code in this editor

var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);

var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);

//내 플레이어 인스턴스
if (array_length(global.my_player_ins_id) > global.my_player_id)
{
	var my_p = global.my_player_ins_id[global.my_player_id];

	//임시 체력바 및 스태미나 바 그리기
	var scale = global.n_camera_zoom*2;

	//체력바 뒷 배경
	draw_sprite_ext(spr_hp_bar_remake,0,xx+8*scale,yy+yy_h*0.4+64*scale,scale,scale,0,c_white,1);
	draw_sprite_part_ext(spr_hp_bar_remake,1,0,0,(my_p.hp/my_p.max_hp)*288,33,xx+8*scale,yy+yy_h*0.4+64*scale,scale,scale,c_white,1);

	//스테미나 바 뒷 배경
	draw_sprite_ext(spr_hp_bar_remake,0,xx+8*scale,yy+yy_h*0.4+128*scale,scale,scale,0,c_white,1);
	draw_sprite_part_ext(spr_hp_bar_remake,1,0,0,(my_p.stamina/my_p.max_stamina)*288,33,xx+8*scale,yy+yy_h*0.4+128*scale,scale,scale,c_white,1);
}
















