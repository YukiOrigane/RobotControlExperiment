function u = controller(t, delta_t, value_light_sensor)
    u = [0;0];
    if t>0 & t<1
        u = [0.8;0.8];
    end
    
end