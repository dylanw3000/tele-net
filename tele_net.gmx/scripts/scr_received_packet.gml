
///scr_WAN_received_packet(buffer)
var buffer = argument[0]; //Gets our input value when we execute the script [What our buffer will look like: 1,mouse_x,mouse_y]
var message_id = buffer_read(buffer,buffer_u8); //Reads our Unsigned 8Bit Integer from our buffer. [What our buffer will look like: mouse_x,mouse_y] We remove the 1 because when a buffer reads information, it removes that id from the buffer.

//You set which buffer ID you want to send information with. Maybe buffer id 1 sends mouse_x and mouse_y, id 2 sends Damage, id 3 sends health, etc.
switch(message_id) {
    case 1: //If our message ID is equal to 1.
        var mx = buffer_read(buffer,buffer_u16); //Reads our unsigned 16 Bit Integer from our buffer and assigns it to the variable mx. [Buffer equals: mouse_y] -We deleted our mouse_x from the buffer upon reading it
        var my = buffer_read(buffer,buffer_u16); //Reads our unsigned 16 Bit Integer from our buffer and assigns it to the variable my. [Buffer equals:] -We deleted out mouse_y from the buffer upon reading it.
        //Create the click instance on our server
        //instance_create(mx,my,oClick);
        //x = mx;
        //y = my;
        //Send data back to clients
        buffer_seek(buffer_out, buffer_seek_start, 0);
        buffer_write(buffer_out, buffer_u8, 101);
        //buffer_write(buffer_out, buffer_string, "ayy");
        buffer_write(buffer_out, buffer_u16, mx);
        buffer_write(buffer_out, buffer_u16, my);
        for(i=0; i<ds_list_size(client_sockets); i++){
            network_send_packet(ds_list_find_value(client_sockets,i),buffer_out,buffer_tell(buffer_out));
        }
        //str = async_load[? "id"];
        break;
    case 2:
        sock = noone;
        //sock = ds_list_find_index(client_sockets, async_load[? "socket"]);
        /*for(i=0; i<ds_list_size(client_sockets); i++){
            if(ds_list_find_value(client_sockets,i) == async_load[? "id"]){
                sock = i;
                break;
            }
        }*/
        unit = client_units[? async_load[? "id"]];
        external = true;
        for(i=0; i<ds_list_size(local_players); i++){
            if(ds_list_find_value(local_players, i) == unit){
                external = false;
                break;
            }
        }
        //str = sock;
        ux = buffer_read(buffer, buffer_f32);
        uy = buffer_read(buffer, buffer_f32);
        
        if(external){
            unit.x = ux;
            unit.y = uy;
            unit.horiz = buffer_read(buffer, buffer_f32);
            unit.vert = buffer_read(buffer, buffer_f32);
            unit.hp = buffer_read(buffer, buffer_f32);
        }
        
        break;
    case 3: //primary
        external = true;
        for(pno=0; pno<ds_list_size(local_players); pno++){
            if(ds_list_find_value(local_players, pno) == unit){
                external = false;
                break;
            }
        }
        if(external){
            unit = client_units[? async_load[? "id"]];
            unit.primary_timer = buffer_read(buffer, buffer_f32);
            unit.primary_ang = buffer_read(buffer, buffer_f32);
            unit.primary = true;
        }
        
        break;
    case 4: //allies healed
        usock = buffer_read(buffer, buffer_u16);
        unit = noone;
        for(i=0; i<instance_number(oAlly); i++){
            tmp = instance_find(oAlly,i);
            if(tmp.socket_no == usock){
                unit = tmp;
                break;
            }
        }
        if(instance_exists(unit)){
            unit.heal = buffer_read(buffer, buffer_f32);
        }
        else{
            player.heal = buffer_read(buffer, buffer_f32);
        }
        break;
        
    case 5: //ally class change
        unit = client_units[? async_load[? "id"]];
        unit.class = buffer_read(buffer, buffer_u8);
        with(unit){
            class_sheet(class);
        }
        
        buffer_seek(buffer_out, buffer_seek_start, 0);
        buffer_write(buffer_out, buffer_u8, 103);
        //ds_list_find_index(client_sockets, unit);
        buffer_write(buffer_out, buffer_u16, unit.socket_no);
        buffer_write(buffer_out, buffer_u8, unit.class);
        
        for(i=0; i<ds_list_size(client_sockets); i++){
            network_send_packet(ds_list_find_value(client_sockets,i),buffer_out,buffer_tell(buffer_out));
        }
        
        break;
}

