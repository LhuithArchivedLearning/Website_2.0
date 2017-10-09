
//Credit to davidr : https://lightshaderdevlog.wordpress.com/source-code/-->

varying float angleIncidence; 
varying vec4 col;
uniform float fresnelExp;
uniform float transitionWidth; //? Da fleq?

const float PI = 3.14159265359;

varying vec2 vUv;

varying vec3 lightdir;
varying vec3 eyenorm;
varying vec3 vecNormal;
uniform vec3 lightpos;
uniform vec4 skycolor;
varying vec4 lightDirection;

  struct DirectionalLight 
  {
    vec3 direction;
    vec3 color;
    int shadow;
    float shadowBias;
    float shadowRadius;
    vec2 shadowMapSize;
  };

  uniform DirectionalLight directionalLights[ NUM_DIR_LIGHTS ];
  uniform sampler2D directionalShadowMap[ NUM_DIR_LIGHTS ];
  varying vec4 vDirectionalShadowCoord[ NUM_DIR_LIGHTS ];


void main() 
{

   vec4 worldPosition = modelMatrix * vec4( position, 1.0 );
   vec4 vWorldPosition = worldPosition;
	 vecNormal = (modelViewMatrix * vec4(normal, 0.0)).xyz;

    vec4 normalDirection = normalize((modelViewMatrix * vec4(normal, 0.0)));
    vUv = uv;

    lightDirection = normalize(vec4(directionalLights[0].direction, 1.0) );

   vec4 viewDirection = normalize(vec4(cameraPosition, 1.0) - worldPosition);

   angleIncidence = acos(dot(lightDirection, normalDirection)) / PI;

   float shadeFactor = 0.1 * (1.0 - angleIncidence) + 0.9 * 
    (1.0 - (clamp(angleIncidence, 0.5, 0.5 + transitionWidth) - 0.5) 
    / transitionWidth);

   float angleToViewer = clamp(sin(acos(dot(normalDirection, viewDirection))), 0.0, 1.0);

   float perspectiveFactor = 0.3 + 0.2 * pow((angleToViewer), fresnelExp)
     + 0.5 * pow((angleToViewer), fresnelExp * 15.0);

    col = vec4(1.0, 1.0, 1.0, 1.0) * perspectiveFactor * shadeFactor;
 
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
    
}