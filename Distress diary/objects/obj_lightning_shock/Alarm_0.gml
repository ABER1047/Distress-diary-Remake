
//번개가 향하는 곳 (x -> tx, y -> ty) [자동 설정]
var tmp_dis = 0;
for(var i = 0; i < image_xscale; i += 4)
{
	tx = floor(x+lengthdir_x(i,image_angle));
	ty = floor(y+lengthdir_y(i,image_angle));
	
	// 벽 충돌 체크
	if (position_meeting(tx,ty,obj_wall_parents))
	{
		tmp_dis = i;
		break;
	}
}


//번개 그리기
visible = true;


//번개 연쇄 생성
if (tmp_dis != 0 || count_connection > 64)
{
	var tmp_var_name = "x,y,image_xscale,image_yscale,count_connection,image_angle,rd_snap_rad";
	var tmp_val = string(tx)+","+string(ty)+","+string(tmp_dis)+","+string(image_yscale)+","+string(count_connection+1)+","+string(image_angle+irandom_range(-rd_snap_rad,rd_snap_rad))+","+string(rd_snap_rad);
	var tmp_ins = instance_create_multiplayer_ext(obj_lightning_shock,tx,ty,global.object_id_ind,0,false,my_pos_xx,my_pos_yy,tmp_var_name,tmp_val);
}
else
{
	show_message_log(count_connection);
}