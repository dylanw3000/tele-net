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
uniform vec2 u_vBounds;
uniform vec2 u_vAngs;
//uniform vec3 u_vCol;
uniform vec4 u_vCol1, u_vCol2;

varying vec2 v_vPosition;

uniform float u_vFill;

void main()
{
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    float xx = v_vPosition.x, yy = v_vPosition.y;
    float dist = sqrt(xx*xx+yy*yy);
    
    float ang = atan(yy,xx);
    
    if((dist > u_vBounds.x && dist < u_vBounds.y) && 
    ((ang > u_vAngs.x && ang < u_vAngs.y) || ang < u_vAngs.y-2.0*3.14159 || ang > u_vAngs.x+2.0*3.14159)
    ){
        gl_FragColor = u_vCol1;
        //gl_FragColor = vec4(0.7, 0.4, 0.4, 0.5);
        if(dist < u_vFill){
            gl_FragColor = u_vCol2;
            //gl_FragColor = vec4(0.7, 0.3, 0.3, 0.5);
        }
    }
    else{
        discard;
    }
}

