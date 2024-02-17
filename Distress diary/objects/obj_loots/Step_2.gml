/// @description Insert description here
// You can write your code in this editor




//상자 열리는 애니메이션
opening_animation += (((instance_exists(is_opened) || is_opened == -3) ? 1 : 0) - opening_animation)*0.2;


//인터렉션 키 드로우 용
if (show_interaction_key > 0)
{
	show_interaction_key -= 1;
}


//다른사람이 루팅 중인 경우, 루팅 중이라고 정보 보내기
if (is_opened != b_is_opened)
{
	send_InstanceVariableData(id,"is_opened");
	b_is_opened = is_opened;
}