/// @description 공격 모션 재생중
var tmp_dir = choose(-1,1);
if (instance_exists(b_attack_ins))
{
	tmp_dir = -1*b_attack_ins.dir;
}

b_attack_ins = create_attack_effect(x,y,z,tmp_dir,global.n_dir*90,128,tmp_dmg_cal);


