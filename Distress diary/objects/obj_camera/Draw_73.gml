/// @description Insert description here
// You can write your code in this editor

var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);

var xx_w = camera_get_view_width(view_camera[0]);
var yy_h = camera_get_view_height(view_camera[0]);


//임시 체력바 및 스태미나 바 그리기
var scale = global.n_camera_zoom*2;

//체력바 UI
var hp_bar_ui_xx = xx+(16*scale);
var hp_bar_ui_yy = yy+yy_h-(96*scale);
draw_sprite_ext(spr_hp_bar_remake,0,hp_bar_ui_xx,hp_bar_ui_yy,scale*1.15,scale,0,c_white,1);
draw_sprite_part_ext(spr_hp_bar_remake,1,0,0,(hp_for_draw/max_hp)*288,33,hp_bar_ui_xx,hp_bar_ui_yy,scale*1.15,scale,c_white,1);


//스테미나 바 UI
var stamina_bar_ui_end_xx = hp_bar_ui_xx+(288*scale);
var stamina_bar_ui_start_yy = hp_bar_ui_yy+(36*scale);
var stamina_bar_ui_end_yy = stamina_bar_ui_start_yy+(8*scale);
draw_set_alpha(1);
draw_set_color(#17111A);
draw_rectangle(hp_bar_ui_xx,stamina_bar_ui_start_yy,stamina_bar_ui_end_xx,stamina_bar_ui_end_yy,false);
draw_set_color(#D5B6FF);
draw_rectangle(hp_bar_ui_xx,stamina_bar_ui_start_yy,hp_bar_ui_xx+(288*(stamina_for_draw/max_stamina)*scale),stamina_bar_ui_end_yy,false);


//버프-디버프 UI
var tmp_values = [ fix_num_inside(weight_for_draw,0,10), hydro_for_draw, hunger_for_draw ];
var tmp_values_max = [ 10, 100 ,100 ];
var tmp_color = [ -4, merge_color(#E14141,c_white,(tmp_values[1] > 10) ? 1 : tmp_values[1]/10), merge_color(#E14141,c_white,(tmp_values[2] > 10) ? 1 : tmp_values[2]/10) ];

if (weight_for_draw < 10)
{
	tmp_color[0] = merge_color(c_white,#FFBF36,fix_to_zero(weight_for_draw-5)/5);
}
else
{
	tmp_color[0] = merge_color(#FFBF36,#E14141,fix_to_zero(weight_for_draw-10)/50);
}



for(var i = 0; i < 3; i++)
{
	draw_circular_bar(xx+(scale*(48+78*i)),yy+yy_h-(144*scale),1,1,#17111A,32*scale,1,scale*6);
	draw_circular_bar(xx+(scale*(48+78*i)),yy+yy_h-(144*scale),tmp_values[i],tmp_values_max[i],tmp_color[i],32*scale,1,scale*6);
	draw_sprite_ext(spr_ui,i,xx+(scale*(48+78*i)),yy+yy_h-(144*scale),scale*0.9,scale*0.9,0,c_white,1);
}
















