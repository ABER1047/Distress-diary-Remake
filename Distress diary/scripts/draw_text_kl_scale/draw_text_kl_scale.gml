/// draw_text_kl_scale 함수에서 전역 폰트 선택 로직
function draw_text_kl_scale(argument0, argument1, string, sep, w, alpha, color, valign, halign, font, xscale, yscale, angle, reversed_ratio) {
    // 그래픽 품질이 0 이하일 때는 기존 draw_text_k_scale 사용
    if (global.graphics_quality <= 0) {
        draw_text_k_scale(argument0, argument1, string, sep, w, alpha, color, valign, halign, font, xscale, yscale, angle, reversed_ratio);
        return;
    }

    // ratio 선택
    var tmp_scale = (reversed_ratio != undefined) ? global.reversed_ratio_by_camera : global.ratio_by_camera;
    var txt_xscale = xscale * tmp_scale;
    var txt_yscale = yscale * tmp_scale;

    // 폰트 리소스가 font_normal인지 font_light인지를 체크해 전역 외곽선 폰트를 설정
    var sdf_font = (font == font_light) ? global.outlined_font_light : global.outlined_font_normal;
    draw_set_font(sdf_font);
    draw_set_alpha(alpha);

    // 정렬 설정
    if (halign == -1)      draw_set_halign(fa_left);
    else if (halign == 0)  draw_set_halign(fa_middle);
    else                   draw_set_halign(fa_right);

    // 컬러 설정
    draw_set_color(color);

    // 텍스트 렌더링
    var draw_y = argument1 + txt_yscale * 32;
    if (string != "") {
        if (sep > 0) {
            draw_text_ext_transformed(argument0, draw_y, string, sep, w < 0 ? 99999 : w, txt_xscale, txt_yscale, angle);
        } else {
            draw_text_transformed(argument0, draw_y, string, txt_xscale, txt_yscale, angle);
        }
    }
}
