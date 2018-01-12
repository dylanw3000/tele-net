
//x,y, length,width, angle, color, fill

shader_set(shader1);
    xx = shader_get_uniform(shader1, "u_vPos");
    shader_set_uniform_f(xx, argument0, argument1);
    
    xx = shader_get_uniform(shader1, "u_vSize");
    shader_set_uniform_f(xx, argument2, argument3);
    
    while(argument4 > pi){
        argument4 -= 2*pi;
    }
    while(argument4 < -pi){
        argument4 += 2*pi;
    }
    xx = shader_get_uniform(shader1, "u_fAng");
    shader_set_uniform_f(xx, argument4);
    
    xx = shader_get_uniform(shader0, "u_vCol1"); //main color
    yy = shader_get_uniform(shader0, "u_vCol2"); //fill color
    if(argument5 == 0){
        shader_set_uniform_f(xx, 0.7, 0.3, 0.3, 0.5);
        shader_set_uniform_f(yy, 0.7, 0.2, 0.2, 0.5);
    }
    else{
        shader_set_uniform_f(xx, 0.7, 0.7, 0.4, 0.5);
        shader_set_uniform_f(yy, 0.7, 0.3, 0.3, 0.5);
    }
    
    xx = shader_get_uniform(shader1, "u_fFill");
    shader_set_uniform_f(xx, argument6);
    
    //s_size = sqrt(length*length + width*width);
    //s_size = argument2+argument3;
    
    if(cos(argument4) > 0){
        x1 = argument0-abs(sin(argument4)*argument3/2);
        x2 = argument0+abs(argument2*cos(argument4))+abs(argument3/2*sin(argument4));
    }
    else{
        x1 = argument0-abs(argument2*cos(argument4))-abs(argument3/2*sin(argument4));
        x2 = argument0+abs(sin(argument4)*argument3/2);
    }
    
    if(sin(argument4) > 0){
        y1 = argument1-abs(argument3/2*cos(argument4));
        y2 = argument1+abs(argument2*sin(argument4))+abs(argument3/2*cos(argument4));
    }
    else{
        y1 = argument1-abs(argument2*sin(argument4))-abs(argument3/2*cos(argument4));
        y2 = argument1+abs(argument3/2*cos(argument4));
    }
    //draw_rectangle(argument0-s_size,argument1-s_size, argument0+s_size,argument1+s_size, 0);
    draw_rectangle(
        x1,
        y1, 
        x2,
        y2, 
        0
    );
shader_reset();

if(debug){
draw_set_colour($000000);
    draw_rectangle(
        x1,
        y1, 
        x2,
        y2, 
        1
    );
}


