
//buffer, unit

switch(argument[1].object_index){
    case oSpin:
        buffer_write(argument[0], buffer_f32, unit.ang);
        break;
    case oFrost:
        buffer_write(argument[0], buffer_f32, unit.vert);
        buffer_write(argument[0], buffer_f32, unit.horiz);
        break;
    case oKiralak:
        buffer_write(argument[0], buffer_f32, unit.init_timer);
        buffer_write(argument[0], buffer_f32, unit.laser_ang);
        buffer_write(argument[0], buffer_f32, unit.pillar_ang);
        buffer_write(argument[0], buffer_f32, unit.explo_timer);
        break;
    default:
        break;
}

