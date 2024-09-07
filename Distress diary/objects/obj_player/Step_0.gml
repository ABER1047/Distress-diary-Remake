/// @description 클라이언트 영향 없는 스텝 이벤트
// You can write your code in this editor

var chk_is_my_player = (global.my_player_id == obj_id_player_only);

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



//버프 효과 적용
if (buff_applied_index >= 0)
{
	var i = buff_applied_index;
	if (chk_is_my_player)
	{
		var get_max_time = max(global.buff_max_left_time[i],buff_left_time[i]);
		global.buff_left_time[i] = buff_left_time[i];
		global.buff_max_left_time[i] = get_max_time;
		show_message_log("buff_applied_index : "+string(buff_applied_index)+" | buff_left_time :"+string(global.buff_left_time[i])+" / "+string(buff_left_time[i]));
		buff_left_time[i] = 0.1;
	}
	else
	{
		if (buff_left_time[i] >= 1)
		{
			send_InstanceMuchVariableData(id,"buff_left_time["+string(i)+"],buff_applied_index",string(floor(buff_left_time[i]))+","+string(i));
			buff_left_time[i] = 0.1;
		}
	}
	buff_applied_index = -4;
}

//화염 디버프 이펙트
if (buff_left_time[19] > 0 && global.graphics_quality >= 2)
{
	repeat(irandom_range(1,3))
	{
		if (percentage_k(10))
		{
			var tmp_ins = create_bubble_effect(x+irandom_range(-16,16),y-z-32,1,#DD4C4C,#FFAC4B,0.08,-irandom_range(6,12),irandom_range(-2,2),0.03,0,true,-y-1);
			tmp_ins.image_xscale = 0.5;
			tmp_ins.image_yscale = 0.5;
		}
	}
}




//라이트 효과
if (!stop_cal_by_pos_statement && (holding_item_spr_ind == spr_animated_torch || holding_item_spr_ind == spr_animated_soul_torch || holding_item_spr_ind == spr_animated_demon_torch))
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
		var tmp_signed_xscale = -sign(image_xscale);
		var tmp_xpos = [ 48, 56, 48, 40 ];
		var tmp_ypos = [ 36, 44, 36, 44 ];
		var tmp_cal_xx = x+tmp_signed_xscale*tmp_xpos[image_index];
		var tmp_cal_yy = tmp_yy-16-tmp_ypos[image_index];
		if (percentage_k(1))
		{
			var tmp_ins = instance_create_depth(tmp_cal_xx,tmp_cal_yy,-1,obj_bright_line_effect);
			tmp_ins.image_blend = light_col[holding_item_img_ind];
			tmp_ins.direction = 90;
			tmp_ins.rd_dir_increasement = 90+tmp_signed_xscale*30+global.movement_hspeed*20;
			tmp_ins.start_dir = 90;
			tmp_ins.speed = irandom_range(20,30)/15+abs(global.movement_hspeed*0.1);
			tmp_ins.rd_dir_timer_increasement = 1;
		}
		
		if (global.graphics_quality >= 2 && percentage_k(5))
		{
			var tmp_ins = create_bubble_effect(tmp_cal_xx,tmp_cal_yy,1,merge_color(light_col[holding_item_img_ind],c_black,0.1),light_col[holding_item_img_ind],0.08,-irandom_range(6,12)-global.movement_vspeed,irandom_range(-2,2)-global.movement_hspeed,0.03,0,true,-y-1);
			tmp_ins.image_xscale = 0.5;
			tmp_ins.image_yscale = 0.5;
		}
	}
}


//현재 들고 있는 아이템 휘두르기 애니메이션
holding_item_angle += (0 - holding_item_angle)*0.2;



