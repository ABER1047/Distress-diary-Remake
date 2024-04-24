// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

///@param buffer
function instance_create_or_delete(argument0)
{
	var buffer = argument0;
	var tmp_obj_ind_name = buffer_read(buffer, buffer_string);
	var tmp_obj_ind = asset_get_index(tmp_obj_ind_name);
	var is_destroy = real(buffer_read(buffer, buffer_string)); //is_destroy가 1인 경우 해당 obj_id에 부합하는 인스턴스 삭제
	var tmp_obj_id = real(buffer_read(buffer, buffer_string));
				
	//is_destroy가 1인 경우 해당 obj_id에 부합하는 인스턴스 삭제
	if (is_destroy == 1)
	{
		show_message_log("- 오브젝트 삭제 요청 ["+string(tmp_obj_ind_name)+", obj_id : "+string(tmp_obj_id)+"]");
		with(tmp_obj_ind)
		{
			if (obj_id == tmp_obj_id)
			{
				show_message_log("- 오브젝트 삭제 [obj_id : "+string(obj_id)+"]");
				instance_destroy();
			}
		}
	}
	else
	{
		show_message_log("- ["+string(tmp_obj_id)+"] 오브젝트 데이터 수신 완료");
					
		//이미 해당 obj_id를 가진 오브젝트가 존재하는지 체크
		/*새로운 플레이어가 중도 참여시 기존에 있던 유저들한테도 전부 다 오브젝트 생성하라고
		명령을 보내는데, 이 때문에 오브젝트가 중복되서 생성되는 것을 방지하기 위함*/
		var can_create_object = true;
		with(tmp_obj_ind)
		{
			if (obj_id == tmp_obj_id)
			{
				can_create_object = false;
			}
		}
					
					
		//존재하지 않으면 생성해주기
		if (can_create_object)
		{
			//is_destroy가 0인 경우 새로운 오브젝트 생성 (= 특별한 기능이 없는 오브젝트 [ex. 벽...])
			var tmp_xx = real(buffer_read(buffer, buffer_string));
			var tmp_yy = real(buffer_read(buffer, buffer_string));
			var tmp_img_ind = real(buffer_read(buffer, buffer_string));
			var tmp_xpos = real(buffer_read(buffer, buffer_string));
			var tmp_ypos = real(buffer_read(buffer, buffer_string));
					
			instance_create_multiplayer(tmp_obj_ind,tmp_xx,tmp_yy,tmp_obj_id,tmp_img_ind,true,tmp_xpos,tmp_ypos);
		}
	}
}