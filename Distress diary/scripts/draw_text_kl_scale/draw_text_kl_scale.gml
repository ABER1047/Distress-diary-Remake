///@description draw_text_kl_scale(x, y, string, sep, w, alpha, color, valign, halign, font, xscale, yscale, angle)
function draw_text_kl_scale(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11, argument12) {
	//draw_text_kl_scale(x, y, string, sep, w, alpha, color, valign, halign, font, xscale, yscale, angle)
	///@param x
	///@param y
	///@param string
	///@param sep
	///@param w
	///@param alpha
	///@param color
	///@param valign
	///@param halign
	///@param font
	///@param xscale
	///@param yscale
	///@param angle

	////////////////////////////////////////////////////////////////


	//폰트설정
	draw_set_font(argument9);
	//알파설정
	draw_set_alpha(argument5);

	////////////////////////////////////////////////////////////////

	//위치지정
	if argument7 != -1 && argument7 != 0 && argument7 != 1
	{
	draw_set_valign(argument7);
	}
	if argument8 != -1 && argument8 != 0 && argument8 != 1
	{
	draw_set_halign(argument8);
	}

	if argument7 = -1
	{
	//draw_set_valign(fa_top);
	}
	if argument8 = -1
	{
	draw_set_halign(fa_left);
	}

	if argument7 = 0
	{
	//draw_set_valign(fa_bottom);
	}
	if argument8 = 0
	{
	draw_set_halign(fa_middle);
	}

	if argument7 = 1
	{
	//draw_set_valign(fa_middle);
	}
	if argument8 = 1
	{
	draw_set_halign(fa_right);
	}

	////////////////////////////////////////////////////////////////////////////

	//글씨 드로우
	if argument3 > 0 && argument4 < 0
	{
	//컬러설정

		draw_set_color($FF191919&$ffffff);
		for(var i = 1; i <= 3; i += 1)
		{
		//i = argument10
		draw_text_ext_transformed(argument0+i,argument1+argument11*32,argument2,argument3,99999999999,argument10,argument11,argument12);
		draw_text_ext_transformed(argument0,argument1+i+argument11*32,argument2,argument3,99999999999,argument10,argument11,argument12);
		draw_text_ext_transformed(argument0-i,argument1+argument11*32,argument2,argument3,99999999999,argument10,argument11,argument12);
		draw_text_ext_transformed(argument0,argument1-i+argument11*32,argument2,argument3,99999999999,argument10,argument11,argument12);
		}
	
	
	


	//컬러설정
	draw_set_color(argument6&$ffffff);
	draw_text_ext_transformed(argument0,argument1+argument11*32,argument2,argument3,99999999999,argument10,argument11,argument12);
	}

	if argument3 > 0 && argument4 > 0
	{

		draw_set_color($FF191919&$ffffff);
		

		for(var i = 1; i <= 3; i += global.converted_view_ratio)
		{
			//i = argument10
			draw_text_ext_transformed(argument0+i,argument1+argument11*32,argument2,argument3,argument4,argument10,argument11,argument12);
			draw_text_ext_transformed(argument0,argument1+i+argument11*32,argument2,argument3,argument4,argument10,argument11,argument12);
			draw_text_ext_transformed(argument0-i,argument1+argument11*32,argument2,argument3,argument4,argument10,argument11,argument12);
			draw_text_ext_transformed(argument0,argument1-i+argument11*32,argument2,argument3,argument4,argument10,argument11,argument12);
		}



		//컬러설정
		draw_set_color(argument6&$ffffff);
		draw_text_ext_transformed(argument0,argument1+argument11*32,argument2,argument3,argument4,argument10,argument11,argument12);
	}









	////////////////MADE BY KUNMAGUN///////////////////////


}
