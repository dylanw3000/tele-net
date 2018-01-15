
//buffer, unit

switch(argument[1].object_index){
    case oSpin:
        argument[1].ang = buffer_read(argument[0], buffer_f32);
        break;
    case oKiralak:
        argument[1].init_timer = buffer_read(argument[0], buffer_f32);
        argument[1].laser_ang = buffer_read(argument[0], buffer_f32);
        argument[1].pillar_ang = buffer_read(argument[0], buffer_f32);
        argument[1].explo_timer = buffer_read(argument[0], buffer_f32);
    default:
        break;
}

