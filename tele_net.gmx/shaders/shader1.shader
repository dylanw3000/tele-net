//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_vPos;

varying vec2 v_vPosition;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    
    v_vPosition = in_Position.xy-u_vPos.xy;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_vPos;
uniform vec2 u_vSize;
uniform vec4 u_vCol1, u_vCol2;

uniform float u_fAng;
uniform float u_fFill;

varying vec2 v_vPosition;

void main()
{
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    float xx = v_vPosition.x, yy = v_vPosition.y;
    
    /*
    if(abs(xx)-abs(yy) != 0.0){
        float u_vSize.x = abs(abs(xx)-abs(yy));
    }
    */
    
    //vec2 u_vSize = vec2(20.0, 30.0);
    
    float pi = 3.14159;
    
    float ang1 = atan(yy+sin(u_fAng+pi/2.0)*u_vSize.y/2.0,xx+cos(u_fAng+pi/2.0)*u_vSize.y/2.0);
    float ang2 = atan(yy+sin(u_fAng-pi/2.0)*u_vSize.y/2.0,xx+cos(u_fAng-pi/2.0)*u_vSize.y/2.0);
    
    float ang3 = atan(yy,xx) + pi/2.0;
    float ang4 = atan(yy-sin(u_fAng)*u_vSize.x,xx-cos(u_fAng)*u_vSize.x) + pi/2.0;
    float ang_fill = atan(yy-sin(u_fAng)*u_fFill, xx-cos(u_fAng)*u_fFill) + pi/2.0;
    
    
    if(
    (ang1 > u_fAng && ang1 < u_fAng+pi || ang1 < u_fAng-pi)
    && (ang2 < u_fAng && ang2 > u_fAng-pi || ang2 > u_fAng+pi)
    && (ang3 > u_fAng && ang3 < u_fAng+pi 
        || ang3 < u_fAng-pi 
        || ang3 > u_fAng+2.0*pi
    )
    && (ang4 < u_fAng && ang4 > u_fAng-pi
        || ang4 > u_fAng+pi && ang4 < u_fAng+2.0*pi
    )
    ){
        //gl_FragColor = vec4(0.7, 0.3, 0.3, 0.5);
        gl_FragColor = u_vCol1;
        if(ang_fill < u_fAng && ang_fill > u_fAng-pi || ang_fill > u_fAng+pi && ang_fill < u_fAng+2.0*pi){
            //gl_FragColor = vec4(.7, .2, .2, .5);
            gl_FragColor = u_vCol2;
        }
    }
    else{
        discard;
    }
}

