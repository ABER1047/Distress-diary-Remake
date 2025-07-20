/// Game Start Event 또는 방 시작 시 실행
function initialize_outlined_fonts() {
    // 1) 프로젝트에 이미 등록된 Font 리소스인 font_normal과 font_light를 전역 변수에 저장
    global.outlined_font_normal = font_normal;
    global.outlined_font_light  = font_light;

    // 2) SDF 렌더링 활성화 (GameMaker 2023.8+)
    font_enable_sdf(global.outlined_font_normal, true);
    font_enable_sdf(global.outlined_font_light,  true);

    // 3) 외곽선 효과 설정 (두 폰트에 동일하게 적용)
    var effect_settings = {
        outlineEnable:    true,
        outlineDistance:  2,           // 외곽선 두께
        outlineColour:    $FF191919,   // 외곽선 색상
        outlineAlpha:     1.0
    };
    font_enable_effects(global.outlined_font_normal, true, effect_settings);
    font_enable_effects(global.outlined_font_light,  true, effect_settings);
}
