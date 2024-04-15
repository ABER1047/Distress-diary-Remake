
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D displacementMap;
uniform float time;


void main()
{
	vec2 time_offset = vec2(time, -time/2.0)/7.0;
	vec4 displace_col = texture2D(displacementMap, v_vTexcoord + time_offset);
	float brightness = (displace_col.r + displace_col.g + displace_col.b)/3.0 - 0.5;
	
	vec2 offset = vec2(brightness, 0.0)/4.0;
	
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord + offset);
}
