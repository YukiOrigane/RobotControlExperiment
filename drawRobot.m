
function drawRobot(state_robot, body, body_line, list_light_sensor)
    theta = state_robot(3,1);
    gpos_body = [cos(theta) -sin(theta); sin(theta) cos(theta)] * [body; body(1,:)].' + state_robot(1:2,1)*ones(1,5);
    gpos_body = gpos_body.';
    body_line.XData = gpos_body(:,1);
    body_line.YData = gpos_body(:,2);
    % line(gpos_body(:,1), gpos_body(:,2));
end
