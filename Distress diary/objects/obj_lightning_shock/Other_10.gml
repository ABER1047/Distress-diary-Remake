image_angle = angle_difference(image_angle%360,0);
image_alpha = 1;

if !variable_instance_exists(id,"tx")
{
	tx = -4;
	ty = -4;
}


//번개가 향하는 곳 (x -> tx, y -> ty) [자동 설정]
var tmp_dis = 0;
for(var i = 0; i < length; i += 4)
{
	tmp_dis = i;
	tx = x+lengthdir_x(i,image_angle);
	ty = y+lengthdir_y(i,image_angle);
	
	// 벽 충돌 체크
	if (position_meeting(tx,ty,obj_wall_parents))
	{
		break;
	}
}


//번개 그리기
visible = true;
if (count_connection == 0)
{
	image_xscale = length;
}

//공격력관련 info
var dmg_info_arr = [ attack_damage, knockback_power, critical_chance, critical_dmg_magnification, bleeding_chance, poisoning_chance, burning_chance ];

//번개 연쇄 생성
if (tmp_dis != 0 && count_connection < (max_reflection_num+1)*32)
{
	var rd_dir = image_angle + round(irandom_range(0,rd_snap_rad)*0.25) * choose(-4,4);
	create_shockbolt(tx,ty,tmp_dis,image_yscale,rd_dir,count_reflection,max_reflection_num,image_blend,attacker_id,rd_snap_rad,dmg_info_arr,my_pos_xx,my_pos_yy,count_connection+1);
}
else
{
	if (count_reflection == max_reflection_num)
	{
		tx += lengthdir_x(tmp_dis*0.5,image_angle);
		ty += lengthdir_y(tmp_dis*0.5,image_angle);
	
		chat_up_multiplayer("count_connection : "+string(count_connection),false,true);
	}
	else
	{
		//벽에 튕김
		var rd_dir = image_angle + 180 + irandom_range(-5,5);
		var tmp_xx = x+lengthdir_x(image_xscale,rd_dir);
		var tmp_yy = y+lengthdir_y(image_xscale,rd_dir);
		create_shockbolt(tmp_xx,tmp_yy,image_xscale,image_yscale,rd_dir,count_reflection+1,max_reflection_num,image_blend,attacker_id,rd_snap_rad,dmg_info_arr,my_pos_xx,my_pos_yy,count_connection+2);
		create_shockbolt(tmp_xx,tmp_yy,length,image_yscale,rd_dir,0,0,image_blend,attacker_id,rd_snap_rad,dmg_info_arr,my_pos_xx,my_pos_yy,count_connection+1);
	}
}