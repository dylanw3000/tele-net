
//x,y, length,width, ang, damage, unit

while(argument4 > pi){
    argument4 -= 2*pi;
}
while(argument4 < -pi){
    argument4 += 2*pi;
}

player = argument6;
//player = instance_find(oPlayer, 0);
xx = player.x-argument0;
yy = player.y-argument1;
//ang = arctan2(yy, xx);

ang1 = arctan2(yy+sin(argument4+pi/2.0)*(argument3/2.0+player.radius),xx+cos(argument4+pi/2.0)*(argument3/2.0+player.radius));
ang2 = arctan2(yy+sin(argument4-pi/2.0)*(argument3/2.0+player.radius),xx+cos(argument4-pi/2.0)*(argument3/2.0+player.radius));

ang3 = arctan2(yy+sin(argument4)*(argument2/2.0+player.radius),xx+cos(argument4)*(argument2/2.0+player.radius)) + pi/2.0;
ang4 = arctan2(yy-sin(argument4)*(argument2/2.0+player.radius),xx-cos(argument4)*(argument2/2.0+player.radius)) + pi/2.0;
   

if(
(ang1 > argument4 && ang1 < argument4+pi || ang1 < argument4-pi)
&& (ang2 < argument4 && ang2 > argument4-pi || ang2 > argument4+pi)
&& (ang3 > argument4 && ang3 < argument4+pi 
    || ang3 < argument4-pi 
    || ang3 > argument4+2.0*pi
)
&& (ang4 < argument4 && ang4 > argument4-pi
    || ang4 > argument4+pi && ang4 < argument4+2.0*pi
)
){
    player.hit += argument5;
    return arctan2(yy,xx);
}

return null;



