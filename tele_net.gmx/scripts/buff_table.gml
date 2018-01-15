
switch(ds_list_find_value(buffs,argument0)){
    case "dash":
        xxdash_dur = ds_list_find_value(buffs,argument0+1);
        xxdash_timer = ds_list_find_value(buffs,argument0+2);
        xxdash_x1 = ds_list_find_value(buffs, argument0+3);
        xxdash_y1 = ds_list_find_value(buffs, argument0+4);
        xxdash_x2 = ds_list_find_value(buffs,argument0+5);
        xxdash_y2 = ds_list_find_value(buffs,argument0+6);
        
        xxdash_timer += d_time;
        //xxdash_timer = xxdash_dur;
        if(xxdash_timer >= xxdash_dur){
            x = xxdash_x2;
            y = xxdash_y2;
            for(i=0; i<7; i++){
                ds_list_delete(buffs, argument0);
            }
            dash = false;
        }
        else{
            x_mod = 0;
            y_mod = 0;
            vert = 0;
            horiz = 0;
            dash = true;
            
            x = xxdash_x1+(xxdash_x2-xxdash_x1)*(xxdash_timer/xxdash_dur);
            y = xxdash_y1+(xxdash_y2-xxdash_y1)*(xxdash_timer/xxdash_dur);
            
            ds_list_replace(buffs, argument0+2, xxdash_timer);
            buff_pointer += 7;
        }
        
        break;
    default:
        break;
}

