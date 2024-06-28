/// @description Insert description here
// You can write your code in this editor

for(var i = 0; i < 8; i++)
{
	var tmp_cal = 0.06*sqrt(1+i);
	line_xx[i] += (x - line_xx[i])*tmp_cal;
	line_yy[i] += (y - line_yy[i])*tmp_cal;
}

if (speed < 0.01)
{
	instance_destroy();
}

speed += (0 - speed)*0.01;
if (speed < 1)
{
	speed += (0 - speed)*0.1;
}
direction += angle_difference(rd_dir_increasement,direction)*0.1;


rd_dir_increasement_timer ++;
if (rd_dir_increasement_timer > 60)
{
	rd_dir_increasement = start_dir+irandom_range(-65,65);
	rd_dir_increasement_timer -= irandom_range(60,90);
}