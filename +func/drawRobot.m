
function drawRobot(state_robot, body, body_line, wheel, wheel_line, list_light_sensor, light_sensor_points,list_range_sensor, range_sensor_points, range_detect_points, range_sensor_line)
    theta = state_robot(3,1);
    Rot = [cos(theta) -sin(theta); sin(theta) cos(theta)];  % ���{�b�g���W���O���[�o�����W�̉�]�s�� (2*2)
    light_sensor_N = size(list_light_sensor,1);
    range_sensor_N = size(list_range_sensor,1);
    wheel_N = size(wheel, 1);
    gpos_wheel = zeros(2, 5, wheel_N);
    gpos_body = Rot * [body; body(1,:)].' + state_robot(1:2,1)*ones(1,5);
    gpos_line = Rot * list_light_sensor.' + state_robot(1:2,1)*ones(1,light_sensor_N);
    gpos_range = Rot * list_range_sensor.' + state_robot(1:2,1)*ones(1,range_sensor_N);
    gpos_body = gpos_body.';
    body_line.XData = gpos_body(:,1);
    body_line.YData = gpos_body(:,2);
    for i = 1:wheel_N
        % gpos_wheel(:,:,i) = Rot * [wheel(i,1:2)+[35 pm(i,1)*20]; wheel(i,1:2)+[-35 pm(i,1)*20]; wheel(i,1:2)+[-35 0]; wheel(i,1:2)+[35 0]; wheel(i,1:2)+[35, pm(i,1)*20]].' + state_robot(1:2,1)*ones(1,5);
        th_w = wheel(i,3);  % �z�C�[���p
        gpos_wheel(:,:,i) = state_robot(1:2,1)*ones(1,5) + Rot*( wheel(i,1:2).'*ones(1,5) + [cos(th_w) -sin(th_w); sin(th_w) cos(th_w)] * [35 -35 -35 35 35; 10 10 -10 -10 10]);
        wheel_line(i).XData = gpos_wheel(1,:,i).';
        wheel_line(i).YData = gpos_wheel(2,:,i).';
    end
    for i = 1:light_sensor_N
        light_sensor_points(i).Position = [gpos_line(1,i) gpos_line(2,i)];
    end
    for i = 1:range_sensor_N
        range_sensor_points(i).Position = [gpos_range(1,i) gpos_range(2,i)];
        range_sensor_line(i).XData = [ gpos_range(1,i) range_detect_points(1,i) ];
        range_sensor_line(i).YData = [ gpos_range(2,i) range_detect_points(2,i) ];
        % range_sensor_line(i).Color = 'g';
    end
end
