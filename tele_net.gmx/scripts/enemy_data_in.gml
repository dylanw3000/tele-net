
//buffer, unit

switch(argument[1].object_index){
    case oSpin:
        argument[1].ang = buffer_read(argument[0], buffer_f32);
        break;
}

