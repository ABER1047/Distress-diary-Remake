/// @description Insert description here
// You can write your code in this editor
buffer_delete(dis_buffer);
buffer_delete(info_buffer);
buffer_delete(one_buffer);
buffer_delete(much_buffer);

//변수 전송용 버퍼
buffer_delete(global.variable_data_buffer);

//맵 데이터 전송용 버퍼
buffer_delete(global.map_data_buffer);

//오브젝트 데이터 전송용 버퍼
buffer_delete(global.obj_data_buffer);

//인벤토리 데이터 전송용 버퍼
buffer_delete(global.inv_data_buffer);

//사운드 이펙트용 버퍼
buffer_delete(global.sfx_data_buffer);
