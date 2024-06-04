/// @description Insert description here
// You can write your code in this editor


if (visible)
{
	if (timer < animation_frame)
	{
		for(var i = 0; i < 4; i++)
		{
			direction += (180/animation_frame)*dir;
			line_width += max_line_width/animation_frame;
		

			xx1[timer] = startx+lengthdir_x(line_width,direction);
			yy1[timer] = starty+lengthdir_y(line_width,direction);
			xx2[timer] = startx+lengthdir_x(line_width*2,direction);
			yy2[timer] = starty+lengthdir_y(line_width*2,direction);
		
			timer ++;
		}
	}
	else
	{
		image_alpha += (-0.01 - image_alpha)*0.3;
		if (image_alpha <= 0)
		{
			instance_destroy();
		}
	}
}
	

