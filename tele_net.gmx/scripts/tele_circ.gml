
//x,y, inner,outer, a_min,a_max, color, fill

shader_set(shader0);
    xx = shader_get_uniform(shader0, "u_vPos"); //position
    shader_set_uniform_f(xx, argument0, argument1);
    
    xx = shader_get_uniform(shader0, "u_vBounds");  //inner and outer
    shader_set_uniform_f(xx, argument2, argument3);
    
    if(abs(argument5-argument4) >= 2*pi){
        argument4 = -pi;
        argument5 = pi;
    }
    else{
        while(argument4 > pi){
            argument4 -= 2*pi;
            argument5 -= 2*pi;
        }
        while(argument5 < -pi){
            argument4 += 2*pi;
            argument5 += 2*pi;
        }
    }
    xx = shader_get_uniform(shader0, "u_vAngs");  //inner and outer
    shader_set_uniform_f(xx, argument4, argument5);
    
    xx = shader_get_uniform(shader0, "u_vCol1"); //main color
    yy = shader_get_uniform(shader0, "u_vCol2"); //fill color
    if(argument6 == 0){ //red
        shader_set_uniform_f(xx, 0.7, 0.3, 0.3, 0.5);
        shader_set_uniform_f(yy, 0.7, 0.2, 0.2, 0.5);
    }
    else if(argument6 == 1){    //purple
        shader_set_uniform_f(xx, 0.3, 0.1, 0.1, 0.5);
        shader_set_uniform_f(yy, 0.6, 0.3, 0.7, 0.5);
    }
    else if(argument6 == 2){    //green
        shader_set_uniform_f(xx, 0.4, 0.8, 0.4, 0.5);
        shader_set_uniform_f(yy, 0.2, 0.8, 0.3, 0.5);
    }
    else{   //blue
        shader_set_uniform_f(xx, 0.4, 0.4, 0.7, 0.5);
        shader_set_uniform_f(yy, 0.2, 0.2, 0.8, 0.5);
    }
    
    xx = shader_get_uniform(shader0, "u_vFill");  //fill
    shader_set_uniform_f(xx, argument7);
    
    draw_rectangle(argument0-argument3,argument1-argument3,argument0+argument3,argument1+argument3, 0);
shader_reset();

/*
if(debug){
    draw_set_colour($000000);
    draw_rectangle(argument0-argument3,argument1-argument3,argument0+argument3,argument1+argument3, 1);
    
}
*/


