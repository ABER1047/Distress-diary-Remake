///@description draw_text_kl_scale 최종 버전 (내장 정렬 함수 사용)
///@arg xPos            기준 X 좌표
///@arg yPos            기준 Y 좌표
///@arg textString      출력할 문자열
///@arg sep             줄바꿈 너비 (0 이하: 단일 줄)
///@arg width           최대 줄 길이
///@arg alpha           투명도 (0.0~1.0)
///@arg color           글자 색상
///@arg valign          수직 정렬(fa_top, fa_middle, fa_bottom)
///@arg halign          수평 정렬(fa_left, fa_middle, fa_right)
///@arg fontId          폰트 리소스 ID (font_normal 또는 font_light)
///@arg xscale          X 스케일
///@arg yscale          Y 스케일
///@arg angle           회전 각도 (라디안)
///@arg reversedRatio   true면 역비율 사용
function draw_text_kl_scale(xPos, yPos, textString, sep, width, alpha, color, valign, halign, fontId, xscale, yscale, angle, reversedRatio = false)
{
    // 1) 그래픽 품질 0 이하면 원본 함수 호출
    if (global.graphics_quality <= 0) 
	{
        draw_text_k_scale(xPos, yPos, textString, sep, width, alpha, color, valign, halign, fontId, xscale, yscale, angle, reversedRatio);
        return;
    }

    // 2) 스케일 결정
    var ratio = reversedRatio ? global.reversed_ratio_by_camera : global.ratio_by_camera;
    var xs    = xscale * ratio;
    var ys    = yscale * ratio;

    // 3) 외곽선용 SDF 폰트 선택
    var sdfFont = fontId;
	if (fontId == font_normal)
	{
		sdfFont = font_normal_outline;
	}
	else if (fontId == font_light)
	{
		sdfFont = font_light_outline;
	}



	draw_set_font(sdfFont);
    draw_set_alpha(alpha);
    draw_set_color(color);

	//위치지정
	if (halign == -1)
	{
		draw_set_halign(fa_left);
	}
	else if (halign == 0)
	{
		draw_set_halign(fa_middle);
	}
	else
	{
		draw_set_halign(fa_right);
	}

	//글씨 드로우
	if (sep > 0)
	{
		if (width < 0)
		{
			draw_text_ext_transformed(xPos,yPos+ys*96,textString,sep,99999,xs,ys,angle);
		}
		else if (width > 0)
		{
			draw_text_ext_transformed(xPos,yPos+ys*96,textString,sep,width,xs,ys,angle);
		}
	}
}
