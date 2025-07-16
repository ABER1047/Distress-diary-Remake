
//번개가 향하는 곳 (x -> tx, y -> ty) [자동 설정]
tx = x+lengthdir_x(image_xscale,image_angle);
ty = y+lengthdir_y(image_xscale,image_angle);


//번개 그리기
visible = true;


//번개 연쇄 생성
var tmp_var_name = "";
var tmp_val = "";
var tmp_ins = instance_create_multiplayer_ext(obj_lightning_shock,tx,ty,global.object_id_ind,0,false,my_pos_xx,my_pos_yy,tmp_var_name,tmp_val);