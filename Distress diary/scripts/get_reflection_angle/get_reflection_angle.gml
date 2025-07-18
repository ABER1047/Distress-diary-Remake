///@param x
///@param y
///@param dir
///@param speed
function get_reflection_angle(argument0, argument1, argument2, argument3)
{
    var tmp_x = argument0;
    var tmp_y = argument1;
    var tmp_speed = (argument3 < 1) ? 1 : argument3;
    var tmp_dir = argument2;
    
    // 단계적으로 충돌 검사
    var step_size = 1;
    var steps = ceil(tmp_speed / step_size);
    
    for (var i = 1; i <= steps; i++) {
        var check_x = tmp_x + lengthdir_x(i * step_size, tmp_dir);
        var check_y = tmp_y + lengthdir_y(i * step_size, tmp_dir);
        
        if (position_meeting(check_x, check_y, obj_wall_parents)) 
		{
            // 충돌 발생 - 이전 위치에서 반사 방향 계산
            var prev_x = tmp_x + lengthdir_x((i-1) * step_size, tmp_dir);
            var prev_y = tmp_y + lengthdir_y((i-1) * step_size, tmp_dir);
            
            // 수평/수직 충돌 구분
            if (position_meeting(check_x, prev_y, obj_wall_parents)) 
			{
                return 180 - tmp_dir; // 수평 반사
            } 
			else if (position_meeting(prev_x, check_y, obj_wall_parents))
			{
                return -tmp_dir; // 수직 반사
            } 
			else 
			{
                return tmp_dir + 180; // 대각선 반사
            }
        }
    }
    
    // 충돌 없음
    return tmp_dir;
}
