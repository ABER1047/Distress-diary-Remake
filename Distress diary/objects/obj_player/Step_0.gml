/// @description 클라이언트 영향 없는 스텝 이벤트
// You can write your code in this editor


//위치 (y축에 따라 depth 설정)
depth = -floor(y);


//pushable_objects끼리 밀리는 효과
pushable_objects_physics();


//인터렉션 키 드로우 용
if (show_interaction_key > 0)
{
	show_interaction_key --;
}



if (my_backpack != b_my_backpack)
{
	set_inv_size_by_bp(my_backpack);
	b_my_backpack = my_backpack;
}





//다른사람이 내 인벤을 루팅 중인 경우, 루팅 중이라고 정보 보내기
if (is_opened != b_is_opened)
{
	send_InstanceVariableData(id,"is_opened");
	b_is_opened = is_opened;
}



my_pos_xx = global.n_player_room_xx[obj_id_player_only];
my_pos_yy = global.n_player_room_yy[obj_id_player_only];






//라이트 효과
if (!stop_cal_by_pos_statement && holding_item_spr_ind == spr_others)
{
	var tmp_yy = y-32-z*0.8;
	var light_col = [ #FFAC4B, #0BE5C4, #E395F8 ];
	c_light(light_col[holding_item_img_ind],light_scale*0.7,light_alpha,x,tmp_yy);
	light_timer ++;
	if (light_timer < 90)
	{
		light_alpha += (1 - light_alpha)*0.1;
		light_scale += (1 - light_scale)*0.1;
	}
	else if (light_timer < 120)
	{
		light_alpha += (0.92 - light_alpha)*0.1;
		light_scale += (0.95 - light_scale)*0.1;
	}
	else
	{
		light_timer = 0;
	}
	
	
	//불 이펙트 생성
	if (global.graphics_quality >= 1)
	{
		if (percentage_k(1))
		{
			var tmp_signed_xscale = -sign(image_xscale);
			var tmp_xpos = [ 48, 56, 48, 40 ];
			var tmp_ypos = [ 36, 44, 36, 44 ];
			var tmp_ins = instance_create_depth(x+tmp_signed_xscale*tmp_xpos[image_index],tmp_yy-16-tmp_ypos[image_index],-1,obj_bright_line_effect);
			tmp_ins.image_blend = light_col[holding_item_img_ind];
			tmp_ins.direction = 90;
			tmp_ins.rd_dir_increasement = 90+tmp_signed_xscale*30+global.movement_hspeed*20;
			tmp_ins.start_dir = 90;
			tmp_ins.speed = irandom_range(20,30)/15+abs(global.movement_hspeed*0.1);
			tmp_ins.rd_dir_timer_increasement = 1;
		}
	}
}


//현재 들고 있는 아이템 휘두르기 애니메이션
holding_item_angle += (0 - holding_item_angle)*0.2;