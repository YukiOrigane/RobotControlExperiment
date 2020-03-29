
function drawRobot(state_robot, body, body_line, list_light_sensor, light_sensor_points,list_range_sensor, range_sensor_points, range_detect_points, range_sensor_line)
    theta = state_robot(3,1);
    light_sensor_N = size(list_light_sensor,1);
    range_sensor_N = size(list_range_sensor,1);
    gpos_body = [cos(theta) -sin(theta); sin(theta) cos(theta)] * [body; body(1,:)].' + state_robot(1:2,1)*ones(1,5);
    gpos_line = [cos(theta) -sin(theta); sin(theta) cos(theta)] * list_light_sensor.' + state_robot(1:2,1)*ones(1,light_sensor_N);
    gpos_range = [cos(theta) -sin(theta); sin(theta) cos(theta)] * list_range_sensor.' + state_robot(1:2,1)*ones(1,range_sensor_N);
    gpos_body = gpos_body.';
    body_line.XData = gpos_body(:,1);
    body_line.YData = gpos_body(:,2);
    for i = 1:light_sensor_N
        light_sensor_points(i).Position = [gpos_line(1,i) gpos_line(2,i)];
    end
    for i = 1:range_sensor_N
        range_sensor_points(i).Position = [gpos_range(1,i) gpos_range(2,i)];
        range_sensor_line(i).XData = [ gpos_range(1,i) range_detect_points(1,i) ];
        range_sensor_line(i).YData = [ gpos_range(2,i) range_detect_points(2,i) ];
        range_sensor_line(i).Color = 'g';
    end
end
