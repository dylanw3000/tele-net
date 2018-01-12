
//buffer, unit

switch(argument[1].object_index){
    case oSpin:
        buffer_write(argument[0], buffer_f32, unit.ang);
        break;
    case oFrost:
        buffer_write(argument[0], buffer_f32, unit.vert);
        buffer_write(argument[0], buffer_f32, unit.horiz);
        break;
    default:
        break;
}

