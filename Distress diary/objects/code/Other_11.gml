/// @description setting view ratio

var tmp_val = !window_get_fullscreen();
var w = 1280, h = 720;
if (tmp_val)
{
	w = 1920;
	h = 1080;
}
		
window_enable_borderless_fullscreen(tmp_val);
window_set_size(w,h);
window_set_fullscreen(tmp_val);
