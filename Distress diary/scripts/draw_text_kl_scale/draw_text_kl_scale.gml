///@description draw_text_kl_scale(x, y, string, sep, w, alpha, color, valign, halign, font, xscale, yscale, angle)
function draw_text_kl_scale(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11, argument12) 
{
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
	var tmp_scale = camera_get_view_width(view_camera[0])/1280;
	var w_ratio = global.w_ratio_by_window;
	var h_ratio = global.h_ratio_by_window;
	var text_scale_real = tmp_scale;
	var txt_xscale = argument10*0.8125/w_ratio*text_scale_real;
	var txt_yscale = argument11*0.8125/h_ratio*text_scale_real;
	var args = [ argument0, argument1+4*h_ratio*text_scale_real/2, argument2, argument3/h_ratio*text_scale_real/2, argument4, argument5, argument6, argument7, argument8, argument9, txt_xscale, txt_yscale, argument12 ];
	
	////////////////////////////////////////////////////////////////

	//폰트설정
	draw_set_font(args[9]);
	//알파설정
	draw_set_alpha(args[5]);

	////////////////////////////////////////////////////////////////

	//draw_set_valign(fa_middle);
	//위치지정
	if (args[8] == -1)
	{
		draw_set_halign(fa_left);
	}
	else if (args[8] == 0)
	{
		draw_set_halign(fa_middle);
	}
	else
	{
		draw_set_halign(fa_right);
	}


	////////////////////////////////////////////////////////////////////////////

	//글씨 드로우
	if (args[3] > 0)
	{
		if (args[4] < 0)
		{
			//컬러설정
			draw_set_color($FF191919&$ffffff);
			for(var i = 1; i <= 3; i += 1.5)
			{
				//i = args[10]
				draw_text_ext_transformed(args[0]+i,args[1]+args[11]*32,args[2],args[3],99999,args[10],args[11],args[12]);
				draw_text_ext_transformed(args[0],args[1]+i+args[11]*32,args[2],args[3],99999,args[10],args[11],args[12]);
				draw_text_ext_transformed(args[0]-i,args[1]+args[11]*32,args[2],args[3],99999,args[10],args[11],args[12]);
				draw_text_ext_transformed(args[0],args[1]-i+args[11]*32,args[2],args[3],99999,args[10],args[11],args[12]);
			}
	
	
	


			//컬러설정
			draw_set_color(args[6]);
			draw_text_ext_transformed(args[0],args[1]+args[11]*32,args[2],args[3],99999,args[10],args[11],args[12]);
		}
		else if (args[4] > 0)
		{

			draw_set_color($FF191919&$ffffff);
			for(var i = 1; i <= 3; i += 1)
			{
				//i = args[10]
				draw_text_ext_transformed(args[0]+i,args[1]+args[11]*32,args[2],args[3],args[4],args[10],args[11],args[12]);
				draw_text_ext_transformed(args[0],args[1]+i+args[11]*32,args[2],args[3],args[4],args[10],args[11],args[12]);
				draw_text_ext_transformed(args[0]-i,args[1]+args[11]*32,args[2],args[3],args[4],args[10],args[11],args[12]);
				draw_text_ext_transformed(args[0],args[1]-i+args[11]*32,args[2],args[3],args[4],args[10],args[11],args[12]);
			}



			//컬러설정
			draw_set_color(args[6]);
			draw_text_ext_transformed(args[0],args[1]+args[11]*32,args[2],args[3],args[4],args[10],args[11],args[12]);
		}
	}
	

	////////////////MADE BY KUNMAGUN///////////////////////
}
