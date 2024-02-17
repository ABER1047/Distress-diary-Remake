/// @description Auto fix window pos
// You can write your code in this editor
var slot_size = 160*global.n_camera_zoom; //1칸당 픽셀 사이즈
var window_weight = 64*global.n_camera_zoom; //윈도우 창 두께 (드래그 클릭으로 옮기는 그 윈도우 창)
var outline_weight = 3*global.n_camera_zoom; //테두리 두께

//해당 인벤토리 변수를 가진 인스턴스한테서 width, height 받아오기
var inv_width = variable_owner.inv_width;
var inv_height = variable_owner.inv_height;

//xscale, yscale은 인벤토리 0.1칸 사이즈 만금 더 큼 (버그가 좀 있어서 그거 방지용으로)
image_xscale = (1/48)*(((inv_width+0.1)*slot_size)+(outline_weight*2)) //괄호 안의 값은 px
image_yscale = (1/48)*(((inv_height+0.1)*slot_size)+(outline_weight*2)+(window_weight)) //괄호 안의 값은 px

var xx = camera_get_view_x(view_camera[0]);
var yy = camera_get_view_y(view_camera[0]);
var tmp_ins, tmp_x_to_go, tmp_y_to_go;
while(true)
{
	//인벤토리 첫번째 칸 시작 위치
	startx = xx+x_pos;
	starty = yy+y_pos;
	
	//인벤토리 윈도우 젤 왼쪽 상단 시작 위치
	w_starty = starty-window_weight;

	//인벤토리 창의 정가운데 위치는 x, y값임 (어차피 드로우 할 때 x, y값 아에 안써서 그럼)
	x = startx+(inv_width*slot_size*0.5);
	y = w_starty+((window_weight+inv_height*slot_size)*0.5);
	
	tmp_ins = instance_place(x,y,obj_inv_ui);
	if (instance_exists(tmp_ins))
	{
		tmp_x_to_go = (x - tmp_ins.x)/512;
		tmp_y_to_go = (y - tmp_ins.y)/512;
		
		x_pos += tmp_x_to_go;
		y_pos += tmp_y_to_go;
		is_drag_droped = true;
	}
	else
	{
		break;
	}
}














