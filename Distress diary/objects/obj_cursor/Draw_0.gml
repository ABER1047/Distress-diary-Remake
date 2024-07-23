/// @description Insert description here
// You can write your code in this editor
if (!hide_cursor && !tmp_check)
{
	var tmp_ins = interacion_ins_exists;
	if (instance_exists(tmp_ins))
	{
		x = tmp_ins.x;
		y = tmp_ins.y;
		
		var dx = [ -4, 0, 4, 0 ];
		var dy = [ 0, -4, 0, 4 ];
		shader_set(shFlash);
		for(var i = 0; i < 4; i++)
		{
			draw_sprite_ext(tmp_ins.sprite_index,tmp_ins.image_index,tmp_ins.x+dx[i],tmp_ins.y+dy[i],tmp_ins.image_xscale,tmp_ins.image_yscale,0,c_white,1);
		}
		shader_reset();
	}
	else
	{
		draw_self();
	}
}