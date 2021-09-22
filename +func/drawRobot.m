
function drawRobot(state_robot, body, body_line, wheel, wheel_line, ...
    list_light_sensor, light_sensor_points, list_range_sensor, range_sensor_points, ...
    range_detect_points, range_sensor_line, is_light_sensor_visible)

theta = state_robot(3,1);
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];  % rotation mat.

light_sensor_N = size(list_light_sensor,1);
range_sensor_N = size(list_range_sensor,1);

gpos_wheel = zeros(2, 5, 2);
gpos_body  = R * [body; body(1,:)].' + state_robot(1:2,1)*ones(1,5);
gpos_line  = R * list_light_sensor(9,:).' + state_robot(1:2,1)*ones(1,light_sensor_N);
gpos_range = R * list_range_sensor.' + state_robot(1:2,1)*ones(1,range_sensor_N);
gpos_body = gpos_body.';

body_line.XData = gpos_body(:,1);
body_line.YData = gpos_body(:,2);
pm = [1; -1];

for i = 1:2
    gpos_wheel(:,:,i) = R * [wheel(i,:)+[35 pm(i,1)*20]; wheel(i,:)+[-35 pm(i,1)*20]; wheel(i,:)+[-35 0]; wheel(i,:)+[35 0]; wheel(i,:)+[35, pm(i,1)*20]].' + state_robot(1:2,1)*ones(1,5);
    wheel_line(i).XData = gpos_wheel(1,:,i).';
    wheel_line(i).YData = gpos_wheel(2,:,i).';
end

if is_light_sensor_visible
    light_sensor_points.XData = gpos_line(1,:);
    light_sensor_points.YData = gpos_line(2,:);
end

for i = 1:range_sensor_N
    range_sensor_points(i).Position = [gpos_range(1,i) gpos_range(2,i)];
    range_sensor_line(i).XData = [ gpos_range(1,i) range_detect_points(1,i) ];
    range_sensor_line(i).YData = [ gpos_range(2,i) range_detect_points(2,i) ];
    % range_sensor_line(i).Color = 'g';
end
end
