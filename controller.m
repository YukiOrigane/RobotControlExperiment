function u = controller(t, delta_t, value_light_sensor)
    u = [0.4;0];
    if value_light_sensor(1,1) >100
        u = [0;0.4];
    end
    
end