/// @description Insert description here
// You can write your code in this editor

//위치 (y축에 따라 depth 설정)
depth = -floor(y);


//idle animation
idle_animation ++;
if (idle_animation < 90)
{
	floating_yy += (-32 - floating_yy)*0.01;
}
else if (idle_animation < 180)
{
	floating_yy += (-96 - floating_yy)*0.01;
}
else
{
	idle_animation = 0;
}



//z-axis
z_axis_gravity();


//pushable_objects끼리 밀리는 효과
pushable_objects_physics();



//불 이펙트
if (percentage_k(15))
{
	var tmp_ins = create_bubble_effect(x+irandom_range(-16,16),y+(percentage_k(10) ? 10 : -10),-z+floating_yy-32,#0BE5C4,#D9FFDE,0.08,-irandom_range(6,12),irandom_range(-2,2),0.03,0,true);
	tmp_ins.image_xscale = 1.3;
	tmp_ins.image_yscale = 1.3;
}



//플레이어 타깃팅
if (instance_exists(targeted))
{
	image_xscale = sign_nonzero(x - targeted.x)*abs(image_xscale);
}
else
{
	targeted = instance_nearest(x,y,obj_player);
}