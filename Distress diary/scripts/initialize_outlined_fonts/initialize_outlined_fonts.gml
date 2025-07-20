


///@param enable
///@param [thickness]
function initialize_outlined_fonts(argument0,argument1) 
{
    // IDE에서 SDF가 이미 활성화된 Font 리소스 인덱스를 전역에 저장
    // 외곽선 효과 설정
    var settings = 
	{
        outlineEnable : true,
        outlineDistance : (argument1 != undefined) ? argument1 : 4,
        outlineColour : #222034,
        outlineAlpha : 1
    };
    font_enable_effects(font_normal_outline,argument0,settings);
    font_enable_effects(font_light_outline,argument0,settings);
}
