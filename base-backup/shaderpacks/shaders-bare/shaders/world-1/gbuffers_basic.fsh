#version 120

/*



			███████ ███████ ███████ ███████ █
			█          █    █     █ █     █ █
			███████    █    █     █ ███████ █
			      █    █    █     █ █
			███████    █    ███████ █       █

	Before you change anything here, please keep varying mind that
	you are allowed to modify my shaderpack ONLY for yourself!

	Please read my agreement for more informations!
		- http://dedelner.net/agreement/



*/

//#define YCoCg_Compression

varying vec4 color;


vec4 toYCoCg(vec4 clr) {

	vec3 YCoCg = vec3(0.0);

	YCoCg.r =  0.25	* clr.r + 0.5 * clr.g + 0.25 * clr.b;
	YCoCg.g =  0.5	* clr.r - 0.5 * clr.b + 0.5;
	YCoCg.b = -0.25	* clr.r + 0.5 * clr.g - 0.25 * clr.b + 0.5;

	bool pattern = mod(gl_FragCoord.x, 2.0) == mod(gl_FragCoord.y, 2.0);

	YCoCg.g = pattern? YCoCg.b : YCoCg.g;

	return vec4(YCoCg, clr.a);

}

void main() {

	vec4 baseColor = color;

	#ifdef YCoCg_Compression
		baseColor = toYCoCg(color);
	#endif


/* DRAWBUFFERS:0 */

  // 0 = gcolor
  // 1 = gdepth
  // 2 = gnormal
  // 3 = composite
  // 4 = gaux1
  // 5 = gaux2
  // 6 = gaux3
  // 7 = gaux4

  gl_FragData[0] = baseColor;

}
