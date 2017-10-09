
varying float angleIncidence; 
varying vec4 col;

varying vec2 vUv;
varying vec3 vecNormal;
varying vec4 lightDirection;

varying vec3 eyenorm;
uniform vec3 lightpos;
uniform float atmoThickness;
uniform vec3 colorlight;
uniform vec3 colordark; 
//Refer the Text Parse in Main.js, replaced this Sexy Text with Dither Methods,
//I just didnt want it cluttering shizz up
AddDither

void main() 
{
    
    float ndotl = normalize(dot(normalize (vecNormal), normalize (lightDirection.xyz)));

    vec4 finalCol = col * atmoThickness * 2.0;
	//
	//vec4 mainAtmoColor = vec4(colorlight.r/255.0,colorlight.g/255.0,
	// colorlight.b/255.0, angleIncidence);

	vec4 mainAtmoColor = vec4(185.0/255.0, 226.0/255.0, 245.0/255.0, angleIncidence);

	vec4 NoonStartColor = vec4( 135.0/255.0,  206.0/255.0, 235.0, angleIncidence*0.1);


	vec4 NoonFinalColor = vec4( 255.0/255.0,
						        165.0/255.0, 
						         0.0, angleIncidence*0.1);

	float scaler01 = smoothstep(0.25, 1.0, angleIncidence);
	float scaler02 = smoothstep(0.45, 0.51, angleIncidence);

	vec4 lerpTColor = mix(mainAtmoColor, NoonStartColor, scaler01);
	vec4 lerpMColor = mix(lerpTColor, NoonFinalColor, scaler02);

    vec4 ditherresult = vec4(dither(finalCol.rgb), finalCol.a) * lerpMColor;

    gl_FragColor = ditherresult; 
}
