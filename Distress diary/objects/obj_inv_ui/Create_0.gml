/// @description Insert description here
// You can write your code in this editor





//x_pos = 0;
//y_pos = 0;
//inv_width = 0;
//inv_height = 0;

//해당 인벤토리에 들어있는 모든 아이템 무게 총합 저장용
inv_weight = 0;


//창 드래그 중인지 체크
relative_x_pos = -4;
relative_y_pos = -4;
is_dragging_window = false;
is_drag_dropped = false;


//인벤토리 첫번째 칸 시작 위치
startx = -9999;
starty = -9999;

//인벤토리 마지막 칸 위치
endx = -9999;
endy = -9999;


//인벤토리 윈도우 젤 왼쪽 상단 시작 위치
w_starty = -9999;


//인벤토리 창의 정가운데 위치는 x, y값임 (어차혈흔 드로우 할 때 x, y값 아에 안써서 그럼)
x = -4;
y = -4;


//해당 인벤토리 ui 리로드
//reload_inv = 0;


//인벤토리 창끼리 겹치지 않도록 자동으로 창 좌표 고치기
alarm[1] = 1;


//아이템 서칭 시스템 작동
search_item = true;
searching_sfx = -4;