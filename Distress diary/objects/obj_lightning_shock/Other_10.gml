image_angle = angle_difference(image_angle%360,0);

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



//번개 연쇄 생성
if (tmp_dis != 0 && count_connection < (max_reflection_num+1)*32)
{
	var tmp_var_name = "x,y,image_xscale,image_yscale,count_connection,image_angle,rd_snap_rad,image_blend,max_reflection_num,count_reflection,length,attacker_id";
	var rd_dir = image_angle + round(irandom_range(0,rd_snap_rad)*0.25) * choose(-4,4);

	var tmp_val = string(tx)+","+string(ty)+","+string(tmp_dis)+","+string(image_yscale)+","+string(count_connection+1)+","+string(rd_dir)+","+string(rd_snap_rad)+","+string(image_blend)+","+string(max_reflection_num)+","+string(count_reflection)+","+string(length)+","+string(attacker_id);
	var tmp_ins = instance_create_multiplayer_ext(obj_lightning_shock,tx,ty,global.object_id_ind,0,false,my_pos_xx,my_pos_yy,tmp_var_name,tmp_val);
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
		count_reflection ++;
		var rd_dir = image_angle + 180 + irandom_range(-5,5);
		var tmp_var_name = "x,y,image_xscale,image_yscale,count_connection,image_angle,rd_snap_rad,image_blend,max_reflection_num,count_reflection,length,attacker_id";
		var tmp_xx = x+lengthdir_x(image_xscale,rd_dir);
		var tmp_yy = y+lengthdir_y(image_xscale,rd_dir);
		var tmp_val = string(tmp_xx)+","+string(tmp_yy)+","+string(image_xscale)+","+string(image_yscale)+","+string(count_connection+2)+","+string(rd_dir)+","+string(rd_snap_rad)+","+string(image_blend)+","+string(max_reflection_num)+","+string(count_reflection)+","+string(length)+","+string(attacker_id);
		var tmp_ins = instance_create_multiplayer_ext(obj_lightning_shock,tx,ty,global.object_id_ind,0,false,my_pos_xx,my_pos_yy,tmp_var_name,tmp_val);
		
		var tmp_var_name = "x,y,tx,ty,image_xscale,image_yscale,count_connection,image_blend,length,count_reflection,max_reflection_num,attacker_id";
		var tmp_val = string(x)+","+string(y)+","+string(tmp_xx)+","+string(tmp_yy)+","+string(image_xscale)+","+string(image_yscale)+","+string(count_connection+1)+","+string(image_blend)+",0,0,0,"+string(attacker_id);
		var tmp_ins = instance_create_multiplayer_ext(obj_lightning_shock,tx,ty,global.object_id_ind,0,false,my_pos_xx,my_pos_yy,tmp_var_name,tmp_val);
	}
}