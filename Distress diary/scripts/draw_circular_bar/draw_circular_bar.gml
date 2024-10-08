///@desc draw_circular_bar(x,y,value,max,color,radius,alpha,width)
///@param x
///@param y
///@param value
///@param max
///@param colour
///@param radius
///@param alpha
///@param width
///@param surface_index
///@param [background]
function draw_circular_bar(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9)
{
	var radius = argument5, surf_ind = argument8;
	var tmp_bg = argument9;
	if (argument6 > 0) 
	{
		// no point even running if there is nothing to display (also stops /0
		var i, len, tx, ty, val;

		// there is no draw_get_circle_precision() else I would use that here
		var numberofsections = 60;
		var sizeofsection = 6;
		
		val = (argument3 > 0) ? (argument2/argument3)*numberofsections : numberofsections; 


		if (val > 1 || tmp_bg != undefined) 
		{
			var tmp_surf_size = ceil(radius*2);
			// HTML5 version doesnt like triangle with only 2 sides 
			if (surf_ind >= array_length(global.circular_bar_surf) || !surface_exists(global.circular_bar_surf[surf_ind]))
			{
				global.circular_bar_surf[surf_ind] = surface_create(tmp_surf_size,tmp_surf_size);
			}


			surface_set_target(global.circular_bar_surf[surf_ind]);
			draw_clear_alpha(c_black,0);
			draw_set_alpha(1);
			//게이지 바 뒷 배경
			if (global.graphics_quality > 1 && tmp_bg != undefined)
			{
				draw_primitive_begin(pr_trianglefan);
				draw_set_color(tmp_bg);
				for(i = val+1; i <= numberofsections; i += (global.graphics_quality/1.5)) 
				{
					len = (i*sizeofsection)+90; // the 90 here is the starting angle
					tx = lengthdir_x(radius,len);
					ty = lengthdir_y(radius,len);
					draw_vertex(radius+tx,radius+ty);
				}
				
				draw_primitive_end();
			}
		
			if (val > 1)
			{
				//게이지 바 그리기
				draw_primitive_begin(pr_trianglefan);
				draw_set_color(argument4);
				draw_vertex(radius, radius);
				for(i = 0; i <= val; i++) 
				{
					len = (i*sizeofsection)+90; // the 90 here is the starting angle
					tx = lengthdir_x(radius,len);
					ty = lengthdir_y(radius,len);
					draw_vertex(radius+tx,radius+ty);
				}
        
				draw_primitive_end();
			}
						


        
			//원 가운데 구멍 뚫기
			gpu_set_blendmode(bm_subtract);
			draw_set_colour(c_black);
			draw_circle(radius-1, radius-1,radius-argument7,false);
			gpu_set_blendmode(bm_normal);
			surface_reset_target();
			
			
			draw_surface(global.circular_bar_surf[surf_ind],argument0-radius,argument1-radius);
		}
	}
}