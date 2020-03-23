

[field_size, field_line, field_wall] = setField();

drawInit(field_size);
imshow(field_line, 'DisplayRange', [0 255]);

field_line = field_line.';
field_wall = field_wall.';

state_robot = [200;500;0];  % gposX, gposY, gtheta
control_input = [0.0;0.0];    % dutyR, dutyL (-1.0 ~ +1.0, duty rate

delta_t = 0.01;
N = 500;
t = 0:delta_t:delta_t*(N-1);
t = t.';
q = zeros(N, 3);
u = zeros(N, 2);

body_line = line;

for k = 1:N
    q(k,:) = state_robot;
    u(k,:) = control_input;
    if mod(k,5) == 0    % 20Hz
        value_light_sensor = getLightSensor(state_robot, list_light_sensor, field_line);
        value_range_sensor = getRangeSensor(state_robot, list_range_sensor, field_wall);
        control_input = controller(t(k,1), delta_t, value_light_sensor);
    end
    state_robot = robotSystem(state_robot, control_input, wheel, delta_t);
    drawRobot(state_robot, body, body_line, list_light_sensor);
    pause(delta_t);
    drawnow
end

figure
% plot(t, q(:,3))
plot(t, u(:,1), t, u(:,2));