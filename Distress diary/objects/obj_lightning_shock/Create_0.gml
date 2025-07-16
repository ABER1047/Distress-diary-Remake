image_alpha = 1;


//z축
add_z_axis();

//룸 포지션에 따른 오브젝트 숨기기/표시 시스템
add_my_pos_statement();

//번개가 향하는 곳 (x -> tx, y -> ty) [자동 설정]
//tx = -4;
//ty = -4;
visible = false;
alarm[0] = 1;

//번개 방향
//image_angle = 0;

//번개 길이
//length = 0; (origin)
//image_xscale = 128; (current)

//번개 두께
//image_yscale = 32;

//번개 반사 횟수
//max_reflection_num = 0; (최대 반사 가능 횟수)
//count_reflection = 0; (현재 반사 횟수)

//번개 연결 갯수 카운트용 (최적화 때문에)
count_connection = 0;

//번개 랜덤하게 꺾이는 방향 범위 (-n,n)
//rd_snap_rad = 15;