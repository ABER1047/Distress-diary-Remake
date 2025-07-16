
//번개가 향하는 곳 (x -> tx, y -> ty) [자동 설정]
var tmp_dis = 0;
for(var i = 0; i < image_xscale; i += 4)
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


//번개 연쇄 생성
if (tmp_dis != 0 || count_connection < max_reflection_num*48)
{
	var tmp_var_name = "x,y,image_xscale,image_yscale,count_connection,image_angle,rd_snap_rad,image_blend,max_reflection_num,count_reflection,reflected";
	var rd_dir = image_angle + (reflected ? 180 : 0) + round(irandom_range(0,rd_snap_rad)*0.25)*choose(-4,4);
	var tmp_xx = (reflected ? x : tx);
	var tmp_yy = (reflected ? y : ty);
	reflected = false; // 반사 값 적용 했으니, 값 제거

	var tmp_val = string(tmp_xx)+","+string(tmp_yy)+","+string(tmp_dis)+","+string(image_yscale)+","+string(count_connection+1)+","+string(rd_dir)+","+string(rd_snap_rad)+","+string(image_blend)+","+string(max_reflection_num)+","+string(count_reflection)+","+string(reflected);
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
		count_reflection ++;
		reflected = true;
		event_user(0);
	}
}