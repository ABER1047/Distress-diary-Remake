/// Game Start Event
function initialize_outlined_fonts() {
    // IDE에서 SDF가 이미 활성화된 Font 리소스 인덱스를 전역에 저장
    global.outlined_font_normal = font_normal;
    global.outlined_font_light  = font_light;

    // 외곽선 효과 설정
    var settings = 
	{
        outlineEnable:    true,
        outlineDistance:  4,
        outlineColour:    #222034,
        outlineAlpha:     1.0
    };
    font_enable_effects(font_normal, true, settings);
    font_enable_effects(font_light,  true, settings);
}
