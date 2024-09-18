/// @description Insert description here
// You can write your code in this editor


tmp_buff_timer ++;
if (tmp_buff_timer > 180)
{
	tmp_buff_timer = 0;
}


des_timer ++;
if (des_timer > des_time)
{
	image_alpha += (-0.01 - image_alpha)*0.1
	if (image_alpha <= 0)
	{
		instance_destroy();
	}
}