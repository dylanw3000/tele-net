
//x,y, inner,outer, a_min,a_max, damage, unit

if(instance_exists(oPlayer)){
    //xxplayer = instance_find(oPlayer,0);
    xxplayer = argument7;
    
    if(argument5-argument4 > 2*pi){
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
    
    xxdist = point_distance(argument0,argument1, xxplayer.x,xxplayer.y);
    xxang = arctan2(xxplayer.y-argument1, xxplayer.x-argument0);
    
    xxang1 = arctan2(xxplayer.y-sin(xxang+pi/2)*xxplayer.radius-argument1, 
        xxplayer.x-cos(xxang+pi/2)*xxplayer.radius-argument0);
    xxang2 = arctan2(xxplayer.y+sin(xxang+pi/2)*xxplayer.radius-argument1, 
        xxplayer.x+cos(xxang+pi/2)*xxplayer.radius-argument0);
    
    if((xxdist > argument2-xxplayer.radius && xxdist < argument3+xxplayer.radius)
    && ((xxang2 > argument4 && xxang1 < argument5)
        || xxang1 < argument5 - 2*pi
        || xxang2 > argument4 + 2*pi
        || (xxang2 < xxang1 && ((xxang1-2*pi < argument5 && xxang2 > argument4)
                         || (xxang1 < argument5 && xxang2+2*pi > argument4))
    ))
    //|| xxdist+player.radius > argument2
    ){
        if(argument6 > 0){
            xxplayer.hit += argument6;
        }
        else{
            xxplayer.heal -= argument6;
        }
        return xxang;
    }
    return null;
}



